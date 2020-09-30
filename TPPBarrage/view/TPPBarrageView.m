//
//  TPPBarrageView.m
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <ZLCollectionViewFlowLayout/ZLCollectionViewFlowLayout-umbrella.h>
#import <Masonry/Masonry.h>

#import "TPPBarrageView.h"
#import "TPPBarrageCell.h"

/** base */
@interface TPPBarrageView ()

@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) NSInteger rows;
@property (assign, nonatomic) TPPBarrageViewType type;

@property (strong, nonatomic) CADisplayLink *link;

@end

/** CollectionView style */
@interface TPPBarrageCollectionView : TPPBarrageView
<UICollectionViewDataSource,
ZLCollectionViewBaseFlowLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger count;

@end

/** tagView style */
@interface TPPBarrageTagView : TPPBarrageView

@property (strong, nonatomic) NSMutableArray<TPPBarrageContentView *> *displayViews;
@property (strong, nonatomic) NSMutableSet<TPPBarrageContentView *> *cacheViews;
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSNumber *> *idxMap;

@end

/** base */
@implementation TPPBarrageView

- (instancetype)initWithFont:(UIFont *)font rows:(NSInteger)rows type:(TPPBarrageViewType)type {
    if (type == TPPBarrageViewType_CollectionView) {
        return [[TPPBarrageCollectionView alloc] initWithFont:font rows:rows type:type];
    }
    else if (type == TPPBarrageViewType_TagView) {
        return [[TPPBarrageTagView alloc] initWithFont:font rows:rows type:type];
    }
    
    return nil;
}

#pragma mark - Abstrcut Methond

- (void)setData:(NSArray<TPPBarrageModel *> *)data {
    _data = data;
}

- (void)setSpeed:(CGFloat)speed {
    _speed = speed < 0 ? 0 : speed;
}

- (void)play {
    
}

- (BOOL)isPause {
    return NO;
}

- (void)pause {
    
}

- (void)linkAction:(CADisplayLink *)sender {
    
}

#pragma mark -

- (NSInteger)rows {
    if (!_rows) {
        _rows = 1;
    }
    
    return _rows;
}

- (CADisplayLink *)link {
    if (!_link) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkAction:)];
        [link addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
        link.preferredFramesPerSecond = 60;
        link.paused = YES;
        
        _link = link;
    }
    
    return _link;
}

- (CGFloat)hSpace {
    return 16;
}

@end

/** CollectionView style */
@implementation TPPBarrageCollectionView

- (instancetype)initWithFont:(UIFont *)font rows:(NSInteger)rows type:(TPPBarrageViewType)type {
    if (self = [super initWithFrame:CGRectZero]) {
        self.type = type;
        self.font = font;
        self.rows = rows < 1 ? 1 : rows;
        
        //
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];
        self.collectionView.backgroundColor = UIColor.lightGrayColor;
//        self.collectionView.userInteractionEnabled = NO;
        
        //
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
//        [self addGestureRecognizer:pan];
    }
    
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, self.collectionView.bounds.size.width, 0, self.collectionView.bounds.size.width);
//}

#pragma mark -

- (void)setData:(NSArray<TPPBarrageModel *> *)data {
    [super setData:data];
    self.count = self.data.count * 10;
    
    [self.collectionView reloadData];
}

- (void)setSpeed:(CGFloat)speed {
    [super setSpeed:speed];
}

- (void)play {
    self.link.paused = NO;
}

- (BOOL)isPause {
    return self.link.isPaused;
}

- (void)pause {
    self.link.paused = YES;
}

- (void)linkAction:(CADisplayLink *)sender {
    if (self.speed <= 0) {
        return;
    }
    
    CGSize contentSize = self.collectionView.contentSize;
    CGPoint offset1 = self.collectionView.contentOffset;
    CGFloat minX = self.minX;
    CGFloat x = offset1.x + self.speed;
    CGFloat y = offset1.y;
    if (x < minX) {
        x = minX;
    }
    if (x >= contentSize.width) {
        x = self.isRepeat ? minX : contentSize.width;
    }
    CGPoint offset = CGPointMake(x, y);
    
//    NSLog(@"offset: %@", self.offsetObj);
    
    [self.collectionView setContentOffset:offset animated:NO];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,ZLCollectionViewBaseFlowLayoutDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TPPBarrageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSInteger index = indexPath.item % self.data.count;
    [cell setModel:self.data[index] font:self.font];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(ZLCollectionViewBaseFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item % self.data.count;
    CGFloat w = [TPPBarrageCell widthWithTextWidth:self.data[index].textWidth] + self.hSpace;
    CGFloat h = collectionView.bounds.size.height / self.rows;
    
    return CGSizeMake(w, h);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString : UICollectionElementKindSectionHeader]){
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.backgroundColor = UIColor.clearColor;
        return view;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(ZLCollectionViewBaseFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.bounds.size.width, collectionView.frame.size.height);
}

#pragma mark -

- (void)panAction:(UIPanGestureRecognizer *)sender {
    
}

#pragma mark -

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ZLCollectionViewHorzontalLayout* layout = [[ZLCollectionViewHorzontalLayout alloc]init];
        layout.delegate = self;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.layoutType = ColumnLayout;
        layout.columnCount = self.rows;
        
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:TPPBarrageCell.class forCellWithReuseIdentifier:@"cell"];
        [view registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        view.showsHorizontalScrollIndicator = NO;
        view.backgroundColor = UIColor.clearColor;
        
        _collectionView = view;
    }
    return _collectionView;
}

- (CGFloat)minX {
    return 0;
}

@end

@implementation TPPBarrageTagView

- (instancetype)initWithFont:(UIFont *)font rows:(NSInteger)rows type:(TPPBarrageViewType)type {
    if (self = [super initWithFrame:CGRectZero]) {
        self.type = type;
        self.font = font;
        self.rows = rows < 1 ? 1 : rows;
        
        //
        self.backgroundColor = UIColor.lightGrayColor;
        
        //
        self.link.preferredFramesPerSecond = 1;
    }
    
    return self;
}

#pragma mark -

- (void)setData:(NSArray<TPPBarrageModel *> *)data {
    [super setData:data];
    
    NSLog(@"%@", data);
    
    [self reloadData];
}

- (void)setSpeed:(CGFloat)speed {
    [super setSpeed:speed];
}

- (void)play {
    self.link.paused = NO;
}

- (BOOL)isPause {
    return self.link.isPaused;
}

- (void)pause {
    self.link.paused = YES;
}

- (void)linkAction:(CADisplayLink *)sender {
    if (self.speed <= 0) {
        return;
    }
    
    //
    [self.displayViews enumerateObjectsUsingBlock:^(TPPBarrageContentView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        CGRect frame = CGRectMake(obj.frame.origin.x - self.speed, obj.frame.origin.y, obj.frame.size.width, obj.frame.size.height);

        [UIView animateWithDuration:1 animations:^{
            obj.frame = frame;
        } completion:^(BOOL finished) {
            if (CGRectGetMaxX(frame) < 0) {
                obj.alpha = 0;
                [self.displayViews removeObject:obj];
                [self.cacheViews addObject:obj];
            }
        }];

    }];
    
    //
    NSInteger maxCount = 100;
    if (self.displayViews.count >= maxCount) {
        return;
    }
    
    TPPBarrageContentView *lastView = self.displayViews.lastObject;
    NSString *lastViewId = lastView.model.id;
    NSInteger lastViewIndex = lastViewId ? self.idxMap[lastViewId].integerValue : NSNotFound;
    
    for (NSInteger i = lastViewIndex == NSNotFound ? 0 : (lastViewIndex + 1); i < maxCount-self.displayViews.count; i++) {
        NSInteger index = i % self.data.count;
        TPPBarrageModel *model = self.data[index];
        TPPBarrageContentView *view = self.cacheViews.anyObject;
        if (!view) {
            view = [[TPPBarrageContentView alloc] initWithFrame:CGRectZero];
            [self addSubview:view];
        }
        [self resetBarrageContentView:view model:model];
        view.alpha = 1;
        [self.displayViews addObject:view];
        [self.cacheViews removeObject:view];
    }
}

#pragma mark -

- (void)reloadData {
    [self.idxMap removeAllObjects];
    [self.data enumerateObjectsUsingBlock:^(TPPBarrageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.idxMap[obj.id] = @(idx);
    }];
    
    [self.displayViews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.displayViews removeAllObjects];
}

#pragma mark -

- (void)resetBarrageContentView:(TPPBarrageContentView *)view model:(TPPBarrageModel *)model {
    [view setModel:model font:self.font];
    
    CGFloat w = [TPPBarrageContentView widthWithTextWidth:model.textWidth] + self.hSpace;
    CGFloat h = self.bounds.size.height / self.rows;
    CGFloat hSpace = self.hSpace;
    
//    TPPBarrageContentView *lastView = self.displayViews.lastObject;
//    view.frame = CGRectMake(CGRectGetMaxX(lastView.frame), CGRectGetMinY(lastView.frame), w, h);
//    return;
    
    // 第一列
    if (self.displayViews.count < self.rows) {
        TPPBarrageContentView *lastView = self.displayViews.lastObject;
        view.frame = CGRectMake(CGRectGetMinX(lastView.frame), CGRectGetMaxY(lastView.frame), w, h);
        
    } else {
        // 其他列
        NSMutableArray<NSValue *> *rectObjs = NSMutableArray.array;
        [self.displayViews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [rectObjs addObject:[NSValue valueWithCGRect:obj.frame]];
        }];
        
        NSArray<NSValue *> *arr1 = [rectObjs sortedArrayUsingComparator:^NSComparisonResult(NSValue*  _Nonnull obj1, NSValue*  _Nonnull obj2) {
            return CGRectGetMaxX(obj1.CGRectValue) - CGRectGetMaxX(obj2.CGRectValue);
        }];
        
        CGRect rect = [(arr1.count >= self.rows ? [arr1 subarrayWithRange:NSMakeRange(arr1.count - self.rows, self.rows)] : arr1) sortedArrayUsingComparator:^NSComparisonResult(NSValue*  _Nonnull obj1, NSValue*  _Nonnull obj2) {
            return CGRectGetMaxX(obj1.CGRectValue) - CGRectGetMaxX(obj2.CGRectValue);
        }].firstObject.CGRectValue;
        
        CGRect r = CGRectMake(CGRectGetMaxX(rect) + hSpace, CGRectGetMinY(rect), w, h);
        view.frame = r;
        
    }
}

- (NSMutableArray<TPPBarrageContentView *> *)displayViews {
    if (!_displayViews) {
        _displayViews = NSMutableArray.array;
    }
    return _displayViews;
}

- (NSMutableSet<TPPBarrageContentView *> *)cacheViews {
    if (!_cacheViews) {
        _cacheViews = NSMutableSet.set;
    }
    return _cacheViews;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)idxMap {
    if (!_idxMap) {
        _idxMap = NSMutableDictionary.dictionary;
    }
    return _idxMap;
}

@end

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

typedef NS_ENUM(NSInteger, TPPBarrageViewType) {
    TPPBarrageViewType_CollectionView,
    TPPBarrageViewType_TagView,
};

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
@property (assign, nonatomic) CGPoint panPoint;
@property (strong, nonatomic) UIPanGestureRecognizer *pan;
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

/** base */
@implementation TPPBarrageView

- (instancetype)initWithFont:(UIFont *)font rows:(NSInteger)rows {
    return [[self.class alloc] initWithFont:font rows:rows type:(TPPBarrageViewType_CollectionView)];
}

- (instancetype)initWithFont:(UIFont *)font rows:(NSInteger)rows type:(TPPBarrageViewType)type {
    if (type == TPPBarrageViewType_CollectionView) {
        return [[TPPBarrageCollectionView alloc] initWithFont:font rows:rows type:type];
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
        self.collectionView.userInteractionEnabled = NO;
        
        //
        self.canDrag = NO;
    }
    
    return self;
}

#pragma mark -

- (void)setData:(NSArray<TPPBarrageModel *> *)data {
    [super setData:data];
    
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

- (void)setCanDrag:(BOOL)canDrag {
    [super setCanDrag:canDrag];
    
    //
    self.pan.enabled = canDrag;
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

    [UIView animateWithDuration:1.0/60 animations:^{
        [self.collectionView setContentOffset:offset animated:NO];
    }];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,ZLCollectionViewBaseFlowLayoutDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
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
    CGPoint point = [sender locationInView:sender.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self pause];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + (-(point.x - self.panPoint.x)), self.collectionView.contentOffset.y) animated:NO];
    } else {
        [self play];
    }

    self.panPoint = point;
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.collectionView];
    if (!self.onClickItemBlock) {
        return;
    }
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if (indexPath &&
        self.data.count > indexPath.item) {
        self.onClickItemBlock(self, self.data[indexPath.item]);
    }
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

- (UIPanGestureRecognizer *)pan {
    if (!_pan) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        [pan requireGestureRecognizerToFail:self.tap];
        
        _pan = pan;
    }
    return _pan;
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:_tap];
    }
    return _tap;
}

- (CGFloat)minX {
    return 0;
}

@end


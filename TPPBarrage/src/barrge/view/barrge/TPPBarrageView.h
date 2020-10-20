//
//  TPPBarrageView.h
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TPPBarrgeHeader.h"

#import "TPPBarrageModel.h"
#import "TPPBarrageCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPPBarrageView : UIView

@property (copy, nonatomic) NSArray<TPPBarrageModel *> *data;
/** 弹幕速度，defualt: 0 point/s， 建议50 */
@property (assign, nonatomic) CGFloat speed;
/** 是否重复播放， default: NO */
@property (assign, nonatomic) BOOL isRepeat;
/** 是否能拖动， default: NO */
@property (assign, nonatomic) BOOL canDrag;
/** 弹幕点击事件， on click item */
@property (copy, nonatomic) void (^ onClickItemBlock) (TPPBarrageView *view, TPPBarrageModel *model, NSInteger idx);

/** font: 弹幕字体大小,
 rows: 最大行数 */
- (instancetype)initWithRows:(NSInteger)rows;
/** default: 1 */
- (NSInteger)rows;

- (void)play;
- (BOOL)isPause;
- (void)pause;

@end

@interface TPPBarrageView (CollectionViewStyle)

/** 自定义cell的注册接口， cell class: kind of UICollectionView<TPPBarrageContentViewProtocol> */
- (void)registCell:(Class)cls;
- (Class)cellCls;

@end

NS_ASSUME_NONNULL_END

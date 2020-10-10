//
//  TPPBarrageView.h
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TPPBarrageModel.h"
#import "TPPBarrageCell.h"

#ifdef DEBUG
#define TPPBarrageViewLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define TPPBarrageViewLog(format, ...)
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TPPBarrageView : UIView

@property (weak, nonatomic) NSArray<TPPBarrageModel *> *data;
/** default: 0 point / s */
@property (assign, nonatomic) CGFloat speed;
/** default: NO */
@property (assign, nonatomic) BOOL isRepeat;
/** default: NO */
@property (assign, nonatomic) BOOL canDrag;
/** default: NO (是否实行两次数据无缝对接)*/
@property (assign, nonatomic) BOOL isSeamless;
/** on click item */
@property (copy, nonatomic) void (^ onClickItemBlock) (TPPBarrageView *view, TPPBarrageModel *model);

- (instancetype)initWithFont:(UIFont *)font rows:(NSInteger)rows;
- (UIFont *)font;
/** default: 1 */
- (NSInteger)rows;

- (void)play;
- (BOOL)isPause;
- (void)pause;

@end

@interface TPPBarrageView (CollectionViewStyle)

/** cell class: kind of UICollectionView<TPPBarrageContentViewProtocol> */
- (void)registCell:(Class)cls;
- (Class)cellCls;

@end

NS_ASSUME_NONNULL_END

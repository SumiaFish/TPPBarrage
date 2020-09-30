//
//  TPPBarrageView.h
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TPPBarrageModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TPPBarrageViewType) {
    TPPBarrageViewType_CollectionView,
    TPPBarrageViewType_TagView,
};

@interface TPPBarrageView : UIView

@property (weak, nonatomic) NSArray<TPPBarrageModel *> *data;
/** default: 0 point / s */
@property (assign, nonatomic) CGFloat speed;
/** default: NO */
@property (assign, nonatomic) BOOL isRepeat;
/** default: NO */
@property (assign, nonatomic) BOOL canDrag;

- (instancetype)initWithFont:(UIFont *)font rows:(NSInteger)rows type:(TPPBarrageViewType)type;
- (UIFont *)font;
/** default: 1 */
- (NSInteger)rows;
- (TPPBarrageViewType)type;

- (void)play;
- (BOOL)isPause;
- (void)pause;

@end

NS_ASSUME_NONNULL_END

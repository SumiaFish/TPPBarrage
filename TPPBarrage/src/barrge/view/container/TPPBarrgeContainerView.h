//
//  TPPBarrgeContainerView.h
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TPPBarrageView.h"
#import "TPPBarrgeHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPPBarrgeContainerView : UIView

- (instancetype)initWithRows:(NSInteger)rows;

- (TPPBarrgeHeaderView *)headerView;
- (TPPBarrageView *)barrageView;
- (UIView *)bgView;

@end

NS_ASSUME_NONNULL_END

//
//  TPPBarrgeHeaderView.h
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TPPBarrgeHeader.h"

#import "TPPBarrageHeaderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPPBarrgeHeaderView : UIView

@property (strong, nonatomic, readonly) UIView *avatarsContainerView;
@property (strong, nonatomic, readonly) UILabel *onlineLab;

@property (strong, nonatomic) TPPBarrageHeaderModel *model;

+ (CGFloat)width:(TPPBarrageHeaderModel *)model;

@end

NS_ASSUME_NONNULL_END

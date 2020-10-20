//
//  TPPBarrageHeaderModel.h
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPPBarrageHeaderModel : NSObject

@property (copy, nonatomic) NSArray<NSString *> *avatars;
@property (assign, nonatomic) NSInteger onlineTotalCount;
@property (strong, nonatomic) NSAttributedString *onlineTotalAttText;

@end

NS_ASSUME_NONNULL_END

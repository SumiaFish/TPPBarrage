//
//  TPPBarrageModel.h
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPPBarrageModel : NSObject

@property (copy, nonatomic, readonly) NSString *id;
@property (copy, nonatomic, nullable) NSString *userId;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *avatar;


@property (strong, nonatomic) UIFont *font;
- (CGFloat)textWidth;

@end

NS_ASSUME_NONNULL_END

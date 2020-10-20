//
//  TPPBarrageModel.h
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPPBarrgeHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPPBarrageModel : NSObject

@property (copy, nonatomic, readonly) NSString *id;
@property (copy, nonatomic, nullable) NSString *userId;
@property (strong, nonatomic) NSAttributedString *attText;
@property (copy, nonatomic) NSString *avatar;

@end

NS_ASSUME_NONNULL_END

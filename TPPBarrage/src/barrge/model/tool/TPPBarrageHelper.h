//
//  TPPBarrageHelper.h
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPPBarrageHelper : NSObject

+ (UIColor *)colorWithHexString: (NSString *)color;

+ (CGFloat)text:(NSString *)text widthWithFont:(UIFont *)font;

+ (CGFloat)attText:(NSAttributedString *)attText;

@end

NS_ASSUME_NONNULL_END

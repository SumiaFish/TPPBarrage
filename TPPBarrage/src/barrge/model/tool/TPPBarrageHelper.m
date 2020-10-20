//
//  TPPBarrageHelper.m
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import "TPPBarrageHelper.h"

@implementation TPPBarrageHelper

+ (UIColor *)colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (CGFloat)text:(NSString *)text widthWithFont:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size.width + 1;
}

+ (CGFloat)attTextWidth:(NSAttributedString *)attText {
    if (!attText.string.length) {
        return 0;
    }
    
    __block UIFont *font = nil;
    [attText enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attText.string.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:UIFont.class]) {
            font = value;
            *stop = YES;
        }
    }];
    if (!font) {
        return 0;
    }
    
    CGRect rect = [attText boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    return rect.size.width + 1;
}

@end

//
//  TPPBarrageHeaderModel.m
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import "TPPBarrageHeaderModel.h"

@interface TPPBarrageHeaderModel ()

@property (copy, nonatomic) NSNumber *textWidthObj;

@end

@implementation TPPBarrageHeaderModel

- (void)setFont:(UIFont *)font {
    _font = font;
    
    if (!self.text.length ||
        !font) {
        return;
    }
    
    //
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil];
    self.textWidthObj = @(rect.size.width + 1);
}

- (CGFloat)textWidth {
    return self.textWidthObj.doubleValue;
}

- (NSString *)text {
    return self.onlineTotalAttText.string;
}

@end

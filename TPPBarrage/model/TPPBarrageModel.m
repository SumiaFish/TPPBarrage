//
//  TPPBarrageModel.m
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <YYModel/YYModel.h>

#import "TPPBarrageModel.h"

@interface TPPBarrageModel ()

@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSNumber *textWidthObj;

@end

@implementation TPPBarrageModel

- (NSString *)id {
    return self.Id;
}

- (NSString *)Id {
    if (!_Id) {
        _Id = NSUUID.UUID.UUIDString;
    }
    return _Id;
}

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

- (NSString *)description {
    return self.text;
}

@end

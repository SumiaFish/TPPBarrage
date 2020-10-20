//
//  NSAttributedString+TPPBarrageTextSize.m
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import <objc/runtime.h>

#import "NSAttributedString+TPPBarrageTextSize.h"

#import "TPPBarrageHelper.h"

@implementation NSAttributedString (TPPBarrageTextSize)

static void* NSAttributedStringTppBarrageTextWidthObjKey = "NSAttributedStringTppBarrageTextWidthObjKey";

- (void)setTppBarrageTextWidthObj:(NSNumber *)tppBarrageTextWidthObj {
    objc_setAssociatedObject(self, &NSAttributedStringTppBarrageTextWidthObjKey, tppBarrageTextWidthObj, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)tppBarrageTextWidthObj {
    return objc_getAssociatedObject(self, &NSAttributedStringTppBarrageTextWidthObjKey);
}

- (CGFloat)tppBarrage_TextWidth {
    NSNumber *res = self.tppBarrageTextWidthObj;
    if (res) {
        return res.doubleValue;
    }
    
    CGFloat w = [TPPBarrageHelper attTextWidth:self];
    res = @(w);
    self.tppBarrageTextWidthObj = res;
    return res.doubleValue;
}

@end

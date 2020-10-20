//
//  TPPBarrageCell.h
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TPPBarrageModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TPPBarrageContentViewProtocol <NSObject>

- (void)setModel:(TPPBarrageModel * _Nullable)model;
- (TPPBarrageModel * _Nullable)model;

+ (CGFloat)widthWithTextWidth:(CGFloat)textWidth;

@end

@interface TPPBarrageContentView : UIView
<TPPBarrageContentViewProtocol>

@end

@interface TPPBarrageCell : UICollectionViewCell
<TPPBarrageContentViewProtocol>

@end

NS_ASSUME_NONNULL_END

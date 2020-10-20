//
//  TPPBarrgeHeader.h
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#ifndef TPPBarrgeHeader_h
#define TPPBarrgeHeader_h

#ifdef DEBUG
#define TPPBarrageLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define TPPBarrageLog(format, ...)
#endif

#import <ZLCollectionViewFlowLayout/ZLCollectionViewFlowLayout-umbrella.h>
#import <Masonry/Masonry.h>
#import <UIImageView+WebCache.h>

#import "TPPBarrageHelper.h"
#import "NSAttributedString+TPPBarrageTextSize.h"

#endif /* TPPBarrgeHeader_h */

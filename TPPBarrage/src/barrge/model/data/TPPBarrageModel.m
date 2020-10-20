//
//  TPPBarrageModel.m
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "TPPBarrageModel.h"

@interface TPPBarrageModel ()

@property (copy, nonatomic, readwrite) NSString *id;

@end

@implementation TPPBarrageModel

- (NSString *)id {
    if (!_id) {
        _id = NSUUID.UUID.UUIDString;
    }
    return _id;
}

@end

//
//  PMPhotographer.m
//  PhotoMania
//
//  Created by huang-kun on 16/8/19.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "PMPhotographer.h"

@implementation PMPhotographer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _fullname = [dictionary[@"fullname"] copy];
        _avatarSmallURLStr = [dictionary[@"avatars"][@"small"][@"https"] copy];
    }
    return self;
}

@end

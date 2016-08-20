//
//  PMPhoto.m
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "PMPhoto.h"

@implementation PMPhoto

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _photographer = [[PMPhotographer alloc] initWithDictionary:dictionary[@"user"]];
        _name = [dictionary[@"name"] copy];
        _photographerName = [dictionary[@"user"][@"username"] copy];
        _thumbURLStr = [[dictionary[@"image_url"] firstObject] copy];
    }
    return self;
}

@end
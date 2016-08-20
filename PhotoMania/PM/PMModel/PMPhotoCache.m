//
//  PMPhotoCache.m
//  PhotoMania
//
//  Created by huang-kun on 16/8/18.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "PMPhotoCache.h"

@interface PMPhotoCache ()
@property (nonatomic, strong) NSMutableDictionary *backingCache;
@end

@implementation PMPhotoCache

+ (instancetype)sharedCache {
    static PMPhotoCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [PMPhotoCache new];
        cache.backingCache = [NSMutableDictionary new];
        // clean up for low memory condition
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:UIApplication.sharedApplication] subscribeNext:^(id x) {
            [cache.backingCache removeAllObjects];
        }];
    });
    return cache;
}

- (void)setObject:(nullable id)obj forKeyedSubscript:(id <NSCopying>)key {
    @synchronized (self) {
        self.backingCache[key] = obj;
    }
}

- (nullable id)objectForKeyedSubscript:(id)key {
    return self.backingCache[key];
}

@end

//
//  PMPhotoCache.h
//  PhotoMania
//
//  Created by huang-kun on 16/8/18.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMPhotoCache <__covariant KeyType, __covariant ObjectType> : NSObject

+ (instancetype)sharedCache;

- (void)setObject:(nullable ObjectType)obj forKeyedSubscript:(KeyType <NSCopying>)key;
- (nullable ObjectType)objectForKeyedSubscript:(KeyType)key;

@end

NS_ASSUME_NONNULL_END

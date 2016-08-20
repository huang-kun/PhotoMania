//
//  PMPhoto.h
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPhotographer.h"

@interface PMPhoto : NSObject

@property (nonatomic, readonly, strong) PMPhotographer *photographer;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *photographerName;
@property (nonatomic, readonly, copy) NSString *thumbURLStr;
@property (nonatomic, readonly, copy) NSString *fullSizeURLStr;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

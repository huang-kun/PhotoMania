//
//  PMPhotographer.h
//  PhotoMania
//
//  Created by huang-kun on 16/8/19.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMPhotographer : NSObject

@property (nonatomic, readonly, copy) NSString *fullname;
@property (nonatomic, readonly, copy) NSString *avatarSmallURLStr;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

//
//  PMFetcher.h
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMFetcher : NSObject

/// get NSArray <NSDictionary *> *photos on main thread
@property (nonatomic, readonly) RACSignal *signalByFetchingPopularPhotos;

// Debug:
- (RACSignal *)testSignalByFetchingPopularPhotos;

@end

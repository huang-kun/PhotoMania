//
//  PMFetcher.m
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "PMFetcher.h"

#define PMFetcherNSURLConnectionSignalSupportEnabled 0

@implementation PMFetcher

- (NSURLRequest *)popularPhotosURLRequest {
    return [[PXRequest apiHelper] urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular
                                             resultsPerPage:20
                                                       page:0
                                                 photoSizes:PXPhotoModelSizeThumbnail
                                                  sortOrder:PXAPIHelperSortOrderRating
                                                     except:PXPhotoModelCategoryNude];
}

- (NSURLSession *)urlSession {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    return session;
}

- (RACSignal *)signalByFetchingPopularPhotos {
    
#if PMFetcherNSURLConnectionSignalSupportEnabled
    
    return [[[NSURLConnection rac_sendAsynchronousRequest:[self popularPhotosURLRequest]]
            map:^id(RACTuple *tuple) {
                RACTupleUnpack(__unused NSURLResponse *response, NSData *data) = tuple;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                return json[@"photos"];
            }]
            deliverOn:RACScheduler.mainThreadScheduler];
    
#else 
    
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSURLSession *session = [self urlSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:[self popularPhotosURLRequest] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            // callback on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                
                BOOL taskCancelled = [error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled;
                
                if (error && !taskCancelled) {
                    [subscriber sendError:error];
                } else {
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSArray *photos = json[@"photos"];
                    
                    [subscriber sendNext:photos];
                    [subscriber sendCompleted];
                }
            });
        }];
        
        // start networking request
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            // cancel networking request
            [task cancel];
        }];
    }];
    
#endif
    
}

// debug
- (RACSignal *)testSignalByFetchingPopularPhotos {
    return [RACSubject createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PMPopularPhotosDataSample" ofType:@"json"];
        if (!path) {
            NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
            [subscriber sendError:error];
        } else {
            NSDictionary *json = [NSDictionary dictionaryWithContentsOfFile:path];
            NSArray *photos = json[@"photos"];
            [subscriber sendNext:photos];
            [subscriber sendCompleted];
        }
        return nil;
    }];
}

@end
//
//  PMGalleryCellViewModel.m
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "PMGalleryCellViewModel.h"
#import "PMPhotoCache.h"

@implementation PMGalleryCellViewModel

- (void)setPhoto:(PMPhoto *)photo {
    _photo = photo;
    _photoLabelText = photo.name;
    _photographerLabelText = [NSString stringWithFormat:@"By %@", photo.photographerName];
}

- (nullable NSURLSessionDataTask *)asyncLoadPhotoForURLString:(NSString *)urlString completion:(void(^)(UIImage *image, NSError *error))photo {
    UIImage *cachedImage = [PMPhotoCache sharedCache][urlString];
    if (cachedImage) {
        if (photo) photo(cachedImage, nil);
        return nil;
    } else {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            // back on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                
                BOOL taskCancelled = [error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled;
                if (error && !taskCancelled) {
                    if (photo) photo(nil, error);
                } else if (data) {
                    UIImage *downloadedImage = [UIImage imageWithData:data];
                    [PMPhotoCache sharedCache][urlString] = downloadedImage;
                    if (photo) photo(downloadedImage, nil);
                }
            });
        }];
        [task resume];
        return task;
    }
}

- (RACSignal *)signalForPhoto {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSURLSessionDataTask *task = [self asyncLoadPhotoForURLString:self.photo.thumbURLStr completion:^(UIImage *image, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:image];
                [subscriber sendCompleted];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)signalForPhotographerAvatarSmallImage {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSURLSessionDataTask *task = [self asyncLoadPhotoForURLString:self.photo.photographer.avatarSmallURLStr completion:^(UIImage *image, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:image];
                [subscriber sendCompleted];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];;
    }];
}

@end

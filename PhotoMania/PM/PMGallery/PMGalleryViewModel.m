//
//  PMGalleryViewModel.m
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "PMGalleryViewModel.h"
#import "PMFetcher.h"

#define PMGalleryViewModelFetchingPhotoDebug 0

@interface PMGalleryViewModel ()
@property (nonatomic, readwrite, strong) PMFetcher *fetcher;
@property (nonatomic, readwrite, strong) NSArray <PMPhoto *> *photos;
@property (nonatomic, readwrite, strong) RACSignal *photosUpdatedSignal;
@end

@implementation PMGalleryViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.fetcher = [PMFetcher new];
        [self setupPhotoUpdateSignal];
    }
    return self;
}

- (void)setupPhotoUpdateSignal {
    @weakify(self);

#if PMGalleryViewModelFetchingPhotoDebug
    
    self.photosUpdatedSignal = [[self.fetcher testSignalByFetchingPopularPhotos]
                                map:^id(NSArray <NSDictionary *> *photos) {
                                    @strongify(self)
                                    self.photos = [[photos.rac_sequence map:^id(NSDictionary *json) {
                                        return [[PMPhoto alloc] initWithDictionary:json];
                                    }] array];
                                    return @YES;
                                }];
    
#else
    
    self.photosUpdatedSignal = [self.fetcher.signalByFetchingPopularPhotos
                                map:^id(NSArray <NSDictionary *> *photos) {
                                    @strongify(self)
                                    self.photos = [[photos.rac_sequence map:^id(id value) {
                                        return [[PMPhoto alloc] initWithDictionary:value];
                                    }] array];
                                    return @YES;
                                }];
    
#endif
}

@end

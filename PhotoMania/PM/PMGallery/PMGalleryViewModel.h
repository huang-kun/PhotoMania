//
//  PMGalleryViewModel.h
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPhoto.h"

@interface PMGalleryViewModel : RVMViewModel

@property (nonatomic, readonly, strong) NSArray <PMPhoto *> *photos;
@property (nonatomic, readonly, strong) RACSignal *photosUpdatedSignal; /// @YES or @NO on main thread

@end

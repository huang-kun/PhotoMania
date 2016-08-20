//
//  PMGalleryCellViewModel.h
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPhoto.h"

@interface PMGalleryCellViewModel : RVMViewModel

@property (nonatomic, strong) PMPhoto *photo;

@property (nonatomic, readonly, copy) NSString *photoLabelText;
@property (nonatomic, readonly, copy) NSString *photographerLabelText;

@property (nonatomic, readonly, strong) RACSignal *signalForPhoto; /// UIImage on main thread
@property (nonatomic, readonly, strong) RACSignal *signalForPhotographerAvatarSmallImage; /// UIImage on main thread

@end

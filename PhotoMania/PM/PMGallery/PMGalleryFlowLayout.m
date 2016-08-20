//
//  PMGalleryFlowLayout.m
//  PhotoMania
//
//  Created by huang-kun on 16/8/18.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "PMGalleryFlowLayout.h"

@implementation PMGalleryFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        [self updateLayoutForSize:UIScreen.mainScreen.bounds.size];
    }
    return self;
}

- (void)updateLayoutForSize:(CGSize)size {
    CGFloat len = (size.width - 3.0) / 2;
    self.itemSize = (CGSize){len, len};
    self.minimumLineSpacing = 1.0;
    self.minimumInteritemSpacing = 1.0;
    self.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
}

@end

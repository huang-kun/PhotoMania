//
//  PMGalleryCell.h
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMGalleryCellViewModel.h"

@interface PMGalleryCell : UICollectionViewCell

- (void)configureCellWithPhoto:(PMPhoto *)photo;

@end

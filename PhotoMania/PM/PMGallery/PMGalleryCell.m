//
//  PMGalleryCell.m
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "PMGalleryCell.h"

@interface PMGalleryCell ()
@property (nonatomic, strong) PMGalleryCellViewModel *viewModel;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIImageView *photographerImageView;
@property (nonatomic, strong) UIView *informationContainerView;
@property (nonatomic, strong) UILabel *photoLabel;
@property (nonatomic, strong) UILabel *photographerLabel;
@end

@implementation PMGalleryCell

static const CGFloat kPMGalleryCellPhotographerImageViewSize = 35.0f;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.viewModel = [PMGalleryCellViewModel new];
        [self setupSubviews];
        [self setupLayouts];
    }
    return self;
}

- (void)configureCellWithPhoto:(PMPhoto *)photo {
    self.viewModel.photo = photo;
    [self updateUI];
}

- (void)setupSubviews {
    self.photoImageView = [UIImageView new];
    self.photoImageView.backgroundColor = UIColor.lightGrayColor;
    [self.contentView addSubview:self.photoImageView];
    
    self.informationContainerView = [UIView new];
    self.informationContainerView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.informationContainerView];
    
    self.photographerImageView = [UIImageView new];
    self.photographerImageView.backgroundColor = UIColor.lightGrayColor;
    self.photographerImageView.layer.cornerRadius = kPMGalleryCellPhotographerImageViewSize / 2;
    self.photographerImageView.layer.masksToBounds = YES;
    [self.informationContainerView addSubview:self.photographerImageView];
    
    self.photoLabel = [UILabel new];
    self.photoLabel.font = [UIFont systemFontOfSize:12.0];
    [self.informationContainerView addSubview:self.photoLabel];

    self.photographerLabel = [UILabel new];
    self.photographerLabel.font = [UIFont systemFontOfSize:10.0];
    self.photographerLabel.textColor = UIColor.darkGrayColor;
    [self.informationContainerView addSubview:self.photographerLabel];
}

- (void)setupLayouts {
    UIView *contentView = self.contentView;
    UIView *photoImageView = self.photoImageView;
    UIView *photographerImageView = self.photographerImageView;
    UIView *photoLabel = self.photoLabel;
    UIView *photographerLabel = self.photographerLabel;
    UIView *informationContainerView = self.informationContainerView;
    
    [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top);
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.bottom.equalTo(contentView.mas_bottom).with.priority(999);
    }];
    
    [informationContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImageView.mas_left);
        make.right.equalTo(photoImageView.mas_right);
        make.bottom.equalTo(photoImageView.mas_bottom);
    }];
    
    CGFloat innerSpace = 5.0f;
    
    [photographerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kPMGalleryCellPhotographerImageViewSize, kPMGalleryCellPhotographerImageViewSize));
        make.top.equalTo(informationContainerView.mas_top).with.offset(innerSpace);
        make.left.equalTo(informationContainerView.mas_left).with.offset(innerSpace);
        make.bottom.equalTo(informationContainerView.mas_bottom).with.offset(-innerSpace);
    }];
    
    [photoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photographerImageView.mas_right).with.offset(innerSpace);
        make.right.equalTo(informationContainerView.mas_right).with.offset(-innerSpace);
        make.centerY.equalTo(photographerImageView.mas_centerY).with.offset(-8);
    }];
    
    [photographerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoLabel.mas_left);
        make.right.equalTo(informationContainerView.mas_right).with.offset(-innerSpace);
        make.centerY.equalTo(photographerImageView.mas_centerY).with.offset(8);
    }];
}

- (void)updateUI {
    self.photoLabel.text = self.viewModel.photoLabelText;
    self.photographerLabel.text = self.viewModel.photographerLabelText;
    RAC(self.photoImageView, image) = self.viewModel.signalForPhoto;
    RAC(self.photographerImageView, image) = self.viewModel.signalForPhotographerAvatarSmallImage;
    RAC(self.informationContainerView, alpha) = [self.viewModel.signalForPhoto map:^id(UIImage *image) {
        return image != nil ? @0.8 : @1.0;
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.photoLabel.text = nil;
    self.photographerLabel.text = nil;
    self.photoImageView.image = nil;
    self.photographerImageView.image = nil;
}

@end

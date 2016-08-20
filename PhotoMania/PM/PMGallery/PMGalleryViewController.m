//
//  PMGalleryViewController.m
//  PhotoMania
//
//  Created by huang-kun on 16/8/17.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#import "PMGalleryViewController.h"
#import "PMGalleryFlowLayout.h"
#import "PMGalleryViewModel.h"
#import "PMGalleryCell.h"

@interface PMGalleryViewController ()
@property (nonatomic, strong) PMGalleryViewModel *viewModel;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) RACDisposable *networkDisposable;
@end

@implementation PMGalleryViewController

static NSString * const reuseIdentifier = @"PMGalleryCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    @weakify(self);
    
    // Add a spinner
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.spinner];
    [self.spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    // Register cell classes
    [self.collectionView registerClass:[PMGalleryCell class] forCellWithReuseIdentifier:reuseIdentifier];

    // Setup layout
    self.collectionView.collectionViewLayout = [PMGalleryFlowLayout new];
    
    // Load data source.
    [self.spinner startAnimating];
    self.viewModel = [PMGalleryViewModel new];
    self.networkDisposable = [self.viewModel.photosUpdatedSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.spinner stopAnimating];
        [self.collectionView reloadData];
    }];
}

- (void)dealloc {
    [self.networkDisposable dispose];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [(PMGalleryFlowLayout *)self.collectionView.collectionViewLayout updateLayoutForSize:size];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PMGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell configureCellWithPhoto:self.viewModel.photos[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>



@end

//
//  QBImagePicker.m
//  QBImagePicker
//
//  Created by Tanaka Katsuma on 2013/12/30.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "QBImagePickerController.h"
#import "Dynamic.h"
// ViewControllers
#import "QBAssetsViewController.h"

@interface QBImagePickerController ()

@property(nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end

@implementation QBImagePickerController

- (instancetype)initWithDynamic:(Dynamic *)dynamic {
    if (self = [super init]) {
        _dynamic = [dynamic copy];

        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        _selectedAssetURLs = [NSMutableArray array];
        if (dynamic.mediaType == BBQDynamicMediaTypeVideo) {
            _maximumNumberOfSelection = 1;
            _filterType = QBImagePickerControllerFilterTypeVideos;
        } else if (dynamic.mediaType == BBQDynamicMediaTypeNone || dynamic.mediaType == BBQDynamicMediaTypePhoto) {
            _maximumNumberOfSelection = 9 - dynamic.attachinfo.count;
            _filterType = QBImagePickerControllerFilterTypePhotos;
            _allowsMultipleSelection = YES;
        } else if (dynamic.mediaType == BBQDynamicMediaTypeBatch) {
            _isBatch = YES;
            _maximumNumberOfSelection = 50 - dynamic.attachinfo.count;
            _filterType = QBImagePickerControllerFilterTypePhotos;
            _allowsMultipleSelection = YES;
        }
        [self onInit];
    }
    return self;
}

- (instancetype)initWithFilterType:(QBImagePickerControllerFilterType)filterType {
    self = [super init];
    if (self) {
        _filterType = filterType;
        [self onInit];
    }
    
    return self;
}

- (void)onInit {
    self.hidesBottomBarWhenPushed = YES;
    // Set default values
    self.groupTypes = @[
                        @(ALAssetsGroupSavedPhotos),
                        @(ALAssetsGroupPhotoStream),
                        @(ALAssetsGroupAlbum)
                        ];
    self.minimumNumberOfSelection = 1;
    self.numberOfColumnsInPortrait = 3;
    self.numberOfColumnsInLandscape = 7;
    self.assetsLibrary = [ALAssetsLibrary new];
    [self setUpAssetsViewController];
}

- (void)setUpAssetsViewController {
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QBImagePicker" bundle:nil];
  QBAssetsViewController *assetsViewController = [storyboard
      instantiateViewControllerWithIdentifier:@"AssetsViewController"];
  assetsViewController.imagePickerController = self;
  [self addChildViewController:assetsViewController];
  assetsViewController.view.frame = self.view.bounds;
  [self.view addSubview:assetsViewController.view];
  [assetsViewController didMoveToParentViewController:self];
}

- (NSMutableArray *)selectedAssetURLs {
    if (!_selectedAssetURLs) {
        _selectedAssetURLs = [NSMutableArray array];
    }
    return _selectedAssetURLs;
}

@end

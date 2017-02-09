//
//  ChoosePhotoAlbumTableViewController.h
//  BBQ
//
//  Created by 朱琨 on 15/9/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAssetsGroup.h>
@class UploadViewController;

typedef void(^DidSelectAlbumBlock)(ALAssetsGroup *group);
@interface ChoosePhotoAlbumTableViewController : BaseTableViewController

@property (weak, nonatomic) UploadViewController *uploadVC;
@property (copy, nonatomic) DidSelectAlbumBlock block;

@end

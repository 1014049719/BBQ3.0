//
//  QBAssetsViewController1.h
//  QBImagePicker
//
//  Created by 朱琨 on 15/12/2.
//  Copyright © 2015年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBImagePickerController, ALAssetsGroup;

@interface QBAssetsViewController : UIViewController

@property(nonatomic, weak) QBImagePickerController *imagePickerController;
@property(nonatomic, strong) ALAssetsGroup *assetsGroup;

@end

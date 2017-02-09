//
//  NoPhotoRemindViewController.m
//  BBQ
//
//  Created by wth on 15/10/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "NoPhotoRemindViewController.h"
#import "QBImagePicker.h"
#import "BBQDualListViewController.h"

@interface NoPhotoRemindViewController ()

@end

@implementation NoPhotoRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加右侧分享按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage imageNamed:@"分享白色@2x.png"]
                                    style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(RightBtnClick)];
    rightButton.imageInsets = UIEdgeInsetsMake(20, 40, 20, 0);
    self.navigationItem.rightBarButtonItem = rightButton;
}

//分享按钮事件
- (void)RightBtnClick {
    [SVProgressHUD showErrorWithStatus:@"请先上传照片继续分享"];
}

//批量导入照片
- (IBAction)UpLoadPhotosBtnClick:(id)sender {
#ifdef TARGET_PARENT
    Dynamic *dynamic = [Dynamic dynamicWithMediaType:BBQDynamicMediaTypeBatch object:TheCurBaoBao];
    QBImagePickerController *imagePicker = [[QBImagePickerController alloc] initWithDynamic:dynamic];
    [self.navigationController
     pushViewController:imagePicker
     animated:YES];
#else
    BBQDualListViewController *vc = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"DualListVC"];
    vc.mediaType = BBQDynamicMediaTypeBatch;
    vc.dualListType = BBQDualListTypePublishDynamic;
    [self.navigationController pushViewController:vc animated:YES];
#endif
}

@end

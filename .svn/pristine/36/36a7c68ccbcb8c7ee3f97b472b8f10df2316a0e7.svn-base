//
//  MasterDynamicViewController.m
//  BBQ
//
//  Created by wth on 15/8/13.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MasterDynamicViewController.h"
#import "BBQDynamicViewController.h"
#import "SendToViewController.h"
#import <PopMenu.h>
#import "DynamicCreateTableViewController.h"
#import "AppMacro.h"
#import "BBQIndicatorBar.h"
#import "AppDelegate.h"

@interface MasterDynamicViewController ()
@property(weak, nonatomic) IBOutlet UIButton *cameraButton;

//相机弹窗
@property(nonatomic, strong) PopMenu *popMenu;
@property(weak, nonatomic) IBOutlet BBQIndicatorBar *indicatorBar;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorBarTopCons;

@end

@implementation MasterDynamicViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    self.indicatorBar.topCons = self.indicatorBarTopCons;
//    self.indicatorBar.vc = self;
//    
//    UIStoryboard *storyBoard =
//    [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
//    
//    BBQDynamicViewController *masterDynamic =
//    [storyBoard instantiateViewControllerWithIdentifier:@"DynamicVC"];
//    masterDynamic.dynamicType = BBQDynamicTypeSchool;
//    masterDynamic.needsRefreshEntireData = YES;
//    
//    [self addChildViewController:masterDynamic];
//    [self.view addSubview:masterDynamic.view];
//    [masterDynamic didMoveToParentViewController:self];
//    
//    [self.view bringSubviewToFront:self.indicatorBar];
//    
//    if (TheCurUser.curSchool)
//        self.navigationItem.title = TheCurUser.curSchool.schoolname;
//    
//    //园长端，切换动态通知,修改标题栏
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(masterSwitchDynamic:)
//     name:kMasterSwitchDynaNotificaton
//     object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    if (self.popMenu.isShowed) {
//        [self.popMenu dismissMenu];
//    }
}

//园长端切换动态
- (void)masterSwitchDynamic:(NSNotification *)notification {
//    NSDictionary *dicData = notification.userInfo;
//    
//    NSString *realname = dicData[@"realname"];
//    self.navigationItem.title = realname;
}

- (void)editDynamicWithMorePhoto {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
//    DynamicCreateTableViewController *vc =
//    [sb instantiateViewControllerWithIdentifier:@"editdyna"];
//    vc.itemType = UploadItemTypeAll;
//    [self.navigationController pushViewController:vc animated:YES];
}

//选择查看动态类型
- (IBAction)selectDynamicBtnClick:(id)sender {
    
//    UIStoryboard *storyBoard =
//    [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
//    SendToViewController *sendVcl =
//    [storyBoard instantiateViewControllerWithIdentifier:@"SendToVC"];
//    sendVcl.StyleString = @"选择动态";
//    sendVcl.itemType = UploadItemTypePhoto;
//    [self.navigationController pushViewController:sendVcl animated:YES];
}

//相机发表动态
- (IBAction)CreatDynamicBtnClick:(id)sender {
//    self.popMenu.isShowed ? [self.popMenu dismissMenu] : [self showPopMenu];
}

- (void)showPopMenuWithButton {
//    
//    NSMutableArray *items = [NSMutableArray array];
//    
//    MenuItem *menuitem = [MenuItem itemWithTitle:@"照片"
//                                        iconName:@"item_photo"
//                                       glowColor:[UIColor colorWithRed:255 / 255.0
//                                                                 green:186 / 255.0
//                                                                  blue:0
//                                                                 alpha:0.800]];
//    [items addObject:menuitem];
//    
//    //    menuitem=[MenuItem itemWithTitle:@"视频" iconName:@"item_video"
//    //    glowColor:[UIColor colorWithRed:255/255.0 green:123/255.0 blue:123/255.0
//    //    alpha:0.800]];
//    //    [items addObject:menuitem];
//    
//    menuitem = [MenuItem itemWithTitle:@"批量导入"
//                              iconName:@"item_gallery"
//                             glowColor:[UIColor colorWithRed:126 / 255.0
//                                                       green:203 / 255.0
//                                                        blue:64 / 255.0
//                                                       alpha:0.800]];
//    [items addObject:menuitem];
//    
//    if (!_popMenu) {
//        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
//        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
//    }
//    if (_popMenu.isShowed) {
//        return;
//    }
//    
//    //选取
//    WS(weakSelf)
//    
//    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
//        UIStoryboard *storyBoard =
//        [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
//        SendToViewController *sendVcl =
//        [storyBoard instantiateViewControllerWithIdentifier:@"SendToVC"];
//        sendVcl.StyleString = @"拍照";
//        
//        if (selectedItem.index == 0)
//            sendVcl.itemType = UploadItemTypePhoto;
//        // else if ( selectedItem.index == 1 )
//        //    sendVcl.itemType = UploadItemTypeVideo;
//        else
//            sendVcl.itemType = UploadItemTypeAll;
//        
//        [weakSelf.navigationController pushViewController:sendVcl animated:YES];
//        
//    };
//    
//    [_popMenu showMenuAtView:self.view
//                  startPoint:CGPointMake(CGRectGetWidth(self.view.bounds),
//                                         CGRectGetHeight(self.view.bounds))
//                    endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

- (void)showPopMenu {
//    if (_popMenu.isShowed) {
//        [_popMenu dismissMenu];
//        return;
//    }
//    NSMutableArray *items = [NSMutableArray array];
//    MenuItem *menuItem = [MenuItem itemWithTitle:@"照片" iconName:@"item_"
//                          @"photo"];
//    [items addObject:menuItem];
//    
//    //        menuItem = [MenuItem itemWithTitle:@"视频" iconName:@"item_video"];
//    //        [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"批量导入" iconName:@"item_gallery"];
//    [items addObject:menuItem];
//    
//    CGRect frame = self.view.frame;
//    frame.origin.y -= 64;
//    self.popMenu = [[PopMenu alloc] initWithFrame:frame items:items];
//    self.popMenu.perRowItemCount = 2;
//    WS(weakSelf)
//    
//    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
//        
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
//        SendToViewController *sendVcl =
//        [sb instantiateViewControllerWithIdentifier:@"SendToVC"];
//        sendVcl.StyleString = @"拍照";
//        
//        switch (selectedItem.index) {
//            case 0: {
//                sendVcl.itemType = UploadItemTypePhoto;
//            } break;
//                //                case 1: {
//                //                    //UIStoryboard *sb = [UIStoryboard
//                //                    storyboardWithName:@"RootTabBar" bundle:nil];
//                //                    //GiftViewController *vc = [sb
//                //                    instantiateViewControllerWithIdentifier:@"GiftViewController"];
//                //                    //[(UINavigationController
//                //                    *)weakSelf.selectedViewController
//                //                    pushViewController:vc animated:YES];
//                //
//                //                }
//                //                    break;
//            case 1: {
//                sendVcl.itemType = UploadItemTypeAll;
//            } break;
//                
//            default:
//                break;
//        }
//        [weakSelf.navigationController pushViewController:sendVcl animated:YES];
//    };
//    self.popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
//    
//    [_popMenu showMenuAtView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little
 preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

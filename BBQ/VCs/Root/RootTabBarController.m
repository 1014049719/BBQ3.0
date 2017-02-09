//
//  RootTabBarController.m
//  JYEX
//
//  Created by anymuse on 15/7/16.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import "RootTabBarController.h"
#import "RootTabBar.h"
#import "BBQDynamicEditViewController.h"
#import "AppDelegate.h"
#import "PopMenu.h"
#import <Masonry.h>
#import "LoginViewController.h"
#import "QBImagePickerController.h"
#import "BBQNewUploadViewController.h"
#import "AuthorizationHelper.h"
#import "WebViewController.h"
#import "advertisementViewController.h"
#import "BBQNewGuideViewController.h"
#import "CEGuideArrow.h"
#import "BBQTaskResult.h"
#import "BBQTaskModel.h"
#import <IMYThemeConfig.h>
#import <UIColor+IMY_Theme.h>
#import <UINavigationBar+IMY_Theme.h>
#import <UIImage+YYAdd.h>
#import "BBQPublishManager.h"

typedef enum {
    CEGuideArrowOfPopMenu,
    CEGuideArrowOfTabBar,
    
} CEGuideArrowViewType;
@interface RootTabBarController () <
UIActionSheetDelegate, UITabBarControllerDelegate, UITabBarDelegate,CEGuideArrowDelegate>
@property(weak, nonatomic) IBOutlet RootTabBar *rootTabBar;
@property(strong, nonatomic) UIView *middelView;
@property(strong, nonatomic) UITabBarItem *lastBarItem;
@property(strong, nonatomic) PopMenu *popMenu;
@property(nonatomic, strong) NSMutableArray *menuButtonFrames;
@property(nonatomic, strong) BBQTaskModel *currentTask;
@property(nonatomic, assign) BOOL needShowGuide;
@property(nonatomic, assign) BOOL newTaskHasFinished;
//新消息数
@property(assign, nonatomic) int newnum;

//广告界面是否出现过
@property(assign,nonatomic)BOOL isAppear_Advertisement;

@end

@implementation RootTabBarController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.navigationController.navigationBar imy_setBackgroundImageWithKey:@"nav_back" forBarMetrics:UIBarMetricsDefault];
    
    self.lastBarItem = self.tabBar.items.firstObject;
    
//    self.view.backgroundColor = [UIColor colorWithHexString:@"#fed500"];
    
    NSArray *images = @[
                        @"tab_1_selected",
                        @"tab_2_selected",
                        @"",
                        @"tab_3_selected",
                        @"tab_4_selected"
                        ];
    NSArray *unimages = @[
                          @"tab_1_unselected",
                          @"tab_2_unselected",
                          @"",
                          @"tab_3_unselected",
                          @"tab_4_unselected"
                          ];
    @weakify(self)
    self.rootTabBar.buttonBlock = ^(UIButton *button) {
        @strongify(self)
        [self showPopMenu];
    };

    [self.rootTabBar.items
     enumerateObjectsUsingBlock:^(UITabBarItem *__nonnull item, NSUInteger idx,
                                  BOOL *__nonnull stop) {
         //         UIImage *image = [UIImage imageNamed:images[idx]];
         //         item.selectedImage =
         //         [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         
         item.badgeValue = nil;
         //         item.image = [UIImage imageNamed:unimages[idx]];
         //         [item imy_setFinishedSelectedImageName:images[idx] withFinishedUnselectedImageName:unimages[idx]];
         [item imy_setFinishedSelectedImageName:images[idx] withFinishedUnselectedImageName:unimages[idx]];
         //         UIImage *image = [UIImage imy_imageForKey:unimages[idx]];
         //         UIImage *selectImage = [UIImage imy_imageForKey:images[idx]];
         //         item.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         //         item.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     }];
    
    //监听消息数更新
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveMsgUpdate:)
                                                 name:kSetUpdateNewMsgNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshNewGuideTask:)
                                                 name:kFinishedNewGuideTaskNotification
                                               object:nil];
}

//更新消息数提醒
- (void)receiveMsgUpdate:(NSNotification *)notification {
    UITabBarItem *item = self.rootTabBar.items[3];
    NSNumber *num = notification.userInfo[@"num"];
    if ([num intValue] == 0) {
        self.newnum = 0;
        item.badgeValue = nil;
    } else {
        self.newnum += [num intValue];
        item.badgeValue = [NSString stringWithFormat:@"%d", self.newnum];
        [[NSUserDefaults standardUserDefaults] setBool:YES
                                                forKey:@"messageNeedRefresh"];
    }
}
//更新新手任务完成 refreshNewGuideTask
- (void)refreshNewGuideTask:(NSNotification *)notification {
    NSInteger taskNo = [notification.userInfo[@"taskno"] integerValue];
    if (TheCurUser.taskArr.count >taskNo) {
        self.currentTask = TheCurUser.taskArr[taskNo];
        [TheCurUser updataTaskModel:taskNo];
        [self showNewGuideController];
        [self getTaskStatus];
    }
}
#pragma mark - Popmenu
- (void)showPopMenu {
    NSArray *menuItems = @[
                           [MenuItem itemWithTitle:@"照片" iconName:@"popmenu_photo" index:0],
                           [MenuItem itemWithTitle:@"视频" iconName:@"popmenu_video" index:1],
                           [MenuItem itemWithTitle:@"文字" iconName:@"popmenu_text" index:2],
                           [MenuItem itemWithTitle:@"批量导入照片" iconName:@"popmenu_batch" index:3],
//                           [MenuItem itemWithTitle:@"安全求助" iconName:@"popmenu_help" index:4]
                           ];
    if (_popMenu.isShowed) {
        [_popMenu dismissMenu];
        return;
    }
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:kScreen_Bounds items:menuItems];
        @weakify(self)
        [_popMenu bk_addObserverForKeyPath:@"isShowed" options:NSKeyValueObservingOptionNew task:^(id obj, NSDictionary *change) {
            @strongify(self)
            self.rootTabBar.middleButton.selected = [change[@"new"] boolValue];
        }];
        self.menuButtonFrames = [NSMutableArray array];
        _popMenu.returnFrameBlock =^(CGRect rect,BOOL isShow) {
            @strongify(self)
            if (!self.selectedIndex && self.needShowGuide) {
                if (isShow) {
                    [self.menuButtonFrames addObject:[NSValue valueWithCGRect:rect]];
                }else{
                    if ([CEGuideArrow sharedGuideArrow].isDisplayed) {
                        
                        [[CEGuideArrow sharedGuideArrow] removeAnimated:YES];
                    }
                }
            }
        };
        _popMenu.perRowItemCount = 3;
        _popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
    }

    @weakify(self)
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem){
        @strongify(self)
        switch (selectedItem.index) {
            case 0: {
                //照片
                if (![AuthorizationHelper checkPhotoLibraryAuthorizationStatus]) {
                    return;
                }
                Dynamic *dynamic = [Dynamic dynamicWithMediaType:BBQDynamicMediaTypePhoto object:TheCurBaoBao];
                [self createNewDynamic:dynamic];
            } break;
            case 1: {
                //视频
                if (![AuthorizationHelper checkPhotoLibraryAuthorizationStatus]) {
                    return;
                }
                Dynamic *dynamic = [Dynamic dynamicWithMediaType:BBQDynamicMediaTypeVideo object:TheCurBaoBao];
                [self createNewDynamic:dynamic];
            } break;
            case 2: {
                //文字
                Dynamic *dynamic = [Dynamic dynamicWithMediaType:BBQDynamicMediaTypeNone object:TheCurBaoBao];
                [self createNewDynamic:dynamic];
            } break;
            case 3: {
                //批量
                if (![AuthorizationHelper checkPhotoLibraryAuthorizationStatus]) {
                    return;
                }
                Dynamic *dynamic = [Dynamic dynamicWithMediaType:BBQDynamicMediaTypeBatch object:TheCurBaoBao];
                [self createNewDynamic:dynamic];
            } break;
            case 4: {
                //TODO:安全求助
            } break;
            default:
                break;
        }
    };
    [_popMenu showMenuAtView:self.selectedViewController.view];
    if (!self.selectedIndex && self.needShowGuide) {
        [self showGuidArrow:CEGuideArrowOfPopMenu];
    }
    
}

- (void)createNewDynamic:(Dynamic *)dynamic {
    BBQDynamicMediaType mediaType = dynamic.mediaType;
    if (mediaType == BBQDynamicMediaTypeVideo || mediaType == BBQDynamicMediaTypePhoto || mediaType == BBQDynamicMediaTypeBatch) {
        QBImagePickerController *imagePicker = [[QBImagePickerController alloc] initWithDynamic:dynamic];
        [(UINavigationController *)self.selectedViewController
         pushViewController:imagePicker
         animated:YES];
    } else if (mediaType == BBQDynamicMediaTypeNone) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Dynamic" bundle:nil];
        BBQDynamicEditViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DynamicEditVC"];
        vc.dynamic = dynamic;
        [(UINavigationController *)self.selectedViewController
         pushViewController:vc
         animated:YES];
    }
}

- (void)jumpToNewUploadVC {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Family" bundle:nil];
        BBQNewUploadViewController *vc =
        [sb instantiateViewControllerWithIdentifier:@"newUploadVC"];
        vc.showNewGuiderBlock = ^(){
            [self showNewGuideController];
        };
        [self.selectedViewController presentViewController:vc
                                                  animated:YES
                                                completion:nil];
    }else{
        [self showNewGuideController];
    }
}

#pragma mark - Life Cycle
-(void)addAdvertisementView{
    advertisementViewController *advertisementVcl=[[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"advertisementVcl"];
    advertisementVcl.TypeNumStr=@"0";
    advertisementVcl.showNewUploadBlock = ^(){
        [self jumpToNewUploadVC];
        //[self showNewGuideController];
    };
    [(UINavigationController *)self.selectedViewController pushViewController:advertisementVcl
                                                                     animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //加载广告页
    if ([BBQLoginManager isLogin] && TheCurBaoBao && self.isAppear_Advertisement!=YES) {
        [self addAdvertisementView];
        self.isAppear_Advertisement=YES;
        [self getTaskStatus];
    }
}
/**
 获取新手任务
 */
-(void)getTaskStatus{
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetTaskStatus
     param:nil
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         BBQTaskResult *result = [BBQTaskResult modelWithDictionary:responseObject[@"data"]];
         TheCurUser.taskArr = result.taskarr;
         BBQTaskModel *taskModel = [TheCurUser.taskArr firstObject];
        self.newTaskHasFinished = taskModel.state;
     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
         
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

#pragma mark - Action

- (void)tabBar:(nonnull UITabBar *)tabBar
 didSelectItem:(nonnull UITabBarItem *)item {
    if (self.lastBarItem != item) {
        self.lastBarItem = item;
        [self.popMenu dismissMenu];
    }
}

-(void)showNewGuideController{
    if (TheCurUser.taskArr) {
        if (!self.newTaskHasFinished) {
            [[CEGuideArrow sharedGuideArrow] setDelegate:self];
            BBQNewGuideViewController *guideVC = [[BBQNewGuideViewController alloc]init];
            guideVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
            guideVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            guideVC.taskModel = self.currentTask?:[TheCurUser.taskArr firstObject];
            guideVC.block = ^(BOOL isOK){
                self.needShowGuide = isOK;
                if (isOK) {
                    [self showGuidArrow:CEGuideArrowOfTabBar];
                }
            };
            [self presentViewController:guideVC animated:YES completion:nil];
        }
    }
}

-(void)showGuidArrow:(CEGuideArrowViewType)type{
    NSInteger willShowTaskNo = 0;
    for (BBQTaskModel *model in TheCurUser.taskArr) {
        if (model.taskno !=0 && model.state==0) {
            willShowTaskNo = model.taskno;
            break;
        }
    }
    if (willShowTaskNo) {
        switch (type) {
            case CEGuideArrowOfTabBar:{
                if (willShowTaskNo != 3) {
                    [[CEGuideArrow sharedGuideArrow] showInWindow:kKeyWindow atPosition:CEGuideArrowPositionTypeTopRight inView:self.rootTabBar
                     .middleButton atAngle:-90 length:0.0];
                }else{
                    CGPoint point = CGPointMake([UIScreen mainScreen].bounds.size.width- 60, 120);
                    [[CEGuideArrow sharedGuideArrow] showInWindow:kKeyWindow atPoint:point inView:self.view atAngle:90 length:0.0];
                }
                
            }break;
            case CEGuideArrowOfPopMenu:{
                if (willShowTaskNo != 3) {
                    CGRect rect = (willShowTaskNo ==1)?[self.menuButtonFrames[0] CGRectValue]:[self.menuButtonFrames[1] CGRectValue];
                    CGPoint point = CGPointMake(rect.origin.x+60, rect.origin.y-60);
                    [[CEGuideArrow sharedGuideArrow] showInWindow:kKeyWindow atPoint:point inView:self.popMenu atAngle:-90 length:0.0];
                }else{
                    if ([CEGuideArrow sharedGuideArrow].isDisplayed) {
                        
                        [[CEGuideArrow sharedGuideArrow] removeAnimated:YES];
                    }
                }
            }break;
        }
    }
}
@end

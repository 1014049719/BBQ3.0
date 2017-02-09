//
//  MainViewController.m
//  BBQ
//
//  Created by wth on 15/8/6.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MainViewController.h"
#include "MessageViewController.h"
#import "BBQDynamicEditViewController.h"
#import "AppMacro.h"
#import "AppDelegate.h"
#import <UINavigationBar+Awesome.h>
#import <WZLBadgeImport.h>
#import "MHBlurTutorialsViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "User.h"

@interface MainViewController ()

@property(weak, nonatomic) IBOutlet UIView *takePhotoView;
@property(weak, nonatomic) IBOutlet UIView *dailyReportView;
@property(weak, nonatomic) IBOutlet UIButton *cameraButton;
@property(weak, nonatomic) IBOutlet UILabel *cameraLabel;
@property(weak, nonatomic) IBOutlet UIButton *reportButton;
@property(weak, nonatomic) IBOutlet UILabel *reportLabel;

//上方红背景高度
@property (weak, nonatomic) IBOutlet UIView *RedView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Layout_RedViewHeight;

@property(nonatomic, copy) NSString *uploadTitle;
@property(assign, nonatomic) UploadItemType uploadType;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cameraButton.badgeBgColor = [UIColor yellowColor];
    self.cameraButton.badgeTextColor = [UIColor colorWithHexString:@"ff6440"];
    self.reportButton.badgeBgColor = [UIColor yellowColor];
    self.reportButton.badgeTextColor = [UIColor colorWithHexString:@"ff6440"];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    if (TheCurUser.schooltype.integerValue == 3) {
        _Layout_RedViewHeight.constant = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title=@"家园";
    if (TheCurUser.schooltype.integerValue != 3) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (BOOL)fd_prefersNavigationBarHidden {
    if (TheCurUser.schooltype.integerValue!=3) {
        return YES;
    }else{
        return NO;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self photoRemindRequest];
    if (TheCurUser.didFinishAD && [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showTutorial];
    }
}

#pragma mark - Tutorial
- (void)showTutorial {
    MHBlurTutorialsViewController *tutorialsVC =
    [[MHBlurTutorialsViewController alloc] init];
    tutorialsVC.tutorialsType = BBQTutorialsTypeTeacherHomePage;
    
    CGFloat leftRadius = self.takePhotoView.width / 2.0;
    CGPoint leftCenter = [kKeyWindow convertPoint:self.takePhotoView.center fromView:self.takePhotoView.superview];
    
    CGFloat rightRadius = self.dailyReportView.width / 2.0;
    CGPoint rightCenter = [kKeyWindow convertPoint:self.dailyReportView.center fromView:self.dailyReportView.superview];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        tutorialsVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        tutorialsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self
         presentViewController:tutorialsVC
         animated:YES
         completion:^{
             [tutorialsVC setAnimations:@[
                                          @{
                                              @"holeRadius" : @(leftRadius),
                                              @"holeCenter" : [NSValue
                                                               valueWithCGPoint:leftCenter]
                                              },
                                          @{
                                              @"holeRadius" : @(rightRadius),
                                              @"holeCenter" : [NSValue
                                                               valueWithCGPoint:rightCenter]
                                              }
                                          ]];
             [tutorialsVC
              setBackgroundColor:[UIColor colorWithWhite:0
                                                   alpha:0.7]];
             [tutorialsVC displayTutorial];
         }];
    } else {
        AppDelegate *appDelegate =
        (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [self
         presentViewController:tutorialsVC
         animated:NO
         completion:^{
             [tutorialsVC dismissViewControllerAnimated:
              NO completion:^{
                  appDelegate.window.rootViewController
                  .modalPresentationStyle =
                  UIModalPresentationCurrentContext;
                  [self
                   presentViewController:tutorialsVC
                   animated:NO
                   completion:^{
                       [tutorialsVC setAnimations:@[
                                                    @{
                                                        @"holeRadius" :
                                                            @(leftRadius),
                                                        @"holeCenter" : [NSValue
                                                                         valueWithCGPoint:
                                                                         leftCenter]
                                                        },
                                                    @{
                                                        @"holeRadius" :
                                                            @(rightRadius),
                                                        @"holeCenter" : [NSValue
                                                                         valueWithCGPoint:
                                                                         rightCenter]
                                                        }
                                                    ]];
                       [tutorialsVC
                        setBackgroundColor:
                        [UIColor colorWithWhite:0
                                          alpha:0.7]];
                       [tutorialsVC displayTutorial];
                   }];
                  appDelegate.window.rootViewController
                  .modalPresentationStyle =
                  UIModalPresentationFullScreen;
              }];
         }];
    }
}

#pragma mark - 网络请求
/// 任务数提醒
- (void)photoRemindRequest {
    if (![BBQLoginManager isLogin] || !TheCurUser.classdata ||
        !TheCurUser.classdata.count)
        return;
    
    BBQClassDataModel *classModel = TheCurUser.classdata[0];
    
    NSDictionary *params = @{ @"classid" : classModel.classid };
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetRemindTaskNum
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         dispatch_async_on_main_queue(^{
             [self.cameraButton showBadgeWithStyle:WBadgeStyleNumber
                                             value:[responseObject[@"data"][
                                                                            @"pztx_num"] integerValue]
                                     animationType:WBadgeAnimTypeNone];
             [self.reportButton showBadgeWithStyle:WBadgeStyleNumber
                                             value:[responseObject[@"data"][
                                                                            @"baogao_num"] integerValue]
                                     animationType:WBadgeAnimTypeNone];
         });
     } errorHandler:nil
     failureHandler:nil];
}

@end

//
//  MasterMainViewController.m
//  BBQ
//
//  Created by wth on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MasterMainViewController.h"
#import "ResetPassKeyTableViewController.h"
#include "MessageViewController.h"
#include "WebViewController.h"
#include "NetConstDefine.h"
#import "BBQSchoolDataModel.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import <WZLBadgeImport.h>

@interface MasterMainViewController ()

@property (weak, nonatomic) IBOutlet UIView *teacherView;
@property (weak, nonatomic) IBOutlet UIButton *teacherButton;
@property (weak, nonatomic) IBOutlet UIView *babyView;
@property (weak, nonatomic) IBOutlet UIButton *babyButton;

@property(nonatomic, assign) int updatemmflag;

@end

@implementation MasterMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.teacherButton.badgeBgColor = [UIColor yellowColor];
    self.teacherButton.badgeTextColor = UIColorHex(ff6440);
    self.babyButton.badgeBgColor = [UIColor yellowColor];
    self.babyButton.badgeTextColor = UIColorHex(ff6440);
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self curShuaKaNumRequest];
}

- (IBAction)clickLSKQBtn:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    WebViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"WebViewController"];
    
    vc.url = URL_MASTER_JSKQ;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickXSKQBtn:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    WebViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"WebViewController"];
    
    vc.url = URL_HOMEPAGE_GROWING_MASTER;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 网络请求

/// 当天刷卡数
- (void)curShuaKaNumRequest {
    if (![BBQLoginManager isLogin])
        return;
    if (!TheCurUser.schooldata)
        return;
    
    BBQSchoolDataModel *schoolModel = TheCurUser.schooldata[0];
    
    NSDictionary *params = @{ @"schoolid" : schoolModel.schoolid ? schoolModel.schoolid:@"0" };
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetCurrentDayShuaKaNum
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         int jiaoshi_sw_sknum =
         pickJsonIntValue(responseObject[@"data"], @"jiaoshi_sw_sknum");
         int jiaoshi_xw_sknum =
         pickJsonIntValue(responseObject[@"data"], @"jiaoshi_xw_sknum");
         int baobao_sw_sknum =
         pickJsonIntValue(responseObject[@"data"], @"baobao_sw_sknum");
         int baobao_xw_sknum =
         pickJsonIntValue(responseObject[@"data"], @"baobao_xw_sknum");
         
         dispatch_async_on_main_queue(^{
             [self.teacherButton showBadgeWithStyle:WBadgeStyleNumber value:jiaoshi_sw_sknum + jiaoshi_xw_sknum animationType:WBadgeAnimTypeNone];
             [self.babyButton showBadgeWithStyle:WBadgeStyleNumber value:baobao_sw_sknum + baobao_xw_sknum animationType:WBadgeAnimTypeNone];
         });
     } errorHandler:nil
     failureHandler:nil];
}

@end

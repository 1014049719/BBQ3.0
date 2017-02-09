//
//  TeacherRootTabbarViewController.m
//  BBQ
//
//  Created by wth on 15/8/5.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "TeacherRootTabbarViewController.h"
#import "AppDelegate.h"
#import "BBQDailyReportOption.h"
#import "advertisementViewController.h"
#import <IMYThemeConfig.h>
#import <UIColor+IMY_Theme.h>
#import <UINavigationBar+IMY_Theme.h>


@interface TeacherRootTabbarViewController ()

@property(weak, nonatomic) IBOutlet UITabBar *rootTabBar;
@property(assign, nonatomic) int newnum;
//广告界面是否出现过
@property(assign,nonatomic)BOOL isAppear_Advertisement;

@end

@implementation TeacherRootTabbarViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
    
    UIStoryboard *RootStoryboard =
    [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    UIViewController *DynamicTbVcl =
    [RootStoryboard instantiateViewControllerWithIdentifier:@"DynamicVC"];
    if (self.selectedIndex == 0) {
        self.selectedViewController = DynamicTbVcl;
    }
    
    //监听消息数更新
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveMsgUpdate:)
                                                 name:kSetUpdateNewMsgNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logout)
                                                 name:kLogoutNotification
                                               object:nil];
    
    NSArray *images = @[
                        @"tab_1_selected",
                        @"tab_2_selected",
                        @"tab_3_selected",
                        @"tab_4_selected"
                        ];
    NSArray *unimages = @[
                          @"tab_1_unselected",
                          @"tab_2_unselected",
                          @"tab_3_unselected",
                          @"tab_4_unselected"
                          ];
    [self.rootTabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [item imy_setFinishedSelectedImageName:images[idx] withFinishedUnselectedImageName:unimages[idx]];
    }];
}

-(void)addAdvertisementView{
    advertisementViewController *advertisementVcl=[[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"advertisementVcl"];
    advertisementVcl.TypeNumStr=@"1";
    [(UINavigationController *)self.selectedViewController pushViewController:advertisementVcl
                                                                     animated:NO];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //加载广告页
    if ([BBQLoginManager isLogin] && self.isAppear_Advertisement!=YES) {
        [self addAdvertisementView];
        self.isAppear_Advertisement=YES;
    }
    
}

//更新消息数提醒
- (void)receiveMsgUpdate:(NSNotification *)notification {
    
    UITabBarItem *item = self.rootTabBar.items[2];
    
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

#pragma mark - Set Neet To Refresh All Data
- (void)setNeedsRefreshEntireData {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kSetNeedsRefreshEntireDataNotification
     object:nil
     userInfo:@{
                @"type" : @(BBQRefreshNotificationTypeAll)
                }];
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

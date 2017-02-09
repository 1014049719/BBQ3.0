//
//  MasterTabBarViewController.m
//  BBQ
//
//  Created by wth on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MasterTabBarViewController.h"
#import "AppDelegate.h"
#import "advertisementViewController.h"
#import <IMYThemeConfig.h>
#import <UIColor+IMY_Theme.h>
#import <UINavigationBar+IMY_Theme.h>


@interface MasterTabBarViewController ()

@property(weak, nonatomic) IBOutlet UITabBar *rootTabBar;

@property(assign, nonatomic) int newnum;

//广告界面是否出现过
@property(assign,nonatomic)BOOL isAppear_Advertisement;

@end

@implementation MasterTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
    //监听消息数更新
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveMsgUpdate:)
                                                 name:kSetUpdateNewMsgNotification
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //加载广告页
    if ([BBQLoginManager isLogin] && self.isAppear_Advertisement!=YES) {
        [self addAdvertisementView];
        self.isAppear_Advertisement=YES;
    }
}

-(void)addAdvertisementView{
    
    advertisementViewController *advertisementVcl=[[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"advertisementVcl"];
    advertisementVcl.TypeNumStr=@"2";
    [(UINavigationController *)self.selectedViewController pushViewController:advertisementVcl
                                                                     animated:NO];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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

@end

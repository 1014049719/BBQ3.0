//
//  BBQBaseViewController.m
//  BBQ
//
//  Created by anymuse on 15/8/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBaseViewController.h"
#import "AppDelegate.h"
#import "BBQLoginManager.h"

@interface BBQBaseViewController ()

@end

@implementation BBQBaseViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(needToRefreshEntireData:)
     name:kSetNeedsRefreshEntireDataNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearData)
                                                 name:kWillLogoutNotification
                                               object:nil];
    self.refreshType = BBQRefreshTypePullDown;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [MTA trackPageViewBegin:[NSString
                             stringWithUTF8String:object_getClassName(self)]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MTA trackPageViewEnd:[NSString
                           stringWithUTF8String:object_getClassName(self)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)needToRefreshEntireData:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if ([userInfo[@"type"] integerValue] == BBQRefreshNotificationTypeAll ||
        [userInfo[@"type"] integerValue] == BBQRefreshNotificationTypeDynamic) {
        
        self.needsRefreshEntireData = YES;
        [self refreshEntireData];
    }
}

- (void)clearData {
}

- (void)refreshEntireData {
}

- (void)deleteSpecifyData:(id)sender {
}

- (void)refreshSpecifyData:(id)sender {
}

- (void)insertNewData:(id)sender {
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Notification
+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState {
    if (applicationState == UIApplicationStateInactive) {
        
    } else if (applicationState == UIApplicationStateActive) {
        
    }
}

+ (void)presentVC:(UIViewController *)viewController{
    if (!viewController) {
        return;
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    if (!viewController.navigationItem.leftBarButtonItem) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:viewController action:@selector(dismissModalViewControllerAnimated:)];
    }
    [[self presentingVC] presentViewController:nav animated:YES completion:nil];
}

#pragma mark Login
- (void)loginOutToLoginVC{
    [BBQLoginManager logout];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewControllerInit:NO];
}

@end

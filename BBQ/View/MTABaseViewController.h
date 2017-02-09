//
//  MTABaseViewController.h
//  BBQ
//
//  Created by slovelys on 15/9/15.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTABaseViewController : UIViewController

- (void)tabBarItemClicked;

+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState;
+ (UIViewController *)analyseVCFromLinkStr:(NSString *)linkStr;
+ (void)presentLinkStr:(NSString *)linkStr;
+ (UIViewController *)presentingVC;
+ (void)presentVC:(UIViewController *)viewController;

@end

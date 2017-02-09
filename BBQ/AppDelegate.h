//
//  AppDelegate.h
//  BBQ
//
//  Created by anymuse on 15/7/20.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setupTabBarController;
- (void)setupLoginViewControllerInit:(BOOL)init;
- (void)setupIntroductionViewController;
- (void)setupAppearance;
- (void)registerPush;

@end


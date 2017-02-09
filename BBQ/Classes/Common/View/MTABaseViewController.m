//
//  MTABaseViewController.m
//  BBQ
//
//  Created by slovelys on 15/9/15.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MTABaseViewController.h"

@interface MTABaseViewController ()

@end

@implementation MTABaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.navigationController.navigationBar
      setShadowImage:[[UIImage alloc] init]];
  if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
//  [MTA trackPageViewBegin:[NSString
//                              stringWithUTF8String:object_getClassName(self)]];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
//  [MTA trackPageViewEnd:[NSString
//                            stringWithUTF8String:object_getClassName(self)]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)tabBarItemClicked {
  DebugLog(@"\ntabBarItemClicked : %@", NSStringFromClass([self class]));
}

//+ (UIViewController *)presentingVC{
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    UIViewController *result = window.rootViewController;
//    while (result.presentedViewController) {
//        result = result.presentedViewController;
//    }
//    if ([result isKindOfClass:[RootTabViewController class]]) {
//        result = [(RootTabViewController *)result selectedViewController];
//    }
//    if ([result isKindOfClass:[UINavigationController class]]) {
//        result = [(UINavigationController *)result topViewController];
//    }
//    return result;
//}

+ (void)presentVC:(UIViewController *)viewController {
  if (!viewController) {
    return;
  }
  UINavigationController *nav = [[UINavigationController alloc]
      initWithRootViewController:viewController];
  viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
      initWithTitle:@"关闭"
              style:UIBarButtonItemStylePlain
             target:viewController
             action:@selector(dismissModalViewControllerAnimated:)];
  [[self presentingVC] presentViewController:nav animated:YES completion:nil];
}

@end

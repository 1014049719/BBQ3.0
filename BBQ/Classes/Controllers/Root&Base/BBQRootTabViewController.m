//
//  BBQRootTabViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/10/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQRootTabViewController.h"
#import "BabyRootViewController.h"
#import "jyexViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
#import "BBQBaseNavigationController.h"
#import "RDVTabBarItem.h"
#import "RKSwipeBetweenViewControllers.h"
#import "MTABaseViewController.h"

@interface BBQRootTabViewController ()

@end

@implementation BBQRootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
}

#pragma mark - Private
- (void)setupViewControllers {
#ifdef TARGET_PARENT
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    
    BabyRootViewController *babyVC =
    [sb instantiateViewControllerWithIdentifier:@"BabyRootViewController"];
    BBQBaseNavigationController *nav_baby =
    [[BBQBaseNavigationController alloc] initWithRootViewController:babyVC];
    
    jyexViewController *homeVC =
    [sb instantiateViewControllerWithIdentifier:@"jyexViewVC"];
    BBQBaseNavigationController *nav_home =
    [[BBQBaseNavigationController alloc] initWithRootViewController:homeVC];
    
    UIViewController *emptyVC = [[UIViewController alloc] init];
    
    MessageViewController *messageVC =
    [sb instantiateViewControllerWithIdentifier:@"MessageTbc"];
    BBQBaseNavigationController *nav_message = [
                                                [BBQBaseNavigationController alloc] initWithRootViewController:messageVC];
    
    mineViewController *mineVC =
    [sb instantiateViewControllerWithIdentifier:@"mineVcl"];
    BBQBaseNavigationController *nav_mine =
    [[BBQBaseNavigationController alloc] initWithRootViewController:mineVC];
    
    self.viewControllers =
    @[ nav_baby, nav_home, emptyVC, nav_message, nav_mine ];
#elif TARGET_TEACHER
    
#else
    
#endif
    
    [self customizeTabBarForController];
    self.delegate = self;
}

- (void)customizeTabBarForController {
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
#ifdef TARGET_PARENT
    NSArray *tabBarItemImages =
    @[ @"tab_baby", @"tab_home", @"", @"tab_message", @"tab_mine" ];
    NSArray *tabBarItemTitles = @[ @"宝宝", @"家园", @"", @"消息", @"我的" ];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        [item setBackgroundSelectedImage:backgroundImage
                     withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage
                                  imageNamed:[NSString stringWithFormat:@"%@_selected",
                                              [tabBarItemImages
                                               objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage
                                    imageNamed:[NSString stringWithFormat:@"%@_unselected",
                                                [tabBarItemImages
                                                 objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage
           withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
    
#elif TARGET_TEACHER
    
#else
    
#endif
}

#pragma mark RDVTabBarControllerDelegate
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
    
    if ([nav.topViewController isKindOfClass:[MTABaseViewController class]]) {
        MTABaseViewController *rootVC =
        (MTABaseViewController *)nav.topViewController;
        [rootVC tabBarItemClicked];
    }
    //    if ([nav isKindOfClass:[RKSwipeBetweenViewControllers class]]) {
    //        RKSwipeBetweenViewControllers *swipeVC =
    //        (RKSwipeBetweenViewControllers *)nav;
    //        if ([[swipeVC curViewController] isKindOfClass:[BaseViewController
    //        class]]) {
    //            BaseViewController *rootVC = (BaseViewController *)[swipeVC
    //            curViewController];
    //            [rootVC tabBarItemClicked];
    //        }
    //    }else{
    //        if ([nav.topViewController isKindOfClass:[BaseViewController
    //        class]]) {
    //            BaseViewController *rootVC = (BaseViewController
    //            *)nav.topViewController;
    //            [rootVC tabBarItemClicked];
    //        }
    //    }
    return YES;
}

@end

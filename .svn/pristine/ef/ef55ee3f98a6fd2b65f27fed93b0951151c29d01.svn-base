//
//  BabyPageViewController.h
//  JYEX
//
//  Created by 朱琨 on 15/7/5.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyNavBar.h"
#import "MenuView.h"

@class BabyRootViewController;

typedef void(^ScrollPageBlock)(NSInteger, CGFloat);
typedef void(^WillTransitionBlock)();

@interface BabyPageViewController : UIPageViewController

@property (copy, nonatomic) ScrollPageBlock block;
@property (strong, nonatomic) BabyRootViewController *babyRootVC;
@property (copy, nonatomic) WillTransitionBlock transitionBlock;
@property (strong, nonatomic) MenuView *menuView;

- (void)moveToPageOfIndex:(NSInteger)idx;


@end

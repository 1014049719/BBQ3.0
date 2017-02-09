//
//  MineViewController.m
//  BBQ
//
//  Created by wth on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MineViewController.h"
#import <UINavigationBar+Awesome.h>
#import <IMYThemeConfig.h>

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
  UIStoryboard *RootStoryboard =
      [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
  UIViewController *mineVcl =
      [RootStoryboard instantiateViewControllerWithIdentifier:@"mineVcl"];

  [self addChildViewController:mineVcl];
  [self.view addSubview:mineVcl.view];
}

@end

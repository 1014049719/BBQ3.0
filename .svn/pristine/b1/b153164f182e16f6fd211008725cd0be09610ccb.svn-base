//
//  BoxContentViewController.m
//  BBQ
//
//  Created by wth on 15/8/6.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "BoxContentViewController.h"

@interface BoxContentViewController ()

@end

@implementation BoxContentViewController

- (void)viewDidLoad {
  [super viewDidLoad];
// Do any additional setup after loading the view.

#ifdef TARGET_PARENT

  UIStoryboard *RootStoryboard =
      [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
  UITableViewController *MineTbVcl =
      [RootStoryboard instantiateViewControllerWithIdentifier:@"MineTbcVcl"];

  //加入一个子控制器（要添加子视图，不然不显示）
  [self addChildViewController:MineTbVcl];
  [self.view addSubview:MineTbVcl.view];

#elif TARGET_TEACHER

  NSLog(@"............进入老师端。。。。。。。。。。");

  UIStoryboard *RootStoryboard =
      [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
  UITableViewController *TeMineTbcVcl =
      [RootStoryboard instantiateViewControllerWithIdentifier:@"TeMineTbcVcl"];

  //加入一个子控制器（要添加子视图，不然不显示）
  [self addChildViewController:TeMineTbcVcl];
  [self.view addSubview:TeMineTbcVcl.view];

#else

  NSLog(@"............进入校长端。。。。。。。。。。");
  UIStoryboard *RootStoryboard =
      [UIStoryboard storyboardWithName:@"Master" bundle:nil];
  UITableViewController *TeMineTbcVcl = [RootStoryboard
      instantiateViewControllerWithIdentifier:@"MasterMineTbcVcl"];

  //加入一个子控制器（要添加子视图，不然不显示）
  [self addChildViewController:TeMineTbcVcl];
  [self.view addSubview:TeMineTbcVcl.view];

#endif
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
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

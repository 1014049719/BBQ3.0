//
//  MasterMineViewController.m
//  BBQ
//
//  Created by wth on 15/8/13.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MasterMineViewController.h"
#import <UINavigationBar+Awesome.h>

@interface MasterMineViewController ()

@end

@implementation MasterMineViewController

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

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

//修改个人信息
- (IBAction)ResetBtnCilck:(id)sender {

  UIStoryboard *RootStoryboard =
      [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
  UIViewController *MasterResetDataVcl = [RootStoryboard
      instantiateViewControllerWithIdentifier:@"ResetUserDataTbVcl"];

  [self.navigationController pushViewController:MasterResetDataVcl
                                       animated:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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

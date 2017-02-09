//
//  MasterMessageViewController.m
//  BBQ
//
//  Created by wth on 15/8/13.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MasterMessageViewController.h"
#import "MessageViewController.h"

@interface MasterMessageViewController ()

@end

@implementation MasterMessageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

    self.edgesForExtendedLayout=UIRectEdgeNone;
    
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
  MessageViewController *vc =
      [sb instantiateViewControllerWithIdentifier:@"MessageTbc"];

  [self addChildViewController:vc];
  [self.view addSubview:vc.view];
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

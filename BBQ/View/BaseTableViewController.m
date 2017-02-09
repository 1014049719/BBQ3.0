//
//  BaseTableViewController.m
//  BBQ
//
//  Created by slovelys on 15/9/15.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.scrollEnabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [MTA trackPageViewBegin:[NSString
                              stringWithUTF8String:object_getClassName(self)]];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MTA trackPageViewEnd:[NSString
                            stringWithUTF8String:object_getClassName(self)]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data sourc

@end

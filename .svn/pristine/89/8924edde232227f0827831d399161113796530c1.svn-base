//
//  LimitsViewController.m
//  BBQ
//
//  Created by wth on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "LimitsViewController.h"

@interface LimitsViewController ()

@end

@implementation LimitsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}
- (IBAction)selectBtnClick:(UIButton *)sender {

  if (TheCurBaoBao.gxid.integerValue == BBQAuthorityTypeNormal) {
    [SVProgressHUD showErrorWithStatus:@"您没有权限设置"];
    sender.selected = NO;
    return;
  }

  if ([self.relativeModel.qx intValue] == 1) {
    [SVProgressHUD showErrorWithStatus:@"这个亲友是圈主，不能设置"];
    sender.selected = NO;
    return;
  }

  if (TheCurBaoBao.gxid.integerValue == BBQAuthorityTypeManager && [self.relativeModel.qx intValue] == BBQAuthorityTypeManager) {
    [SVProgressHUD showErrorWithStatus:@"您没有权限设置"];
    sender.selected = NO;
    return;
  }

  for (int i = 0; i < 3; i++) {
    UIButton *btn = (UIButton *)[self.view viewWithTag:10 + i];
    btn.selected = NO;

    UILabel *label = (UILabel *)[self.view viewWithTag:20 + i];
    label.textColor = [UIColor blackColor];
  }

  int qx = 3;

  sender.selected = YES;
  switch (sender.tag) {
  case 10: {

    qx = 2;
    UILabel *label = (UILabel *)[self.view viewWithTag:20];
    label.textColor = [UIColor colorWithRed:255 / 255.0
                                      green:74 / 255.0
                                       blue:37 / 255.0
                                      alpha:1];
  } break;
  case 11: {
    qx = 3;
    UILabel *label = (UILabel *)[self.view viewWithTag:21];
    label.textColor = [UIColor colorWithRed:255 / 255.0
                                      green:74 / 255.0
                                       blue:37 / 255.0
                                      alpha:1];
  } break;
  case 12: {
    UILabel *label = (UILabel *)[self.view viewWithTag:22];
    label.textColor = [UIColor colorWithRed:255 / 255.0
                                      green:74 / 255.0
                                       blue:37 / 255.0
                                      alpha:1];
  } break;
  default:
    break;
  }
  if (self.block) {
    self.block(qx);
    [self.navigationController popViewControllerAnimated:YES];
  }
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

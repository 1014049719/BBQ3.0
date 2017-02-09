//
//  CreatToDynamicViewController.m
//  BBQ
//
//  Created by wth on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "CreatToDynamicViewController.h"

@interface CreatToDynamicViewController ()

@end

@implementation CreatToDynamicViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

//按钮选中
- (IBAction)BtnClick:(UIButton *)sender {

  for (int i = 0; i < 3; i++) {
    UIButton *btn = (UIButton *)[self.view viewWithTag:10 + i];
    btn.selected = NO;
  }

  if (TheCurBaoBao.qx.integerValue != 1 && sender.tag != 10) {
    [SVProgressHUD showErrorWithStatus:@"对不起，您不能发动态到班级"];
    return;
  }

  sender.selected = YES;
  switch (sender.tag) {
  case 10: {

    self.block(@"1");
    [self.navigationController popViewControllerAnimated:YES];
  } break;
  case 11: {

    self.block(@"2");
    [self.navigationController popViewControllerAnimated:YES];
  } break;
  case 12: {

    self.block(@"3");
    [self.navigationController popViewControllerAnimated:YES];
  } break;
  default:
    break;
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

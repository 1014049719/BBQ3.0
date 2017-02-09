//
//  CustomerFirstTimeViewController.m
//  BBQ
//
//  Created by wth on 15/8/30.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "CustomerFirstTimeViewController.h"

@interface CustomerFirstTimeViewController ()

@property(weak, nonatomic) IBOutlet UITextField *customerFirstTimeTextField;

@end

@implementation CustomerFirstTimeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

//确认
- (IBAction)EnterBtnClick:(id)sender {

  self.firstTimeblock(_customerFirstTimeTextField.text);
  [self.navigationController popViewControllerAnimated:YES];
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

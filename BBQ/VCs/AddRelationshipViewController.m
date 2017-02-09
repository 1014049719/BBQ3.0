//
//  AddRelationshipViewController.m
//  BBQ
//
//  Created by slovelys on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "AddRelationshipViewController.h"
#import "userModifyTableViewController.h"
#import "AppDelegate.h"

@interface AddRelationshipViewController () <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UITextField *relaNameTextField;

@property(copy, nonatomic) NSString *addRelationship;

@end

@implementation AddRelationshipViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.relaNameTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  self.addRelationship = textField.text;
  [self.relaNameTextField resignFirstResponder];
}

- (IBAction)surnBtnEvent:(id)sender {
  [self.relaNameTextField endEditing:YES];

  if ([self.relaNameTextField.text isEqualToString:@""]) {
    [SVProgressHUD showErrorWithStatus:@"请输入新关系"];
    return;
  }

  if (self.block) {
    self.block(self.relaNameTextField.text);
  }

  NSArray *controllers = [self.navigationController viewControllers];
  if (controllers.count >= 3) {
    UIViewController *controller =
        [controllers objectAtIndex:controllers.count - 3];
    [self.navigationController popToViewController:controller animated:YES];
  } else {
    [self.navigationController popViewControllerAnimated:YES];
  }

  /*
  userModifyTableViewController *vcc =
  [self.navigationController.viewControllers
  objectAtIndex:self.navigationController.viewControllers.count - 3];
  vcc.addRelationshipName = self.addRelationship;
  [self.navigationController popToViewController:vcc animated:YES];
  */
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

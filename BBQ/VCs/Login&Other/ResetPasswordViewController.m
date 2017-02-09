//
//  ResetPasswordViewController.m
//  bbq
//
//  Created by 朱琨 on 15/7/3.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "JNKeychain.h"

@interface ResetPasswordViewController ()
@property(weak, nonatomic) IBOutlet UITextField *oldPassTextfield;
@property(weak, nonatomic) IBOutlet UITextField *PassNewTextField;
@property(weak, nonatomic) IBOutlet UITextField *PassAgainTextField;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

//确认重置密码
- (IBAction)EnterResetPassClick:(id)sender {

  NSString *FirstMiMaURL =
      [CS_URL_BASE stringByAppendingString:URL_UPDATE_PASSWORD];
  NSDictionary *Firstparams = @{
    @"oldpassword" : @"123456",
    @"newpassword" : _PassNewTextField
  };

  if ([_oldPassTextfield.text isEqualToString:@"123456"] &&
      [_PassNewTextField.text isEqualToString:_PassAgainTextField.text] &&
      [CheckTools checkPassword:_PassNewTextField.text]) {

    [HttpTool postWithPath:FirstMiMaURL
        params:Firstparams
        success:^(id JSON) {

          NSLog(@"初次密码修改请求成功。。%@", JSON);
          [[NSUserDefaults standardUserDefaults] setValue:_PassAgainTextField.text forKey:[NSString stringWithFormat:@"password%@", [TheCurUser.member.uid stringValue]]];
          //修改成功 隐藏
          dispatch_sync(dispatch_get_main_queue(), ^{

            [SVProgressHUD showWithStatus:@"密码修改成功"];

          });
        }
        failure:^(NSError *error) {
          NSLog(@"初次密码修改请求失败。。%@", error);

          //修改失败 弹出提示
          dispatch_sync(dispatch_get_main_queue(), ^{
              
                        });
        }];
  } else {
    [SVProgressHUD showErrorWithStatus:@"请检查输入格式是否正确"];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
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
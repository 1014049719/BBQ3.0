//
//  RegistViewController.m
//  bbq
//
//  Created by 朱琨 on 15/7/3.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import "RegistViewController.h"
#import <UITextField+Shake.h>
#import "CheckTools.h"
#import "userModifyTableViewController.h"
#import "VerifyCodeViewController.h"
#import "BBQRegisterApi.h"
#import <SSKeychain.h>

@interface RegistViewController () <UITextFieldDelegate, UIAlertViewDelegate,
NSURLSessionDelegate>

@property(weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property(weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property(weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property(weak, nonatomic) IBOutlet UILabel *phoneCheckLabel;
@property(weak, nonatomic) IBOutlet UILabel *passwordCheckLabel;
@property(weak, nonatomic) IBOutlet UILabel *repeatPasswordCheckLabel;
@property(assign, nonatomic) BOOL isTexting;



@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationItem.backBarButtonItem = item;
    
    self.phoneTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.repeatPasswordTextField.delegate = self;
    self.isTexting = NO;
    [self.phoneTextField addTarget:self
                            action:@selector(textFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self
                               action:@selector(textFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
    [self.repeatPasswordTextField addTarget:self
                                     action:@selector(textFieldDidChange:)
                           forControlEvents:UIControlEventEditingChanged];
}

- (IBAction)finishButtonClicked:(id)sender {
    if (![CheckTools checkTelNumber:self.phoneTextField.text] ||
        self.passwordTextField.text.length < 6 ||
        self.repeatPasswordTextField.text.length < 6 ||
        ![self.repeatPasswordTextField.text
          isEqualToString:self.passwordTextField.text]) {
            if (![CheckTools checkTelNumber:self.phoneTextField.text]) {
                self.phoneCheckLabel.text = @"*请输入正确的手机号码";
                [self.phoneTextField shake];
            }
            if (self.passwordTextField.text.length == 0) {
                self.passwordCheckLabel.text = @"*密码不能为空";
                [self.passwordTextField shake];
            } else if (self.passwordTextField.text.length < 6) {
                self.passwordCheckLabel.text = @"*密码不能少于6位";
                [self.passwordTextField shake];
            }
            if (self.repeatPasswordTextField.text.length == 0) {
                self.repeatPasswordCheckLabel.text = @"*请再次输入密码";
                [self.repeatPasswordTextField shake];
            } else if (![self.repeatPasswordTextField.text
                         isEqualToString:self.passwordTextField.text]) {
                self.repeatPasswordCheckLabel.text = @"*密码不一致，请重新输入";
                [self.repeatPasswordTextField shake];
            }
            return;
        }
    [self textFieldsResignFirstResponder];
    [self showAlert];
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.phoneTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.repeatPasswordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)textFieldsResignFirstResponder {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.repeatPasswordTextField resignFirstResponder];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.phoneTextField) {
        self.phoneCheckLabel.text = nil;
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    } else if (textField == self.passwordTextField ||
               textField == self.repeatPasswordTextField) {
        self.passwordCheckLabel.text = nil;
        self.repeatPasswordCheckLabel.text = nil;
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}

- (void)showAlert {
    NSString *message =
    [NSString stringWithFormat:@"您输入的注册手机号为\n%@",
     _phoneTextField.text];
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"提示"
                               message:message
                              delegate:self
                     cancelButtonTitle:@"有误，重新输入"
                     otherButtonTitles:@"确定", nil];
    [alert show];
}
#pragma mark - AlertView Delegate

- (void)alertView:(nonnull UIAlertView *)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        BBQRegisterApi *reg = [[BBQRegisterApi alloc] initWithUsername:self.phoneTextField.text password:self.passwordTextField.text];
        [reg startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSString *message = @"注册成功";
            [SSKeychain setPassword:self.passwordTextField.text forService:@"BBQ" account:self.phoneTextField.text];
            [SVProgressHUD showSuccessWithStatus:message];
            dispatch_after(
                           dispatch_time(DISPATCH_TIME_NOW,
                                         (int64_t)(HUD_DURATION(message) * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                               User *user = [[User alloc] init];
                               user.member.username = self.phoneTextField.text;
                               user.member.password = self.passwordTextField.text;
                               TheCurUser = user;
                               [self login:TheCurUser.member.username password:TheCurUser.member.password];
                           });
        } failure:^(YTKBaseRequest *request) {
            if (request.responseStatusCode == 200) {
                [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
            } else {
                [SVProgressHUD showErrorWithStatus:request.requestOperation.error.localizedDescription];
            }
        }];
    }
}

- (void)alertView:(nonnull UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
}

#pragma mark - 用户注册
- (void)regist {
}

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(textFieldsResignFirstResponder)
     name:UIKeyboardWillHideNotification
     object:nil];
    [self textFieldsResignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self textFieldsResignFirstResponder];
}

- (void)touchesBegan:(nonnull NSSet *)touches
           withEvent:(nullable UIEvent *)event {
    [self textFieldsResignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登录
- (void)login:(NSString *)strUserName password:(NSString *)strPassword {
    [SVProgressHUD showWithStatus:@"正在登录"];
    [BBQLoginManager loginWithUsername:strUserName password:strPassword loginType:BBQLoginTypeNormal success:^(YTKBaseRequest *request) {
        NSString *str = @"登录成功";
        [SVProgressHUD showSuccessWithStatus:str];
        dispatch_after(
                       dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(HUD_DURATION(str) * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           if ([CheckTools needCompleteUserInfo]) {
                               UIStoryboard *storyBoard =
                               [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
                               userModifyTableViewController *vc = [storyBoard
                                                                    instantiateViewControllerWithIdentifier:@"userModifyTabVcl"];
                               vc.type = BBQModifyUserInfoTypeLogin;
                               [self.navigationController pushViewController:vc animated:YES];
                           }
                       });
    } failure:^(YTKBaseRequest *request) {
        if (request.responseStatusCode == 200) {
            [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
        } else {
            [SVProgressHUD showErrorWithStatus:request.requestOperation.error.localizedDescription];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VerifySegue"]) {
        VerifyCodeViewController *vc = segue.destinationViewController;
        vc.type = BBQVerifyCodeTypeLogin;
    }
}

@end

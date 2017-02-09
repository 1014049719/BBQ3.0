//
//  LoginViewController.m
//  bbq
//
//  Created by 朱琨 on 15/7/3.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import "LoginViewController.h"

#import "PubFunction.h"
#import "CheckTools.h"
#import <UITextField+Shake.h>
#import "AppDelegate.h"
#import "CommonJson.h"
#import <MYBlurIntroductionView.h>
#import "ResetPassKeyTableViewController.h"
#import "userModifyTableViewController.h"
#import "VerifyCodeViewController.h"
#import "babyDataResetViewController.h"
#import "WelcomePageViewController.h"
#import "BBQLoginApi.h"
#import "BBQBabyModifyViewController.h"

@interface LoginViewController () <UITextFieldDelegate, MYIntroductionDelegate, YTKRequestDelegate>

@property(nonatomic, assign) BOOL isFirstLogin;

@property(weak, nonatomic) IBOutlet UITextField *m_tfUsername;
@property(weak, nonatomic) IBOutlet UIButton *registButton;
@property(weak, nonatomic) IBOutlet UITextField *m_tfPassword;
@property(weak, nonatomic) IBOutlet UIImageView *logo;
@property(weak, nonatomic) IBOutlet UIView *loginBg;
@property(weak, nonatomic) IBOutlet UIButton *loginButton;
@property(weak, nonatomic) IBOutlet UIView *password;
@property(weak, nonatomic) IBOutlet UIView *phoneNumber;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *loginBgTop;
@property(assign, nonatomic) BOOL isTexting;
@property(weak, nonatomic) IBOutlet UILabel *phoneCheckLabel;
@property(weak, nonatomic) IBOutlet UILabel *passwordCheckLabel;

@property(strong, nonatomic) IBOutletCollection(UIView)
NSArray *viewsNeedToMove;

//欢迎页
@property(strong, nonatomic) WelcomePageViewController *WelcomePageVCl;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#ifndef TARGET_PARENT
    self.registButton.hidden = YES;
#endif
}

//忘记密码
- (IBAction)ForgetPassBtnClick:(id)sender {
    UIStoryboard *storyBoard =
    [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    ResetPassKeyTableViewController *ResetPassVcl =
    [storyBoard instantiateViewControllerWithIdentifier:@"ResetPassVcl"];
    ResetPassVcl.phoneNum = _m_tfUsername.text;
    [self.navigationController pushViewController:ResetPassVcl animated:YES];
}

#pragma mark - MYIntroduction Delegate
- (void)introduction:(MYBlurIntroductionView *)introductionView
   didFinishWithType:(MYFinishType)finishType {
    [introductionView.subviews
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [introductionView removeFromSuperview];
}

#pragma mark - TextField Delegate
- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.m_tfUsername) {
        self.m_tfPassword.text = @"";
        self.phoneCheckLabel.text = nil;
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    } else {
        self.passwordCheckLabel.text = nil;
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!self.isTexting) {
        self.isTexting = YES;
        [self shouldShowKeyboard:YES];
    }
}

- (void)textFieldDidEndEditing:(nonnull UITextField *)textField {
    if (!self.isTexting) {
        [self shouldShowKeyboard:NO];
    }
}

- (void)shouldShowKeyboard:(BOOL)show {
    CGFloat distance = show ? -120 : 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.loginBgTop.constant = distance;
                             [self.view layoutIfNeeded];
                         }];
    });
}

- (void)textFieldsResignFirstResponder {
    self.isTexting = NO;
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.m_tfUsername) {
        [self.m_tfPassword becomeFirstResponder];
    } else {
        self.isTexting = NO;
        [textField resignFirstResponder];
    }
    return YES;
}

- (IBAction)loginButtonClicked:(id)sender {
    if (!self.m_tfUsername.text.length || !self.m_tfPassword.text.length) {
        if (!self.m_tfUsername.text.length) {
            self.phoneCheckLabel.text = @"*请输入用户名";
            [self.m_tfUsername shake];
        }
        if (!self.m_tfPassword.text.length) {
            self.passwordCheckLabel.text = @"*请输入密码";
            [self.m_tfPassword shake];
        }
        return;
    }

    [self.view endEditing:YES];
    [SVProgressHUD showWithStatus:@"请稍候..."];
    [BBQLoginManager loginWithUsername:self.m_tfUsername.text password:self.m_tfPassword.text loginType:BBQLoginTypeNormal success:^(YTKBaseRequest *request) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLoginStatus];
        ShowInfoWithCompletion(BBQHUDTypeSuccess, @"登陆成功", ^{
            if (!TheCurBaoBao && TheCurUser.member.groupkey.integerValue == 1) {
                [self performSegueWithIdentifier:@"InviteCodeSegue" sender:nil];
            } else if ([CheckTools needCompleteUserInfo]) {
                UIStoryboard *storyBoard =
                [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
                userModifyTableViewController *vc = [storyBoard
                                                     instantiateViewControllerWithIdentifier:@"userModifyTabVcl"];
                vc.type = BBQModifyUserInfoTypeLogin;
                [self.navigationController pushViewController:vc animated:YES];
            } else if ([CheckTools needCompleteBabyInfo]) {
                UIStoryboard *storyBoard =
                [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
                BBQBabyModifyViewController *vc = [storyBoard
                                                   instantiateViewControllerWithIdentifier:@"babyModifyVC"];
                vc.type = BBQBabyModifyTypeLogin;
                [self.navigationController pushViewController:vc animated:YES];
            } else if ([TheCurUser needResetPassword]) {
                UIStoryboard *storyBoard =
                [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
                ResetPassKeyTableViewController *ResetPassVcl = [storyBoard
                                                                 instantiateViewControllerWithIdentifier:@"ResetPassVcl"];
                ResetPassVcl.type = BBQResetPasswordTypeLogin;
                [self.navigationController pushViewController:ResetPassVcl
                                                     animated:YES];
            } else {
                [((AppDelegate *)[UIApplication sharedApplication].delegate)
                 setupTabBarController];
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

- (void)restoreRootViewController:(UIViewController *)rootViewController {
    typedef void (^Animation)(void);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:^(BOOL finished) {
                        if (finished) {
                        }
                    }];
}

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //引导页
    
    self.isFirstLogin = NO;
    
    self.m_tfPassword.delegate = self;
    self.m_tfUsername.delegate = self;
    
    [self.m_tfUsername addTarget:self
                          action:@selector(textFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
    [self.m_tfPassword addTarget:self
                          action:@selector(textFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(textFieldsResignFirstResponder)
     name:UIKeyboardWillHideNotification
     object:nil];
    [self textFieldsResignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    switch ([[[NSUserDefaults standardUserDefaults]
              objectForKey:@"loginType"] integerValue]) {
        case BBQLoginVCTypeNormal: {
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"needGuid"]) {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"needGuid"];
            }
        } break;
        case BBQVerifyCodeTypeLogin: {
            [[NSUserDefaults standardUserDefaults] setObject:@(BBQLoginVCTypeNormal)
                                                      forKey:@"loginType"];
            VerifyCodeViewController *vc =
            [self.storyboard instantiateViewControllerWithIdentifier:@"InviteCode"];
            vc.type = BBQVerifyCodeTypeLogin;
            [self.navigationController pushViewController:vc animated:NO];
        } break;
        case BBQLoginVCTypeCompleteUserInfo: {
            [[NSUserDefaults standardUserDefaults] setObject:@(BBQLoginVCTypeNormal)
                                                      forKey:@"loginType"];
            UIStoryboard *storyBoard =
            [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
            userModifyTableViewController *vc = [storyBoard
                                                 instantiateViewControllerWithIdentifier:@"userModifyTabVcl"];
            vc.type = BBQModifyUserInfoTypeLogin;
            [self.navigationController pushViewController:vc animated:NO];
        } break;
        case BBQLoginVCTypeCompleteBabyInfo: {
            [[NSUserDefaults standardUserDefaults] setObject:@(BBQLoginVCTypeNormal)
                                                      forKey:@"loginType"];
            UIStoryboard *storyBoard =
            [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
            BBQBabyModifyViewController *vc =
            [storyBoard instantiateViewControllerWithIdentifier:@"babyDataResetVC"];
            vc.type = BBQBabyModifyTypeLogin;
            [self.navigationController pushViewController:vc animated:NO];
        } break;
        case BBQLoginVCTypeResetPassword: {
            [[NSUserDefaults standardUserDefaults] setObject:@(BBQLoginVCTypeNormal)
                                                      forKey:@"loginType"];
            UIStoryboard *storyBoard =
            [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
            ResetPassKeyTableViewController *ResetPassVcl =
            [storyBoard instantiateViewControllerWithIdentifier:@"ResetPassVcl"];
            ResetPassVcl.type = BBQResetPasswordTypeLogin;
            [self.navigationController pushViewController:ResetPassVcl animated:NO];
        } break;
        default:
            break;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self textFieldsResignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"InviteCodeSegue"]) {
        VerifyCodeViewController *vc = segue.destinationViewController;
        vc.type = BBQVerifyCodeTypeLogin;
    }
}

#pragma mark - 手势取消输入
- (void)touchesBegan:(nonnull NSSet *)touches
           withEvent:(nullable UIEvent *)event {
    [self textFieldsResignFirstResponder];
}

#pragma mark - Request Delegate
- (void)requestFinished:(YTKBaseRequest *)request {
    
}

- (void)requestFailed:(YTKBaseRequest *)request {
    
}
@end

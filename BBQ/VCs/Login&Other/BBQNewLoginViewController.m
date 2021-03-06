//
//  BBQNewLoginViewController.m
//  BBQ
//
//  Created by slovelys on 15/11/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQNewLoginViewController.h"
#import "BBQLoginManager.h"
#import <Masonry.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "BBQViewNewLogin.h"
#import "LoginViewController.h"
#import <TPKeyboardAvoidingScrollView.h>

#import "CheckTools.h"
#import <UITextField+Shake.h>
#import "AppDelegate.h"
#import "CommonJson.h"
#import <MYBlurIntroductionView.h>
#import "ResetPassKeyTableViewController.h"
#import "userModifyTableViewController.h"
#import "VerifyCodeViewController.h"
#import "babyDataResetViewController.h"
#import "BBQDailyReportOption.h"
#import "WelcomePageViewController.h"
#import "BBQLoginApi.h"
#import "BBQBindingPhoneViewController.h"
#import "BBQAttentionViewController.h"
#import "CheckTools.h"
#import "BBQRegisterApi.h"
#import "BBQLoginManager.h"
#import "BBQAccountInfoTableViewController.h"
#import "BBQBabyModifyViewController.h"
#import "BBQLoginApi.h"
#import "ResetUserDataTableViewController.h"
#import "JJFMDB.h"
#import <SSKeychain.h>

@interface BBQNewLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *bgScrollView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIView *registView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registViewtTfHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldHeight;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *loginSanjiao;
@property (weak, nonatomic) IBOutlet UIImageView *registSanjiao;
@property (weak, nonatomic) IBOutlet UITextField *l_tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *l_tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *r_tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *r_tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *r_tfPasswordAgain;
@end

@implementation BBQNewLoginViewController

- (IBAction)forget_passwordBtnClicked:(id)sender {
    UIStoryboard *storyBoard =
    [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    ResetPassKeyTableViewController *ResetPassVcl =
    [storyBoard instantiateViewControllerWithIdentifier:@"ResetPassVcl"];
    ResetPassVcl.phoneNum = self.l_tfUsername.text ?: @"";
    [self.navigationController pushViewController:ResetPassVcl animated:YES];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
}

- (void)setupCustomView {
    _scrollHeight.constant = kScreenHeight;
    _loginView.layer.cornerRadius = 10;
    _registSanjiao.hidden = YES;
    if (kDevice_Is_iPhone4) {
        [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bgScrollView).offset(40);
        }];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginView.mas_bottom).with.offset(20);
        }];
        [_wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_bgScrollView).offset(-10);
        }];
        [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_wxLoginBtn.mas_top).with.offset(-10);
        }];
        _loginBtn.layer.cornerRadius = 20;
        _wxLoginBtn.layer.cornerRadius = 20;
        _qqLoginBtn.layer.cornerRadius = 20;
        _loginViewHeight.constant = 81;
        _textFieldHeight.constant = 40;
    } else if (kDevice_Is_iPhone5) {
        [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bgScrollView).offset(50);
        }];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginView.mas_bottom).with.offset(30);
        }];
        [_wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_bgScrollView).offset(-20);
        }];
        [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_wxLoginBtn.mas_top).with.offset(-20);
        }];
        
        _loginBtn.layer.cornerRadius = 22.5;
        _wxLoginBtn.layer.cornerRadius = 22.5;
        _qqLoginBtn.layer.cornerRadius = 22.5;
        _textFieldHeight.constant = 45;
        _loginViewHeight.constant = 91;
    }
    else {
        [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bgScrollView).offset(65);
        }];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginView.mas_bottom).with.offset(30);
        }];
        [_wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_bgScrollView).offset(-30);
        }];
        [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_wxLoginBtn.mas_top).with.offset(-30);
        }];
        
        _loginBtn.layer.cornerRadius = 25;
        _wxLoginBtn.layer.cornerRadius = 25;
        _qqLoginBtn.layer.cornerRadius = 25;
        _textFieldHeight.constant = 50;
        _loginViewHeight.constant = 101;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCustomView];
    [_wxLoginBtn setTitle:@" 微信登录" forState:UIControlStateNormal];
    [_wxLoginBtn setTitleColor:[UIColor colorWithHexString:@"6dcf6b"] forState:UIControlStateNormal];
    //    [_wxLoginBtn setImage:[UIImage imageNamed:@"wx_login"] forState:UIControlStateNormal];
    
    [_qqLoginBtn setTitle:@" QQ登录" forState:UIControlStateNormal];
    [_qqLoginBtn setTitleColor:[UIColor colorWithHexString:@"599def"] forState:UIControlStateNormal];
    //    [_qqLoginBtn setImage:[UIImage imageNamed:@"qq_login"] forState:UIControlStateNormal];
}

- (IBAction)loginBtnClicked:(id)sender {
    _registSanjiao.hidden = YES;
    _loginSanjiao.hidden = NO;
    [_registView removeFromSuperview];
    _loginView.hidden = NO;
    _loginView.backgroundColor = [UIColor whiteColor];
    if (kDevice_Is_iPhone4) {
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginView.mas_bottom).with.offset(20);
            make.height.mas_equalTo(@40);
        }];
    } else if (kDevice_Is_iPhone5) {
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginView.mas_bottom).with.offset(20);
            make.height.mas_equalTo(@45);
        }];
    } else {
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginView.mas_bottom).with.offset(30);
            make.height.mas_equalTo(@50);
        }];
    }
    
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
}

- (IBAction)registBtnClicked:(id)sender {
    _registSanjiao.hidden = NO;
    _loginSanjiao.hidden = YES;
    [_loginView resignFirstResponder];
    
    _loginView.hidden = YES;
    _loginView.backgroundColor = [UIColor clearColor];
    
    [_bgScrollView addSubview:_registView];
    [_registView becomeFirstResponder];
    _registView.userInteractionEnabled = YES;
    [_bgScrollView bringSubviewToFront:_registView];
    _registView.backgroundColor = [UIColor whiteColor];
    _registView.layer.cornerRadius = 10;
    
    
    if (kDevice_Is_iPhone4) {
        [_registView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginSanjiao.mas_bottom).with.offset(0);
            make.left.mas_equalTo(_bgScrollView).offset(15);
            make.right.mas_equalTo(_bgScrollView).offset(-15);
            make.height.mas_equalTo(@122);
        }];
        _registViewtTfHeight.constant = 40;
        
        [_loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_registView.mas_bottom).with.offset(20);
            make.height.mas_equalTo(@40);
            make.left.mas_equalTo(_bgScrollView).offset(15);
            make.right.mas_equalTo(_bgScrollView).offset(-15);
        }];
    } else if (kDevice_Is_iPhone5) {
        _registViewtTfHeight.constant = 45;
        [_registView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginSanjiao.mas_bottom).with.offset(0);
            make.left.mas_equalTo(_bgScrollView).offset(15);
            make.right.mas_equalTo(_bgScrollView).offset(-15);
            make.height.mas_equalTo(@137);
        }];
        [_loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_registView.mas_bottom).with.offset(20);
            make.height.mas_equalTo(@45);
            make.left.mas_equalTo(_bgScrollView).offset(15);
            make.right.mas_equalTo(_bgScrollView).offset(-15);
        }];
    }
    else {
        _registViewtTfHeight.constant = 50;
        [_registView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginSanjiao.mas_bottom).with.offset(0);
            make.left.mas_equalTo(_bgScrollView).offset(15);
            make.right.mas_equalTo(_bgScrollView).offset(-15);
            make.height.mas_equalTo(@152);
        }];
        [_loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_registView.mas_bottom).with.offset(30);
            make.height.mas_equalTo(@50);
            make.left.mas_equalTo(_bgScrollView).offset(15);
            make.right.mas_equalTo(_bgScrollView).offset(-15);
        }];
    }
    
    [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
}

- (IBAction)yellowBtnClicked:(id)sender {
    if ([((UIButton *)sender).titleLabel.text isEqualToString:@"登录"]) {
        [self sureToLogin];
    } else if ([((UIButton *)sender).titleLabel.text isEqualToString:@"注册"]) {
        [self sureToRegister];
    }
}

- (void)sureToRegister {
    if (![CheckTools checkTelNumber:self.r_tfUsername.text] ||
        self.r_tfPassword.text.length < 6 ||
        self.r_tfPasswordAgain.text.length < 6 ||
        ![self.r_tfPasswordAgain.text
          isEqualToString:self.r_tfPassword.text]) {
            if (![CheckTools checkTelNumber:_r_tfUsername.text]) {
                [CommonFunc showAlertView:@"请输入正确的手机号码"];
                return;
            }
            if (_r_tfUsername.text.length == 0) {
                [CommonFunc showAlertView:@"手机号不能为空"];
                return;
            }
            if (_r_tfUsername.text.length != 11) {
                [CommonFunc showAlertView:@"请输入正确的手机号码"];
                return;
            }
            if (_r_tfPassword.text.length == 0) {
                [CommonFunc showAlertView:@"密码不能为空"];
                return;
            } else if (_r_tfPassword.text.length < 6) {
                [CommonFunc showAlertView:@"密码不能少于6位"];
                return;
            } else if (_r_tfPassword.text.length > 16) {
                [CommonFunc showAlertView:@"密码不能超过16位"];
                return;
            }
            if (_r_tfPasswordAgain.text.length == 0) {
                [CommonFunc showAlertView:@"请再次输入密码"];
                return;
            } else if (![_r_tfPasswordAgain.text isEqualToString:_r_tfPassword.text]) {
                [CommonFunc showAlertView:@"密码不一致，请重新输入"];
                return;
            }
            [_r_tfUsername endEditing:YES];
            [_r_tfPassword endEditing:YES];
            [_r_tfPasswordAgain endEditing:YES];
            return;
        }
    [UIAlertView bk_showAlertViewWithTitle:@"提示" message:[NSString stringWithFormat:@"您输入的注册账号为：%@", _r_tfUsername.text] cancelButtonTitle:@"重新输入" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self registerApi];
        }
    }];
}

- (void)registerApi {
    [SVProgressHUD showWithStatus:@"请稍候"];
    BBQRegisterApi *reg = [[BBQRegisterApi alloc] initWithUsername:self.r_tfUsername.text password:self.r_tfPassword.text];
    reg.ignoreCache = YES;
    [reg startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSString *message = @"注册成功";
        [SSKeychain setPassword:self.r_tfPassword.text forService:@"BBQ" account:self.r_tfUsername.text];
        [SVProgressHUD showSuccessWithStatus:message];
        dispatch_after(
                       dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(HUD_DURATION(message) * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           User *user = [User new];
                           user.member.username = self.r_tfUsername.text;
                           user.member.password = self.r_tfPassword.text;
                           
                           [self newLogin:user.member.username password:user.member.password];
                       });
        
    } failure:^(YTKBaseRequest *request) {
        if (request.responseStatusCode == 200) {
            if ([request.responseJSONObject[@"res"] intValue] == 105 && [request.responseJSONObject[@"msg"] isEqualToString:@"用户名已经存在"]) {
                [SVProgressHUD showInfoWithStatus:@"该手机已经注册"];
            } else {
                [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:request.requestOperation.error.localizedDescription];
        }
    }];
}

- (void)sureToLogin {
    if (!self.l_tfUsername.text.length || !self.l_tfPassword.text.length) {
        if (!self.l_tfUsername.text.length) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        } else if (!self.l_tfPassword.text.length) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        }
        return;
    }
    [self.view endEditing:YES];
    [self newLogin:_l_tfUsername.text password:_l_tfPassword.text];
}

#pragma mark - 登录
- (void)newLogin:(NSString *)strUserName password:(NSString *)strPassword {
    [SVProgressHUD showWithStatus:@"请稍候..."];
    [BBQLoginManager loginWithUsername:strUserName password:strPassword loginType:BBQLoginTypeNormal success:^(YTKBaseRequest *request) {
        ShowInfoWithCompletion(BBQHUDTypeSuccess, @"登陆成功", ^{
            if (TheCurUser.member.realname.length == 0 || TheCurUser.member.firstlogin == YES) {
                UIStoryboard *storyBoard =
                [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
                ResetUserDataTableViewController *vc = [storyBoard
                                                        instantiateViewControllerWithIdentifier:@"ResetUserDataTbVcl"];
                if (!TheCurBaoBao) {
                    vc.resetType = BBQResetUserDataTypeRegist;
                } else {
                    vc.resetType = BBQResetUserDataTypeLogin;
                }
                [self.navigationController pushViewController:vc animated:YES];
            } else if (TheCurUser.member.firstlogin) {
                UIStoryboard *storyBoard =
                [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
                ResetUserDataTableViewController *vc = [storyBoard
                                                        instantiateViewControllerWithIdentifier:@"ResetUserDataTbVcl"];
                vc.resetType = BBQResetUserDataTypeLogin;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            else if (TheCurBaoBao && [CheckTools needCompleteBabyInfo]) {
                UIStoryboard *storyBoard =
                [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
                BBQBabyModifyViewController *vc = [storyBoard
                                                   instantiateViewControllerWithIdentifier:@"babyModifyVC"];
                vc.type = BBQBabyModifyTypeLogin;
                [self.navigationController pushViewController:vc animated:YES];
            } else if (!TheCurBaoBao && TheCurUser.member.groupkey.integerValue == 1) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
                BBQAttentionViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AttentionListBoard"];
                vc.type = BBQAttentionViewTypeLogin;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [((AppDelegate *)[UIApplication sharedApplication].delegate)
                 setupTabBarController];
            }
        });
    } failure:^(YTKBaseRequest *request) {
        ShowApiError
    }];
}

- (IBAction)wxBtnClicked:(id)sender {
    [self loginBtnClicked:nil];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            [self setLoginManagerWithSocialAccountEntity:snsAccount];
            [self loginWithUMSocialAccountEntity:snsAccount authtype:BBQLoginTypeWeChat];
        }
        
    });
}

- (IBAction)qqBtnClicked:(id)sender {
    [self loginBtnClicked:nil];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            [self setLoginManagerWithSocialAccountEntity:snsAccount];
            [self loginWithUMSocialAccountEntity:snsAccount authtype:BBQLoginTypeQQ];
        }});
}

- (void)setLoginManagerWithSocialAccountEntity:(UMSocialAccountEntity *)entity {
    BBQLoginManager *manager = [BBQLoginManager sharedManager];
    manager.openid = entity.openId;
    manager.nickname = entity.userName;
    manager.avartarurl = entity.iconURL;
    manager.access_token = entity.accessToken;
}

#pragma mark - 第三方登录
- (void)loginWithUMSocialAccountEntity:(UMSocialAccountEntity *)snsAccount authtype:(BBQLoginType)authtype {
    [SVProgressHUD showWithStatus:@"请稍候"];
    [BBQLoginManager loginWithUsername:nil password:nil loginType:authtype success:^(YTKBaseRequest *request) {
        if (!TheCurUser.isbind) {
            dispatch_async_on_main_queue(^{
                [SVProgressHUD dismiss];
                BBQBindingPhoneViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"bindingVC"];
                vc.loginType = authtype;
                vc.bdtype = BBQBindingPhoneTypeNormal;
                [self.navigationController pushViewController:vc animated:YES];
            });
        } else {
            if (TheCurUser.phone_bind || TheCurUser.qqbind || TheCurUser.wxbind) {
                if (!TheCurBaoBao) {
                    [self jumpToAttList];
                    return ;
                }
                if (![CheckTools needCompleteBabyInfo]) {
                    [((AppDelegate *)[UIApplication sharedApplication].delegate)
                     setupTabBarController];
                    return;
                }
                if ([CheckTools needCompleteBabyInfo]) {
                    UIStoryboard *storyBoard =
                    [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
                    BBQBabyModifyViewController *vc = [storyBoard
                                                       instantiateViewControllerWithIdentifier:@"babyModifyVC"];
                    vc.type = BBQBabyModifyTypeLogin;
                    [self.navigationController pushViewController:vc animated:YES];
                    return;
                }
            } else {
                BBQBindingPhoneViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"bindingVC"];
                vc.loginType = authtype;
                vc.bdtype = BBQBindingPhoneTypeNormal;
                [self.navigationController pushViewController:vc animated:YES];
                //                            BBQAccountInfoTableViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"accountInfoVC"];
                //                            [self.navigationController pushViewController:vc animated:YES];
                return;
            }

        }
    } failure:^(YTKBaseRequest *request) {
        ShowApiError
    }];
}

- (void)jumpToAttList {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    BBQAttentionViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AttentionListBoard"];
    vc.type = BBQAttentionViewTypeLogin;
    [self.navigationController pushViewController:vc animated:YES];
    
//            BBQAccountInfoTableViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"accountInfoVC"];
//            [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end

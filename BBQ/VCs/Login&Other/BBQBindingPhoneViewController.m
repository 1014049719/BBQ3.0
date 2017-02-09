//
//  BBQBindingPhoneViewController.m
//  BBQ
//
//  Created by slovelys on 15/11/20.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBindingPhoneViewController.h"
#import "BBQAttentionViewController.h"
#import "BBQLoginManager.h"
#import "BBQAccountInfoTableViewController.h"
#import "BBQReleasePhoneApi.h"
#import "AppDelegate.h"
#import "BBQBabyModifyViewController.h"
#import "ResetUserDataTableViewController.h"

@interface BBQBindingPhoneViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf_phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tf_verifierCode;
@property (weak, nonatomic) IBOutlet UIButton *btn_verifierCode;
@property (weak, nonatomic) IBOutlet UIButton *btn_nextStep;

@end

@implementation BBQBindingPhoneViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    _btn_verifierCode.layer.cornerRadius = 20;
    _btn_nextStep.layer.cornerRadius = 25;
    [_btn_nextStep setBackgroundColor:[UIColor colorWithHexString:@"ff6440"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    if (_bdtype == BBQBindingPhoneTypeModify) {
//        self.title = @"修改绑定手机";
//        [_btn_nextStep setTitle:@"修改绑定手机" forState:UIControlStateNormal];
//    } else {
//        self.title = @"绑定手机号";
//    }
    self.title = @"绑定手机号";
    _tf_phoneNumber.delegate = self;
    _tf_verifierCode.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [self.view addGestureRecognizer:tap];
    if (self.bdtype == BBQBindingPhoneTypeNormal) {
        UIBarButtonItem *rightItem =
        [[UIBarButtonItem alloc] initWithTitle:@"跳过"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(rightItemEvent)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)tapEvent {
    [_tf_phoneNumber endEditing:YES];
    [_tf_verifierCode endEditing:YES];
}

- (void)rightItemEvent {
    [self autocreateAccountToLogin];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (IBAction)verifyBtnClicked:(id)sender {
    [_tf_phoneNumber endEditing:YES];
    [_tf_verifierCode endEditing:YES];
    
    
    if (![CheckTools checkTelNumber:_tf_phoneNumber.text]) {
        [CommonFunc showAlertView:@"请输入正确的手机号码"];
        return;
    }
    if (_tf_phoneNumber.text.length == 0) {
        [CommonFunc showAlertView:@"请输入手机号"];
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"请稍候..."];
    
    NSDictionary *params = @{ @"mobile" : _tf_phoneNumber.text };
    
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeSendVerifyCode
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         NSString *message = @"已发送验证码，请注意查收";
         [SVProgressHUD showSuccessWithStatus:message];
     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
     }
     failureHandler:nil];
}
- (IBAction)nextStepBtnClicked:(id)sender {
    [_tf_phoneNumber endEditing:YES];
    [_tf_verifierCode endEditing:YES];
    
    if (![CheckTools checkTelNumber:_tf_phoneNumber.text]) {
        [CommonFunc showAlertView:@"请输入正确的手机号码"];
        return;
    }
    if (_tf_phoneNumber.text.length == 0) {
        [CommonFunc showAlertView:@"请输入手机号"];
        return;
    }
    if (_tf_verifierCode.text.length == 0) {
        [CommonFunc showAlertView:@"请输入验证码"];
        return;
    }
    if (_bdtype == BBQBindingPhoneTypeModify) {
        [self bindAfterLogin];
    } else {
        BBQLoginManager *manager = [BBQLoginManager sharedManager];
        manager.mobile = _tf_phoneNumber.text;
        manager.yzcode = _tf_verifierCode.text;
        [self bindingMobileToLogin];
    }
    
}

- (void)bindAfterLogin {
    [SVProgressHUD showWithStatus:@"请稍候"];
    BBQReleasePhoneApi *api = [[BBQReleasePhoneApi alloc] initWithMobile:_tf_phoneNumber.text yzm:_tf_verifierCode.text];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject[@"res"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"绑定手机成功"];
            TheCurUser.member.username = _tf_phoneNumber.text;
            TheCurUser.phone_bind = YES;
            if (self.blcok) {
                self.blcok();
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
        }
    } failure:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
    }];
}

- (void)autocreateAccountToLogin {
    [SVProgressHUD showWithStatus:@"请稍候"];
    BBQLoginType type;
    switch (_loginType) {
        case BBQLoginTypeWeChat:
            type = BBQLoginTypeAutoCreateWithWeChat;
            break;
        case BBQLoginTypeQQ:
            type = BBQLoginTypeAutoCreateWithQQ;
            break;
            
        default:
            break;
    }
    [BBQLoginManager loginWithUsername:nil password:nil loginType:type success:^(YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self jumpToAttList];
    } failure:^(YTKBaseRequest *request) {
        if (request.responseStatusCode == 200) {
            [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
        } else {
            [SVProgressHUD showErrorWithStatus:request.requestOperation.error.localizedDescription];
        }
    }];
}

- (void)bindingMobileToLogin {
    [SVProgressHUD showWithStatus:@"请稍候"];
    BBQLoginType type;
    switch (_loginType) {
        case BBQLoginTypeWeChat:
            type = BBQLoginTypeBindingPhoneWithWeChat;
            break;
        case BBQLoginTypeQQ:
            type = BBQLoginTypeBindingPhoneWithQQ;
            break;
            
        default:
            break;
    }
    [BBQLoginManager loginWithUsername:nil password:nil loginType:type success:^(YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
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
        } else if (!TheCurBaoBao) {
            [self jumpToAttList];
        } else if ([CheckTools needCompleteBabyInfo]) {
            UIStoryboard *storyBoard =
            [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
            BBQBabyModifyViewController *vc = [storyBoard
                                               instantiateViewControllerWithIdentifier:@"babyModifyVC"];
            vc.type = BBQBabyModifyTypeLogin;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            [((AppDelegate *)[UIApplication sharedApplication].delegate)
             setupTabBarController];
        }
    } failure:^(YTKBaseRequest *request) {
        if (request.responseStatusCode == 200) {
            [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
        } else {
            [SVProgressHUD showErrorWithStatus:request.requestOperation.error.localizedDescription];
        }
    }];
}

- (void)jumpToAttList {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    BBQAttentionViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AttentionListBoard"];
    vc.type = BBQAttentionViewTypeLogin;
    [self.navigationController pushViewController:vc animated:YES];
    
//    BBQAccountInfoTableViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"accountInfoVC"];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

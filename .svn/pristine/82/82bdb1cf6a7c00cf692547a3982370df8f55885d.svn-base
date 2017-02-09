//
//  VerifyCodeViewController.m
//  JYEX
//
//  Created by 朱琨 on 15/7/4.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import "VerifyCodeViewController.h"
#import "userModifyTableViewController.h"
#import "babyDataResetViewController.h"
#import "ResetPassKeyTableViewController.h"
#import "AppDelegate.h"
#import "CheckTools.h"
#import "BBQBabyModifyViewController.h"

@interface VerifyCodeViewController () <UIAlertViewDelegate,
                                        UINavigationBarDelegate>

@property(weak, nonatomic) IBOutlet UITextField *codeTextField;
@property(strong, nonatomic) BBQBabyModel *baobao;

@end

@implementation VerifyCodeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
//  [TheGlobal getQnToken];
  if (self.type == BBQVerifyCodeTypeLogin) {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController
        setViewControllers:
            @[ self.navigationController.viewControllers.firstObject, self ]
                  animated:NO];
  }
}
- (IBAction)verifyButtonDidClick:(id)sender {
  if ([self.codeTextField.text isEqualToString:@""] ||
      self.codeTextField.text.length != 6) {
    [SVProgressHUD showErrorWithStatus:@"请输入6位邀请码"];
  } else {
    [self verifyRequestCode:self.codeTextField.text];
  }
}

- (void)showAlertWithName:(NSString *)name {
  NSString *message =
      [NSString stringWithFormat:@"您已经成功添加了宝宝\"%@"
                                 @"\"，现在可以看到宝宝的最新变化了。",
                                 name];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:message
                                                 delegate:self
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil, nil];
  [alert show];
}

#pragma mark - AlertView Delegate
- (void)alertView:(nonnull UIAlertView *)alertView
    didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (self.type == BBQVerifyCodeTypeNormal) {
    UIStoryboard *storyBoard =
        [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    userModifyTableViewController *vc = [storyBoard
        instantiateViewControllerWithIdentifier:@"userModifyTabVcl"];
    vc.baobao = self.baobao;
    vc.type = BBQModifyUserInfoTypeAddBaby;
    [self.navigationController pushViewController:vc animated:YES];
  } else if (self.type == BBQVerifyCodeTypeLogin) {
    TheCurBaoBao = self.baobao;
    if ([CheckTools needCompleteUserInfo]) {
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
      ResetPassKeyTableViewController *ResetPassVcl =
          [storyBoard instantiateViewControllerWithIdentifier:@"ResetPassVcl"];
      ResetPassVcl.type = BBQResetPasswordTypeLogin;
      [self.navigationController pushViewController:ResetPassVcl animated:YES];
    }
  }
}

#pragma mark - 验证邀请码
- (void)verifyRequestCode:(NSString *)requestcode {
  [SVProgressHUD showWithStatus:@"请稍候..."];
  NSDictionary *params = @{ @"requestcode" : requestcode };
  [BBQHTTPRequest
       queryWithType:BBQHTTPRequestTypeVerifyInviteCode
               param:params
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        [SVProgressHUD dismiss];
        NSDictionary *dicdata = responseObject[@"data"];
        NSString *uid = dicdata[@"uid"];
        if (dicdata && uid) {
            self.baobao = [BBQBabyModel modelWithDictionary:dicdata];
            [TheCurUser addABaby:_baobao];
        }
        [self showAlertWithName:dicdata[@"realname"]];
      } errorHandler:nil
      failureHandler:nil];
}
//- (void)restoreRootViewController:(UIViewController *)rootViewController
//{
//    typedef void (^Animation)(void);
//    UIWindow* window = [UIApplication sharedApplication].keyWindow;
//
//    rootViewController.modalTransitionStyle =
//    UIModalTransitionStyleCrossDissolve;
//    Animation animation = ^{
//        BOOL oldState = [UIView areAnimationsEnabled];
//        [UIView setAnimationsEnabled:NO];
//        window.rootViewController = rootViewController;
//        [UIView setAnimationsEnabled:oldState];
//    };
//
//    [UIView transitionWithView:window
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:animation
//                    completion:nil];
//}

@end

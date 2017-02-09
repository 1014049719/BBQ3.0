//
//  UsersProblemViewController.m
//  BBQ
//
//  Created by wth on 15/7/23.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "UsersProblemViewController.h"

@interface UsersProblemViewController () <UITextViewDelegate>
@property(weak, nonatomic) IBOutlet UITextView *problemTextView;
@property(weak, nonatomic) IBOutlet UILabel *placeHoldLabel;
@property(weak, nonatomic) IBOutlet UITextField *numTextField;

@end

@implementation UsersProblemViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  _problemTextView.delegate = self;
}

//输入反馈信息 隐藏提示label
- (void)textViewDidChange:(UITextView *)textView {

  _placeHoldLabel.hidden = YES;
}

//拨打服务热线
- (IBAction)hotLineNumBtnClick:(id)sender {

  [[UIApplication sharedApplication]
      openURL:[NSURL URLWithString:@"tel://4000903011"]];
}

/// 验证button点击
- (IBAction)surnButtonEvent:(id)sender {
  if (self.problemTextView.text.length == 0) {
    [CommonFunc showAlertView:@"请描述您的问题或改进意见"];
  } else if (self.numTextField.text.length == 0) {
    [CommonFunc showAlertView:@"请填写您的联系方式"];
  } else {
    [self postDate];
  }
}

- (void)postDate {
  [SVProgressHUD showWithStatus:@"正在保存中"];

  NSString *strNetwork = @"";
//  if (netType == NotReachable)
//    strNetwork = @"NotReachable";
//  else if (netType == ReachableViaWWAN)
//    strNetwork = @"2G/3G";
//  else if (netType == ReachableViaWiFi)
//    strNetwork = @"WIFI";

  NSDictionary *params = @{
    @"appid" : BBQ_APPID,
    @"appname" : [CommonFunc getAppName],
    @"appsource" : JYEX_APPSROUCE,
    @"ostype" : [[UIDevice currentDevice] systemName],
    @"osver" : [[UIDevice currentDevice] systemVersion],
    @"phonetype" : [[UIDevice currentDevice] model],
    @"token" : [BBQLoginManager sharedManager].token,
    @"network" : @"Wi-Fi",
    @"appver" : [[UIApplication sharedApplication] appVersion],
    @"content" : self.problemTextView.text,
    @"tel" : self.numTextField.text
  };

  [BBQHTTPRequest
       queryWithType:BBQHTTPRequestTypePostUserProblem
               param:params
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        NSString *message = @"保存成功";
        [SVProgressHUD showSuccessWithStatus:message];
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW,
                          (int64_t)(HUD_DURATION(message) * NSEC_PER_SEC)),
            dispatch_get_main_queue(), ^{
              [self.navigationController popViewControllerAnimated:YES];
            });
      } errorHandler:^(NSDictionary *responseObject) {
          [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
      } failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
          [SVProgressHUD showErrorWithStatus:error.localizedDescription];
      }
   ];
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

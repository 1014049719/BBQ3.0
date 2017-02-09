//
//  SendInvitationViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/7/22.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "SendInvitationViewController.h"
#import "AppMacro.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "UMSocialQQHandler.h"
#import <MessageUI/MessageUI.h>

@interface SendInvitationViewController () <
    MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>
@property(weak, nonatomic) IBOutlet UILabel *lbRequestCode;
@property(weak, nonatomic) IBOutlet UIButton *btnSms;

@property(weak, nonatomic) IBOutlet UIButton *btnWx;
@property(weak, nonatomic) IBOutlet UIButton *btnQQ;

@property(weak, nonatomic) IBOutlet UILabel *lbDesc;

@property(weak, nonatomic) IBOutlet UIButton *retryButton;
@property(nonatomic, copy) NSString *requestcode;

@property(nonatomic, assign) CGFloat originY;
@property(nonatomic, assign) BOOL hasShared;
@property(weak, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) BBQBabyModel *curBaby;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation SendInvitationViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    BBQBabyModel *tempbaby = nil;
    if ([TheCurBaoBao.qx isEqualToNumber:@1] || [TheCurBaoBao.qx isEqualToNumber:@2]){
        tempbaby = TheCurBaoBao;
    }else{
        for (BBQBabyModel *baby in TheCurUser.baobaodata) {
            if ([baby.qx isEqualToNumber:@1] || [baby.qx isEqualToNumber:@2]){
                tempbaby = baby;
                break;
            }
        }
    }
  self.curBaby = tempbaby?:TheCurBaoBao;
  [self getInvitationCode:self.curBaby.uid.stringValue];
  self.retryButton.layer.cornerRadius = 5;
  self.retryButton.layer.masksToBounds = YES;
  self.retryButton.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
  self.retryButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_hasShared) {
        if (self.guideTaskCallBack != nil) {
            self.guideTaskCallBack();
        }else{
            [[NSNotificationCenter defaultCenter]
             postNotificationName:kFinishedNewGuideTaskNotification object:nil userInfo:@{@"taskno" : [NSNumber numberWithInteger:BBQNewGuideTaskTypeInvite] }];
        }
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)clickCancelKeyboardBtn:(id)sender {
  //    [self.mobilephone resignFirstResponder];
}

- (IBAction)clickSmsBtn:(UIButton *)sender {

  NSString *content =
      [NSString stringWithFormat:@"我在[宝宝圈]中放了%@的最新照片."
                                 @"安装应用并输入邀请码:%@  "
                                 @"就可以看到了.下载地址:%@",
                                 self.curBaby.realname, self.requestcode,
                                 [self getAppDownloadURL]];

  [self sendMessage:content];
}

- (IBAction)clickWxBtn:(UIButton *)sender {

  [UMSocialData defaultData].extConfig.wechatSessionData.url =
      [self getAppDownloadURL];
  [UMSocialData defaultData].extConfig.wechatSessionData.title =
      [self getTitle];

  [[UMSocialDataService defaultDataService]
         postSNSWithTypes:@[ UMShareToWechatSession ]
                  content:[self getContent]
                    image:[UIImage imageNamed:@"place_color_pander"]
                 location:nil
              urlResource:nil
      presentedController:nil
               completion:^(UMSocialResponseEntity *response) {
                 if (response.responseCode == UMSResponseCodeSuccess) {
                     if ([TheCurUser needRefreshNewGuideTask:BBQNewGuideTaskTypeInvite]) {
                         [self uploadNewGuideTask];
                     }
                   NSLog(@"分享成功");
                 } else if (response.responseCode != UMSResponseCodeCancel) {
                 }
               }];
}

- (IBAction)didClickRetryButton:(id)sender {
  [self getInvitationCode:self.curBaby.uid.stringValue];
}

- (IBAction)clickQQBtn:(UIButton *)sender {

  [UMSocialData defaultData].extConfig.qqData.url = [self getAppDownloadURL];
  [UMSocialData defaultData].extConfig.qqData.title = [self getTitle];
  [UMSocialQQHandler setQQWithAppId:@"1104761282"
                             appKey:@"vtnnMN5Ixc56gooz"
                                url:[self getAppDownloadURL]];

  [[UMSocialDataService defaultDataService]
         postSNSWithTypes:@[ UMShareToQQ ]
                  content:[self getContent]
                    image:[UIImage imageNamed:@"place_color_pander"]
                 location:nil
              urlResource:nil
      presentedController:nil
               completion:^(UMSocialResponseEntity *response) {
                 if (response.responseCode == UMSResponseCodeSuccess) {
                   NSLog(@"分享成功！");
                     if ([TheCurUser needRefreshNewGuideTask:BBQNewGuideTaskTypeInvite]) {
                         [self uploadNewGuideTask];
                     }
                 }
               }];
}

- (NSString *)getTitle {
  NSString *string = [NSString stringWithFormat:@"邀请码%@", self.requestcode];
  return string;
}

- (NSString *)getContent {
  NSString *string = [NSString
      stringWithFormat:
          @"请下载安装[宝宝圈],输入邀请码查看%@的新照片",
          self.curBaby.realname];
  return string;
}

- (UMSocialUrlResource *)getUrlResoure {
  UMSocialUrlResourceType resourcetype;
  if (APPLE_ID) {
    NSString *url = [self getAppDownloadURL];

    UMSocialUrlResource *urlResource =
        [[UMSocialUrlResource alloc] initWithSnsResourceType:resourcetype
                                                         url:url];

    return urlResource;
  }
  return nil;
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

#pragma mark -network

///获取邀请码
- (void)getInvitationCode:(NSString *)baobaouid {

  self.loadingView.hidden = NO;
  self.retryButton.hidden = YES;
  self.lbRequestCode.hidden = YES;

  [self.indicator startAnimating];

  [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGetInviteCode
      param:@{
        @"baobaouid" : self.curBaby.uid
      }
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        dispatch_async_on_main_queue((^{
          self.loadingView.hidden = YES;
          self.retryButton.hidden = YES;
          self.lbRequestCode.hidden = NO;
          [self.indicator stopAnimating];

          NSNumber *code = responseObject[@"requestcode"];
          self.lbRequestCode.text =
              [NSString stringWithFormat:@"%ld", code.integerValue];
          self.requestcode = self.lbRequestCode.text;
          self.btnQQ.enabled = YES;
          self.btnSms.enabled = YES;
          self.btnWx.enabled = YES;
        }));
      }
      errorHandler:^(NSDictionary *responseObject) {
        dispatch_async_on_main_queue(^{
          [self.indicator stopAnimating];
          self.loadingView.hidden = YES;
          self.retryButton.hidden = NO;
          self.lbRequestCode.hidden = YES;
        });
      }
      failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async_on_main_queue(^{
          [self.indicator stopAnimating];
          self.loadingView.hidden = YES;
          self.retryButton.hidden = NO;
          self.lbRequestCode.hidden = YES;
        });
      }];
}

- (NSString *)getAppDownloadURL {
  // NSString *str = [NSString
  // stringWithFormat:@"http://itunes.apple.com/us/app/id%@", APPLE_ID];
  // return str;

//  return [CS_URL_BASE stringByAppendingString:URL_DOWNLOAD_URL];
    return @"http://dwz.cn/1G1HNn";
}

//通过发送短信处理
//发送短信的方法
- (void)sendMessage:(NSString *)messageContent {
  //用于判断是否有发送短信的功能（模拟器上就没有短信功能）
  Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));

  //判断是否有短信功能
  if (!messageClass) {
    [SVProgressHUD showErrorWithStatus:@"您的设备不支持发送短信。"];
    return;
  }

  //有短信功能
  if (![messageClass canSendText]) {
    [SVProgressHUD showErrorWithStatus:@"您的设备不支持发送短信。"];
    return;
  }

  //有发送功能要做的事情
  //实例化MFMessageComposeViewController,并设置委托
  MFMessageComposeViewController *messageController =
      [[MFMessageComposeViewController alloc] init];
  [messageController setNavigationBarHidden:YES animated:NO];
  messageController.navigationBar.hidden = YES;
  messageController.messageComposeDelegate = self;

  //拼接并设置短信内容
  // NSString *messageContent = @"12223333";
  messageController.body = messageContent;

  //设置发送给谁
  // messageController.recipients = @[self.phoneNumberTextField.text];

  //推到发送试图控制器
  [self presentViewController:messageController
                     animated:YES
                   completion:^{

                   }];
}

//发送短信后回调的方法
- (void)messageComposeViewController:
            (MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
  NSString *tipContent;
  switch (result) {
  case MessageComposeResultCancelled:
    tipContent = @"发送短信已取消";
    break;

  case MessageComposeResultFailed:
    tipContent = @"发送短信失败";
    break;

  case MessageComposeResultSent:
    tipContent = @"发送成功";
    if ([TheCurUser needRefreshNewGuideTask:BBQNewGuideTaskTypeInvite]) {
      [self uploadNewGuideTask];
    }
    break;

  default:
    break;
  }

  [controller dismissViewControllerAnimated:YES completion:nil];
}
-(void)uploadNewGuideTask{
    self.hasShared = YES;
    NSDictionary *param = @{ @"actionid" : @7
                             };
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeUploadAction
     param:param
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         NSLog(@"%@",responseObject);
         
     } errorHandler:^(NSDictionary *responseObject) {
         
         
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
         
     }];
    
    
}
@end

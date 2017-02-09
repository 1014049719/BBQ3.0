//
//  BBQTeacherInviteViewController.m
//  BBQ
//
//  Created by anymuse on 15/11/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQTeacherInviteViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "UMSocialQQHandler.h"
#import <MessageUI/MessageUI.h>

@interface BBQTeacherInviteViewController ()<
MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>
@property(weak, nonatomic) IBOutlet UILabel *lbRequestCode;
@property(weak, nonatomic) IBOutlet UIButton *btnSms;

@property(weak, nonatomic) IBOutlet UIButton *btnWx;
@property(weak, nonatomic) IBOutlet UIButton *btnQQ;

@property(weak, nonatomic) IBOutlet UILabel *lbDesc;

@property(weak, nonatomic) IBOutlet UIButton *retryButton;


@property(nonatomic, strong) BBQClassDataModel *classModel;
@property(nonatomic, strong) BBQSchoolDataModel *schoolModel;
@property(nonatomic, copy) NSString *requestcode;

@property(nonatomic, assign) CGFloat originY;
@property(weak, nonatomic) IBOutlet UIView *loadingView;

@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *invitedescLabel;

@end

@implementation BBQTeacherInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.schoolModel = [TheCurUser.schooldata firstObject];
    self.classModel = [TheCurUser.classdata firstObject];
    self.invitedescLabel.text = [NSString stringWithFormat:@"%@%@邀请码",self.schoolModel.schoolname,self.classModel.classname];
    [self getInvitationCode:self.classModel.classid.stringValue];
    self.retryButton.layer.cornerRadius = 5;
    self.retryButton.layer.masksToBounds = YES;
    self.retryButton.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    self.retryButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    [self setupNav];
}

- (void)setupNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"邀请管理" style:UIBarButtonItemStyleDone target:self action:@selector(inviteManage)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}
-(void)inviteManage{
    
    [self performSegueWithIdentifier:@"inviteManager" sender:nil];
}
- (IBAction)clickCancelKeyboardBtn:(id)sender {
    
}
- (IBAction)clickSmsBtn:(UIButton *)sender {
    NSString *content = [self getContent];
    NSString *appendStr =  [NSString stringWithFormat:@"运行APP后 输入邀请码:%@  "
                            @"就可加入.APP地址:%@",
                            self.requestcode,
                            [self getAppDownloadURL]];
    content = [content stringByAppendingString:appendStr];
    
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
             NSLog(@"分享成功");
         } else if (response.responseCode != UMSResponseCodeCancel) {
         }
     }];
}

- (IBAction)didClickRetryButton:(id)sender {
    [self getInvitationCode:self.classModel.classid.stringValue];
}

- (IBAction)clickQQBtn:(UIButton *)sender {
    
    [UMSocialData defaultData].extConfig.qqData.url = [self getAppDownloadURL];
    [UMSocialData defaultData].extConfig.qqData.title = [self getTitle];
    [UMSocialQQHandler setQQWithAppId:@"1104803224"
                               appKey:@"UA0XxanXoaui9RHx"
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
             NSLog(@"分享成功");
         }
     }];
}

- (NSString *)getTitle {
    NSString *string = [NSString stringWithFormat:@"邀请码%@", self.requestcode];
    return string;
}
//“XX幼儿园XX班在宝宝圈开通了，XX老师邀请您加入
- (NSString *)getContent {
    NSString *string = [NSString
                        stringWithFormat:
                        @"%@%@在宝宝圈开通了,%@邀请您加入!",self.schoolModel.schoolname,
                        self.classModel.classname,TheCurUser.member.realname];
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
#pragma mark -network

///获取邀请码
- (void)getInvitationCode:(NSString *)baobaouid {
    self.loadingView.hidden = NO;
    self.retryButton.hidden = YES;
    self.lbRequestCode.hidden = YES;
    
    [self.indicator startAnimating];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"baobaouid"] = [NSNumber numberWithString:baobaouid];
    param[@"type"] = @2;
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGetInviteCode
                            param:param
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
                       NSLog(@"%@",error);
                       dispatch_async_on_main_queue(^{
                           [self.indicator stopAnimating];
                           self.loadingView.hidden = YES;
                           self.retryButton.hidden = NO;
                           self.lbRequestCode.hidden = YES;
                       });
                   }];
}

//-------------------------
//通过短信发送邀请码
- (void)sendInvitionCodeUsingAsi:(NSString *)code {
//    
//    NSDictionary *dic = @{ @"mobile" : code, @"content" : self.requestcode };
//    
}

- (NSString *)getAppDownloadURL {
    // NSString *str = [NSString
    // stringWithFormat:@"http://itunes.apple.com/us/app/id%@", APPLE_ID];
    // return str;
    return @"http://dwz.cn/1G1HNn";
    //return [CS_URL_BASE stringByAppendingString:URL_DOWNLOAD_URL];
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
            break;
            
        default:
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end

//
//  BBQUnReadManager.m
//  BBQ
//
//  Created by 朱琨 on 15/12/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQUnReadManager.h"
#import "MessageViewController.h"
#import "AppDelegate.h"
#import <DateTools.h>

@implementation BBQUnReadManager

+ (instancetype)sharedManager{
    static BBQUnReadManager *sharedManager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)updateUnRead {
    
}

#pragma mark - 消息推送相关
/// 保存
- (void)saveUserinfo:(NSDictionary *)userinfo {
    _isHasPushUserinfo = YES;
    _pushUserinfo = userinfo;
}
/// 读取
- (NSDictionary *)readUserinfo {
    if (!_isHasPushUserinfo) {
        return nil;
    }
    return _pushUserinfo;
}
/// 清除
- (void)clearPushUserinfo {
    _isHasPushUserinfo = NO;
    _pushUserinfo = nil;
}
/// 新消息处理
- (void)handlePushInfo {
    if (_pushUserinfo) {
        NSDictionary *aps = [_pushUserinfo objectForKey:@"aps"];
        NSString *alert = @"收到新消息";
        if (aps)
            alert = [aps objectForKey:@"alert"];
        
        NSString *url = [_pushUserinfo objectForKey:@"url"];
        NSNumber *omode = [_pushUserinfo objectForKey:@"op"];
        
//        NSString *ts = [_pushUserinfo objectForKey:@"ts"];
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[ts doubleValue]];
//        NSString *sec = [NSString stringWithFormat:@"%.0f", date.secondsAgo];
//        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
//                if (sec.integerValue <= 3) {
//                    [MTA trackCustomKeyValueEvent:kMTAXGWiFi03 props:@{ @"xgwifi03" : @1 }];
//                } else if (sec.integerValue > 3 && sec.integerValue <= 7) {
//                    [MTA trackCustomKeyValueEvent:kMTAXGWiFi37 props:@{ @"xgwifi37" : @1 }];
//                } else {
//                    [MTA trackCustomKeyValueEvent:kMTAXGWiFi7 props:@{ @"xgwifi7" : @1 }];
//                }
//            } else {
//                if (sec.integerValue <= 3) {
//                    [MTA trackCustomKeyValueEvent:kMTAXG03 props:@{ @"xg03" : @1 }];
//                } else if (sec.integerValue > 3 && sec.integerValue <= 7) {
//                    [MTA trackCustomKeyValueEvent:kMTAXG37 props:@{ @"xg37" : @1 }];
//                } else {
//                    [MTA trackCustomKeyValueEvent:kMTAXG7 props:@{ @"xg7" : @1 }];
//                }
//            }
//        }];
        
        
        if ( omode) {
            dispatch_async(
                           dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                              [MTA trackCustomKeyValueEvent:@"xgpush" props:@{@"xgpush" : @1}];
                           });
            if ([omode intValue] == 11) {
                [self offlineNotify:url];
                return;
            }
            
            UITabBarController *rootController = (UITabBarController *)kKeyWindow.rootViewController;
            if (rootController) {
                DebugLog(@"－－－－－－－－display push msg－－－－－");
               
                [(UINavigationController *)rootController.selectedViewController
                 popToRootViewControllerAnimated:NO];
               
                [MessageViewController
                 MessageAction:[omode intValue]
                 url:url
                 viewcontroller:rootController.selectedViewController];
               
                //清除
                [self clearPushUserinfo];
                return;
            }
        } else {
            //清除
            [self clearPushUserinfo];
            return;
        }
    }
}
/// 下线通知
- (void)offlineNotify:(NSString *)url {
    NSDictionary *dic = [url jsonValueDecoded];
    if (!dic || [dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
//    NSString *mid = dic[@"id"];
    NSNumber *os = dic[@"os"];
    NSNumber *logintime = dic[@"lt"];
    
    NSString *datetime =
    [CommonFunc getTimestring:(NSTimeInterval)[logintime longLongValue]];
    datetime = [datetime substringToIndex:16];
    
    NSString *strTips = [NSString
                         stringWithFormat:@"您的账号于%@在一台%@"
                         @"手机登录。如非本人操作，则密码可能已泄露，建议拨打客"
                         @"服电话：4000903011 修改密码或紧急冻结账号。",
                         datetime, [os intValue] == 1 ? @"iPhone" : @"Android"];
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                        message:strTips
                                                       delegate:self
                                              cancelButtonTitle:@"重新登录"
                                              otherButtonTitles:@"下线", nil];
    alertview.tag = 101;
    [alertview show];
}

@end

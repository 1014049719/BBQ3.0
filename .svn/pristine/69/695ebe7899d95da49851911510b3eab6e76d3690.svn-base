//
//  AppDelegate.m
//  BBQ
//
//  Created by anymuse on 15/7/20.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "AppDelegate.h"
#import "BBQLoginManager.h"
#import "BBQBaseViewController.h"
#import "AppMacro.h"
#import "RootTabBarController.h"
#import "NotificationMacro.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "MessageViewController.h"
#import "XGPush.h"
#import "XGSetting.h"
#import <MTA.h>
#import <MTAConfig.h>
#import <AFNetworkActivityIndicatorManager.h>
#import <Bugly/CrashReporter.h>
#import "BBQLoginManager.h"
#import "BBQNewLoginViewController.h"
#import "LoginViewController.h"
#import "BBQIntroductionViewController.h"
#import "FunctionIntroManager.h"
#import "YTKNetworkConfig.h"
#import "BBQUrlArgumentsFilter.h"
#import "BBQDynamicPageController.h"
#import "BBQAttentionViewController.h"
#import "BBQUnReadManager.h"
#import <IMYThemeConfig.h>
#import <UIColor+IMY_Theme.h>
#import <UINavigationBar+IMY_Theme.h>
#import "BBQThemeManager.h"
#import "BBQPublishManager.h"
#import "BBQDynamicViewModel.h"
#import "BBQDynamicTableViewController.h"
#import <Harpy.h>

@interface AppDelegate ()

@property(strong, nonatomic) RootTabBarController *rootVC;

@end

#define _IPHONE80_ 80000

@implementation AppDelegate

#pragma mark - Life Cycle
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupUserDefaults];
    [self setupAppearance];
    [self setupNetworkMonitor];
    [self setupRequestFilters];
    if ([BBQLoginManager isLogin]) {
        [self setupTabBarController];
    } else {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
#ifdef TARGET_PARENT
        [self setupIntroductionViewController];
#else
        
        [self setupLoginViewControllerInit:YES];
#endif
    }
    [self.window makeKeyAndVisible];
    [self setupVersionCheck];
    [FunctionIntroManager showIntroPage];
    // bugly
    [self performSelector:@selector(setupBugly) withObject:nil afterDelay:3];
    [self completeStartWithOptions:launchOptions];
    return YES;
}

- (void)completeStartWithOptions:(NSDictionary *)launchOptions {
    if ([BBQLoginManager isLogin]) {
        NSDictionary *remoteNotification = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remoteNotification) {
            [BBQBaseViewController handleNotificationInfo:remoteNotification applicationState:UIApplicationStateInactive];
        }
    }
    
    [BBQLoginManager loadCookies];
    //友盟
    [UMSocialData setAppKey:UMSocialKey];
    [UMSocialWechatHandler setWXAppId:WX_APPID
                            appSecret:WX_SECRET
                                  url:nil];
    
    [UMSocialQQHandler setQQWithAppId:QQ_APPID
                               appKey:QQ_APPKEY
                                  url:@"http://www.jyex.cn"];
    //MTA
    [MTA startWithAppkey:MTA_KEY];
    [[MTAConfig getInstance] setReportStrategy:MTA_STRATEGY_INSTANT];
    [[MTAConfig getInstance] setSessionTimeoutSecs:30];
    
    //    信鸽推送
    [XGPush startApp:XINGE_ACCESSID appKey:XINGE_ACCESSKEY];
    [BBQLoginManager setXGAccountWithCurUser];
    //注销之后需要再次注册前的准备
    @weakify(self)
    void (^successCallback)(void) = ^(void){
        //如果变成需要注册状态
        if(![XGPush isUnRegisterStatus] && [BBQLoginManager isLogin]){
            @strongify(self)
            [self registerPush];
        }
    };
    [XGPush initForReregister:successCallback];
    //[XGPush registerPush];  //注册Push服务，注册后才能收到推送
    //推送反馈(app不在前台运行时，点击推送激活时。统计而已)
    [XGPush handleLaunching:launchOptions];
}

- (void)setupBugly {
    NSString *appId;
#ifdef TARGET_PARENT
    appId = @"900011099";
#elif TARGET_TEACHER
    appId = @"900011101";
#elif TARGET_MASTER
    appId = @"900011103";
#endif
    [[CrashReporter sharedInstance] installWithAppId:appId];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[Harpy sharedInstance] checkVersionDaily];
    if ([BBQLoginManager isLogin]) {
        [[BBQUnReadManager sharedManager] handlePushInfo];
    }
    
    if (TheCurUser.member.username && TheCurUser.member.username.length > 0 &&
        [UIApplication sharedApplication].applicationIconBadgeNumber == 1) {
        
        //        [[DataSync instance] getNewMessageNum];
        //        [[DataSync instance] syncRequest:BIZ_SYNC_GetNewMsg :nil :nil
        //        :nil];
    }
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [BBQLoginManager saveCookies];
    [TheCurUser save];
}

// ping++支付回调
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // weixin
    if ([[url scheme] isEqualToString:WX_APPID] &&
        [[url absoluteString] rangeOfString:@"//pay/"].length > 0) {
        NSNumber *result = @PAYRESULT_PAYING;
        if ([[url query] rangeOfString:@"ret=0"].length > 0) {
            result = @PAYRESULT_SUCCESS;
        } else if ([[url query] rangeOfString:@"ret=-2"].length > 0) {
            result = @PAYRESULT_CANCEL;
        } else {
            result = @PAYRESULT_FAIL;
        }
        
        NSDictionary *dic = @{
                              @"result" : result,
                              @"buytype" : [NSNumber numberWithInt:BUY_LEDOU]
                              };
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:NOTIFICATION_Buy_Result
         object:nil
         userInfo:dic];
        
        return YES;
    }
    
    int buytype = 0;
    if ([[url absoluteString] hasPrefix:BUY_QZK_URL])
        buytype = BUY_QZK;
    else if ([[url absoluteString] hasPrefix:BUY_LEDOU_URL])
        buytype = BUY_LEDOU;
    
    if (buytype == BUY_QZK || buytype == BUY_LEDOU) {
        // sucess,fail,cancel,invalid
        
        NSNumber *result = @PAYRESULT_PAYING;
        if ([[url query] rangeOfString:@"success"].length > 0) {
            result = @PAYRESULT_SUCCESS;
        } else if ([[url query] rangeOfString:@"fail"].length > 0) {
            result = @PAYRESULT_FAIL;
        } else if ([[url query] rangeOfString:@"cancel"].length > 0) {
            result = @PAYRESULT_CANCEL;
        } else if ([[url query] rangeOfString:@"invalid"].length > 0) {
            result = @PAYRESULT_FAIL;
        }
        
        NSDictionary *dic = @{
                              @"result" : result,
                              @"buytype" : [NSNumber numberWithInt:buytype]
                              };
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:NOTIFICATION_Buy_Result
         object:nil
         userInfo:dic];
        
        return YES;
    }
    
    //后面这个是什么？
    return [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - 全局appearance设置
- (void)setupAppearance {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    //状态栏设置
    [[UINavigationBar appearance]
     setBarTintColor:[UIColor colorWithHexString:[[BBQThemeManager sharedInstance] getTheCurThemeType]]];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    //    if (TheCurUser.themeType == BBQThemeTypeLego) {
    //        [UITabBar appearance].barTintColor = [UIColor colorWithHexString:@"fed500"];
    //    } else {
    //        [UITabBar appearance].barTintColor = [UIColor whiteColor];
    //    }
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [UINavigationBar appearance].titleTextAttributes = @{
                                                         NSForegroundColorAttributeName : [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont systemFontOfSize:19]
                                                         };
    
    [[UIApplication sharedApplication]
     setStatusBarHidden:NO
     withAnimation:UIStatusBarAnimationFade];
    
    [UITextView appearance].tintColor = [UIColor colorWithHexString:@"ff6440"];
    [UITextField appearance].tintColor = [UIColor colorWithHexString:@"ff6440"];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - XGPush
- (void)registerPush{
    if(!kiOS8Later){
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }else{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
        //        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        //        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
        //                                                                                     categories:[NSSet setWithObject:categorys]];
        //        [[UIApplication sharedApplication] registerUserNotificationSettings:userSettings];
        //        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        //Types
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        //Actions
        UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
        
        acceptAction.identifier = @"ACCEPT_IDENTIFIER";
        acceptAction.title = @"Accept";
        
        acceptAction.activationMode = UIUserNotificationActivationModeForeground;
        acceptAction.destructive = NO;
        acceptAction.authenticationRequired = NO;
        
        //Categories
        UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
        
        inviteCategory.identifier = @"INVITE_CATEGORY";
        
        [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
        
        [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
        
        NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
        
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    }
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

//注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //用户已经允许接收以下类型的推送
    //UIUserNotificationType allowedTypes = [notificationSettings types];
    
}

//按钮点击事件回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]){
        NSLog(@"ACCEPT_IDENTIFIER is clicked");
    }
    completionHandler();
}
#endif

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
        NSLog(@"register success");
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"register error");
    };
    NSString * deviceTokenStr = [XGPush registerDevice:deviceToken successCallback:successBlock errorCallback:errorBlock];
    [BBQLoginManager sharedManager].token = deviceTokenStr;
}

//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app
didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"%@", err.localizedDescription);
}

// APP在前台或后台时，收到远端通知通知
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //推送反馈(app运行时)
    [XGPush handleReceiveNotification:userInfo];
    [BBQBaseViewController handleNotificationInfo:userInfo applicationState:application.applicationState];
    
    NSInteger badge = application.applicationIconBadgeNumber;
    if (badge > 0) {
        //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
        badge = 0;
        //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
        [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    }
    
    // NSString *str = [NSString stringWithFormat:@"收到通知消息:%@",userInfo];
    // MESSAGEBOX(str);
    
    /// 保存userInfo
    [[BBQUnReadManager sharedManager] saveUserinfo:userInfo];
    
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    NSString *alert = @"收到新消息";
    if (aps)
        alert = [aps objectForKey:@"alert"];
    
    NSString *url = [userInfo objectForKey:@"url"];
    NSNumber *omode = [userInfo objectForKey:@"op"];
    
    //下线通知
    if (url && omode) {
        if ([omode intValue] == 11) {
            [self offlineNotify:url];
            return;
        }
    }
    
    if (url && omode) { //发通知消息
        //发通知，更新红点
        NSDictionary *dic = @{ @"num" : [NSNumber numberWithInt:1] };
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kSetUpdateNewMsgNotification
         object:nil
         userInfo:dic];
    }
    
    if ([UIApplication sharedApplication].applicationState ==
        UIApplicationStateActive) {
        //正处于前台，显示收到推送消息
        [SVProgressHUD showImage:nil status:alert];
        return;
    }
}

//下线通知
- (void)offlineNotify:(NSString *)url {
    NSDictionary *dic = [url jsonValueDecoded];
    if (!dic || [dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
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

#pragma mark - Methods Private
- (void)setupUserDefaults {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES
                                                forKey:@"firstShowDynamic"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"needGuid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setupLoginViewControllerInit:(BOOL)init {
    //TODO: 网络请求致命错误时显示Login的逻辑判断
    if ([self.window.rootViewController isKindOfClass:[UITabBarController class]] || init) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
#ifdef TARGET_PARENT
        BBQNewLoginViewController *loginVC =
        [sb instantiateViewControllerWithIdentifier:@"NewLoginVC"];
        [self.window setRootViewController:[[UINavigationController alloc]
                                            initWithRootViewController:loginVC]];
#else
        LoginViewController *loginVC =
        [sb instantiateViewControllerWithIdentifier:@"LoginMain"];
        [self.window setRootViewController:[[UINavigationController alloc]
                                            initWithRootViewController:loginVC]];
#endif
    }
}

- (void)setupIntroductionViewController {
    BBQIntroductionViewController *introductionVC =
    [[BBQIntroductionViewController alloc] init];
    [self.window setRootViewController:introductionVC];
}

- (void)setupTabBarController {
    [[NSUserDefaults standardUserDefaults]
     setBool:YES
     forKey:kLoginStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [BBQLoginManager setXGAccountWithCurUser];
    [BBQLoginManager autoLogin];
    dispatch_async_on_main_queue(^{
        UITabBarController *rootVC = [UITabBarController new];
        if (TheCurUser.themeType == BBQThemeTypeLego) {
            [UITabBar appearance].barTintColor = [UIColor colorWithHexString:@"fed500"];
            [UITabBar appearance].tintColor = [UIColor colorWithHexString:@"ff6440"];
        } else if (TheCurUser.themeType == BBQThemeTypeXiaoP) {
            [UITabBar appearance].barTintColor = [UIColor whiteColor];
            [UITabBar appearance].tintColor = [UIColor colorWithHexString:@"2890c2"];
        } else /*if (TheCurUser.themeType == BBQThemeTypeDefault)*/ {
            [UITabBar appearance].barTintColor = [UIColor whiteColor];
            [UITabBar appearance].tintColor = [UIColor colorWithHexString:@"ff6440"];
        }
#ifdef TARGET_PARENT
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
#elif TARGET_TEACHER
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
#else
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Master" bundle:nil];
#endif
        rootVC = [sb instantiateInitialViewController];
        
        NSMutableArray *vcs = [rootVC.viewControllers mutableCopy];
        UINavigationController *nav;
#ifdef TARGET_PARENT
        BBQDynamicPageController *pageController = [[BBQDynamicPageController alloc] initWithBaby:TheCurBaoBao];
        nav = [[UINavigationController alloc] initWithRootViewController:pageController];
        nav.tabBarItem.title = @"宝宝";
#elif TARGET_TEACHER
        nav = [[UINavigationController alloc] initWithRootViewController:[BBQDynamicPageController pageControllerForTeacher]];
        nav.tabBarItem.title = @"动态";
#else
        BBQDynamicTableViewController *vc = [BBQDynamicTableViewController viewControllerForMasterTab];
        nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.title = @"动态";
#endif
        [vcs replaceObjectAtIndex:0 withObject:nav];
        rootVC.viewControllers = vcs;
        [self.window setRootViewController:rootVC];
    });
}

#pragma mark - Network
- (void)setupNetworkMonitor {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [[AFNetworkReachabilityManager sharedManager]
                        setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus
                                                           status) {
                            switch (status) {
                                case AFNetworkReachabilityStatusNotReachable: {
                                } break;
                                case AFNetworkReachabilityStatusReachableViaWiFi:
                                case AFNetworkReachabilityStatusReachableViaWWAN: {
                                    
                                } break;
                                default:
                                    break;
                            }
                        }];
                   });
}

- (void)setupRequestFilters {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *username = [TheCurUser.member.username isNotBlank] ? TheCurUser.member.username : @"";
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = CS_URL_BASE;
    //    config.baseUrl = @"http://117.141.115.68:883/";
    BBQUrlArgumentsFilter *urlFilter = [BBQUrlArgumentsFilter filterWithArguments:@{@"version": appVersion, @"trcusername": username}];
    [config addUrlFilter:urlFilter];
}

- (void)setupVersionCheck {
    [[Harpy sharedInstance] setAppID:APPLE_ID];
    [[Harpy sharedInstance] setPresentingViewController:self.window.rootViewController];
}

@end

//
//  BBQLoginManager.h
//  BBQ
//
//  Created by 朱琨 on 15/10/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "BBQLoginApi.h"

#define TheCurUser  [BBQLoginManager sharedManager].curUser
#define TheCurBaoBao    TheCurUser.curBaby

extern NSString * const kLoginPreUsername;
extern NSString * const kLoginCurUid;
extern NSString * const kLoginCurUsername;
extern NSString * const kXGToken;
extern NSString * const kNetAlertCount;

typedef void(^CompletionBlock)(YTKBaseRequest *request);

@interface BBQLoginManager : NSObject <YYModel>
//第三方登录
@property (copy, nonatomic) NSString *opuser;
@property (copy, nonatomic) NSString *openid;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *avartarurl;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *access_token;
//绑定手机登录
@property (copy, nonatomic) NSString *yzcode;
//token
@property (copy, nonatomic) NSString *token;

@property (strong, nonatomic) User *curUser;

+ (instancetype)sharedManager;
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password loginType:(BBQLoginType)type success:(CompletionBlock)success failure:(CompletionBlock)failure;
+ (void)autoLogin;
- (void)logout;
+ (void)doLogout;
+ (void)setXGAccountWithCurUser;
+ (BOOL)isLogin;
+ (void)saveCookies;
+ (void)loadCookies;

@end

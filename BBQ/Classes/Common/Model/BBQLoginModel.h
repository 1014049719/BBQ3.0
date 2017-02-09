//
//  BBQLoginModel.h
//  BBQ
//
//  Created by slovelys on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "BBQBabyModel.h"

typedef NS_ENUM(NSUInteger, BBQThirdpartyLoginType) {
    BBQThirdpartyLoginTypeWeChat = 1,
    BBQThirdpartyLoginTypeQQ,
};

@interface BBQLoginModel : NSObject

@property (assign, nonatomic) int authtype;
@property (copy, nonatomic) NSString *openid;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *avartarurl;
@property (copy, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSNumber *isbind;
@property (assign, nonatomic) int qqbind;
@property (assign, nonatomic) int wxbind;
@property (assign, nonatomic) int phone_bind;
@property (strong, nonatomic) NSNumber *schooltype;
@property (copy, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSMutableArray *baobaoData;

- (instancetype)initWithUMSocialAccountEntity:(UMSocialAccountEntity *)snsAccount Authtype:(int)authtype;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

//
//  BBQLoginModel.m
//  BBQ
//
//  Created by slovelys on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQLoginModel.h"

@implementation BBQLoginModel

- (id)initWithUMSocialAccountEntity:(UMSocialAccountEntity *)snsAccount Authtype:(int)authtype {
    if (self = [super init]) {
        _authtype = authtype;
        _openid = snsAccount.openId;
        _nickname = snsAccount.userName;
        _avartarurl = snsAccount.iconURL;
        _access_token = snsAccount.accessToken;
    }
    return self;
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        _baobaoData = [NSMutableArray arrayWithCapacity:0];
        _authtype = [dic[@"authtype"] intValue];
        _isbind = dic[@"isbind"];
        _openid = dic[@"openid"];
        _nickname = dic[@"nickname"];
        _avartarurl = dic[@"avartarurl"];
        _access_token = dic[@"access_token"];
        _wxbind = [dic[@"wxbind"] intValue];
        _qqbind = [dic[@"qqbind"] intValue];
        _phone_bind = [dic[@"phone_bind"] intValue];
        _schooltype = dic[@"schooltype"];
        if (dic[@"baobaodata"] && [dic[@"baobaodata"] isKindOfClass:[NSArray class]]) {
            NSArray *arry = dic[@"baobaodata"];
            for (NSDictionary *dic in arry) {
                BBQBabyModel *model = [[BBQBabyModel alloc] initWithDic:dic];
                [_baobaoData addObject:model];
            }
        }
        
    }
    return self;
}

@end

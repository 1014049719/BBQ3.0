//
//  BBQLoginSingle.h
//  BBQ
//
//  Created by slovelys on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBQLoginModel.h"

@interface BBQLoginSingle : NSObject

@property (strong, nonatomic) BBQLoginModel *loginModel;
@property (strong, nonatomic) BBQLoginModel *snsAccountModel;
@property (strong, nonatomic) NSDictionary *thirdpartyLoginDic;
@property (strong, nonatomic) NSDictionary *autoLoginResponseDic;
@property (strong, nonatomic) NSDictionary *bindingMobileDic;

+ (BBQLoginSingle *)sharedLoginSingle;

#define TheLoginSingle		[BBQLoginSingle sharedLoginSingle]
#define TheLoginModel       TheLoginSingle.loginModel

@end
 
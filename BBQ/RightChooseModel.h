//
//  RightChooseModel.h
//  BBQ
//
//  Created by slovelys on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RightChooseModel : NSObject

/// 宝宝uid
@property (copy, nonatomic) NSString *uid;
/// 宝宝姓名
@property (copy, nonatomic) NSString *userName;
/// 宝宝昵称
@property (copy, nonatomic) NSString *nickName;
/// 宝宝头像
@property (copy, nonatomic) NSString *avartar;
//动态类型(1:宝宝  2:班级  3:学校）
@property (assign, nonatomic ) int dtype;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

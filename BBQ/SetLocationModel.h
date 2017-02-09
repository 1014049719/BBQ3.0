//
//  SetLocationModel.h
//  BBQ
//
//  Created by slovelys on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetLocationModel : NSObject
/// 收货人姓名
@property (copy, nonatomic) NSString *name;
/// 收货人电话
@property (copy, nonatomic) NSString *phone;
/// 邮编
@property (copy, nonatomic) NSString *postNumber;
/// 收货人所在地区
@property (copy, nonatomic) NSString *area;
/// 收货人详细资料
@property (copy, nonatomic) NSString *address;
/// 地址id
@property (copy, nonatomic) NSString *locationID;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

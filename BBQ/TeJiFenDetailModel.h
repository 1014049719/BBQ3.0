//
//  TeJiFenDetailModel.h
//  BBQ
//
//  Created by slovelys on 15/8/18.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeJiFenDetailModel : NSObject

/// 获取积分描述
@property (copy, nonatomic) NSString *desc;
/// 获得积分
@property (copy, nonatomic) NSString *jifen;
/// 获得积分时间
@property (copy, nonatomic) NSString *dateLine;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end

//
//  EverydayReportModel.h
//  BBQ
//
//  Created by slovelys on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EverydayReportModel : NSObject

/// 内容项名称
@property (copy, nonatomic) NSString *itemName;
/// 当天是否已记录（0-未记录，1-已经记录）
@property (copy, nonatomic) NSString *flag;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end

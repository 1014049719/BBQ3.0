//
//  BabyDailyReportModel.h
//  BBQ
//
//  Created by anymuse on 15/8/15.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BabyDailyReportModel : NSObject

@property (copy, nonatomic) NSString *classuid;
@property (copy, nonatomic) NSString *baobaouid;
@property (copy, nonatomic) NSString *datetime;
@property (copy, nonatomic) NSString *zaocan;
@property (copy, nonatomic) NSString *wushui;
@property (copy, nonatomic) NSString *zhongcan;
@property (copy, nonatomic) NSString *heshui;
@property (copy, nonatomic) NSString *qingxu;
@property (copy, nonatomic) NSString *qt;
@property (copy, nonatomic) NSString *jkzk;
@property (copy, nonatomic) NSString *xxzd;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

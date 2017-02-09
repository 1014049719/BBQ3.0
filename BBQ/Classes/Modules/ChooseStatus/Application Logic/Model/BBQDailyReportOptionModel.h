//
//  BBQDailyReportOptionModel.h
//  BBQ
//
//  Created by 朱琨 on 15/10/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBQDailyReportOptionModel : NSObject

@property (copy, nonatomic) NSNumber *cid;
@property (copy, nonatomic) NSString *cval;
@property (copy, nonatomic) NSArray *contentArray;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

//
//  TeGiftModel.h
//  BBQ
//
//  Created by slovelys on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeGiftModel : NSObject

@property (copy, nonatomic) NSString *flag;
/// 礼物名称
@property (copy, nonatomic) NSString *giftName;
/// 礼物ID
@property (copy, nonatomic) NSString *giftID;
/// 积分数量
@property (copy, nonatomic) NSString *jiFen;
/// 图片url
@property (copy, nonatomic) NSString *imgUrl;
/// 礼物数量
@property (copy, nonatomic) NSString *giftNum;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

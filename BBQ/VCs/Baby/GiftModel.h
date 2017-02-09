//
//  GiftModel.h
//  BBQ
//
//  Created by anymuse on 15/7/21.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftModel : NSObject
//
@property (copy, nonatomic) NSString *imgurl;

@property (copy, nonatomic) NSString *imageName;
/// 虚拟物品ID
@property (copy, nonatomic) NSString *giftid;

@property (copy, nonatomic) NSString *dateline;
/// 虚拟物品名称
@property (copy, nonatomic) NSString *giftname;
/// 数量
@property (copy, nonatomic) NSString *giftcount;

@property (copy, nonatomic) NSString *fbztx;

@property (copy, nonatomic) NSString *nickname;
///礼物类型
@property (strong, nonatomic) NSNumber *gifttype;
//2015.8.26 add
///学校名称
@property (copy, nonatomic) NSString *schoolname;
///班级名称
@property (copy, nonatomic) NSString *classname;
///发布者身份
@property (strong, nonatomic) NSNumber *groupkey;
///关系id
@property (strong, nonatomic) NSNumber *gxid;
///关系名称
@property (copy, nonatomic) NSString *gxname;

@property (copy, nonatomic) NSString *baobaoname;

@property (strong, nonatomic) NSNumber *baobaouid;
///使用类型
@property (strong, nonatomic) NSNumber *usetype;


- (instancetype)initWithDic:(NSDictionary *)dic;
-(NSDictionary *)toDictionary;

@end

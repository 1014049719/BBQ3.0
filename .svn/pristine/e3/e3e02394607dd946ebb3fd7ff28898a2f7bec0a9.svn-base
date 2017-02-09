//
//  MessageItemModel.h
//  BBQ
//
//  Created by slovelys on 15/7/25.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageItemModel : NSObject

/// 消息id
@property (copy, nonatomic) NSString *messageid;
/// 消息对应动态的URL, 如果是动态, 则返回动态的GUID
@property (copy, nonatomic) NSString *url;
/// 头像URL
@property (copy, nonatomic) NSString *avatar;
/// 昵称
@property (copy, nonatomic) NSString *nickname;
/// 内容
@property (copy, nonatomic) NSString *content;
/// 时间
@property (copy, nonatomic) NSString *dateLine;
/// 缩略图URL
@property (copy, nonatomic) NSString *imgUrl;
/// 推送消息类别, 1-动态, 2-家园, 其他待定义
@property (copy, nonatomic) NSString *tsType;
/// 推送内容类别, (班级空间, 家园直通车, 成长每一天, 育儿掌中宝, 我的)
@property (copy, nonatomic) NSString *nType;
/// 推送内容类别2 (子栏目)
@property (copy, nonatomic) NSString *nType2;
/// 发布者的uid
@property (strong, nonatomic) NSString *srcuid;
//跳转动作
@property (assign, nonatomic) int omode;


- (id)initWithDic:(NSDictionary *)dic;

@end

//
//  Comment.h
//  BBQ
//
//  Created by 朱琨 on 15/12/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

/// 发布者头像
@property (copy, nonatomic) NSString *fbztx;
/// 评论内容
@property (copy, nonatomic) NSString *content;

@property (copy, nonatomic) NSString *guid;
/// 评论者ID
@property (copy, nonatomic) NSNumber *uid;
/// 评论者昵称
@property (copy ,nonatomic) NSString *nickname;
/// 回复目的人ID
@property (copy, nonatomic) NSNumber *reuid;
/// 回复目的人昵称
@property (copy, nonatomic) NSString *renickname;
/// 时间
@property (copy, nonatomic) NSNumber *dateline;
/// 标志 (0:正常  1:删除)
@property (assign, nonatomic) BOOL flag;
/// 评论唯一ID
@property (copy, nonatomic) NSString *cguid;
/// 是否回复
@property (assign, nonatomic) BOOL isreplay;
///学校名称
@property (copy, nonatomic) NSString *schoolname;
///班级名称
@property (copy, nonatomic) NSString *classname;
///发布者身份
@property (copy, nonatomic) NSNumber *groupkey;
///关系id
@property (copy, nonatomic) NSNumber *gxid;
///关系名称
@property (copy, nonatomic) NSString *gxname;
///回复目的人关系名称
@property (copy,nonatomic ) NSString *regxname;
///宝宝名称
@property (copy,nonatomic ) NSString *baobaoname;

+ (instancetype)commentWithDynamic:(Dynamic *)dynamic comment:(Comment *)comment;

@end

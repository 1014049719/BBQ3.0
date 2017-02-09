//
//  CommentModel.h
//  BBQ
//
//  Created by anymuse on 15/7/21.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
/// 发布者头像
@property (copy, nonatomic) NSString *fbztx;
/// 评论内容
@property (copy, nonatomic) NSString *content;
///// guid
//@property (copy, nonatomic) NSString *guid;
/// 评论者ID
@property (copy, nonatomic) NSString *uid;
/// 评论者昵称
@property (copy ,nonatomic) NSString *nickname;
/// 回复目的人ID
@property (copy, nonatomic) NSString *reuid;
/// 回复目的人昵称
@property (copy, nonatomic) NSString *renickname;
/// 时间
@property (copy, nonatomic) NSString *dateLine;
/// 标志 (0:正常  1:删除)
@property (copy, nonatomic) NSString *flag;
/// 评论唯一ID
@property (copy, nonatomic) NSString *cguid;
/// 是否回复
@property (strong, nonatomic) NSNumber *isreplay;

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
///回复目的人关系名称
@property (copy,nonatomic ) NSString *regxname;
///宝宝名称
@property (copy,nonatomic ) NSString *baobaoname;

- (instancetype)initWithDic:(NSDictionary *)dic;
-(NSDictionary *)toDictionary;

@end

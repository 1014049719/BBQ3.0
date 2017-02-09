//
//  BBQInviteModel.h
//  BBQ
//
//  Created by anymuse on 15/11/27.
//  Copyright © 2015年 bbq. All rights reserved.
//
/**
 "id": 申请记录id,
 "uid":申请人，即家长uid,
 "username":申请人姓名,
 "baobaouid": 宝宝uid,
 "baobaoname": 宝宝姓名,
 "invitationCode": 邀请码,
 "classid": 申请加入班级,
 "operator": 操作人，即审核老师uid,
 "createTime":申请时间,
 "modifyTime": 审核时间,
 "invStatus": 状态 1 通过 0申请（审核中）-1 拒绝
 */
#import <Foundation/Foundation.h>
#import "MJExtension.h"

@class BBQInviteBaobaoData,BBQInviteMemberdata;

@interface BBQInviteModel : NSObject<MJKeyValue>
/** 申请记录id*/
@property (nonatomic, copy) NSString *inviteid;
/** 邀请码*/
@property (nonatomic, copy) NSString *invitationCode;
/** 操作人，即审核老师uid */
@property (nonatomic, copy) NSString *operatorer;
/** 申请时间*/
@property (nonatomic, copy) NSString *createTime;
/** 审核时间*/
@property (nonatomic, copy) NSString *modifyTime;
/** 状态 1 通过 0申请（审核中）-1 拒绝 */
@property (nonatomic, copy) NSString *invStatus;
/** 宝宝信息*/
@property (nonatomic, strong) BBQInviteBaobaoData *baobaodata;
/** 家长信息*/
@property (nonatomic, strong) BBQInviteMemberdata *memberdata;

@end

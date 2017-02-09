//
//  BBQUnReadManager.h
//  BBQ
//
//  Created by 朱琨 on 15/12/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBQUnReadManager : NSObject

@property (copy, nonatomic) NSNumber *messages, *notifications;
/// 是否保存推送消息
@property (assign, nonatomic) BOOL isHasPushUserinfo;
/// 推送消息
@property (strong, nonatomic) NSDictionary *pushUserinfo;

+ (instancetype)sharedManager;
- (void)updateUnRead;

/// 保存推送消息Userinfo
- (void)saveUserinfo:(NSDictionary *)userinfo;
/// 读取推送消息Userinfo
- (NSDictionary *)readUserinfo;
/// 清除推送消息Userinfo
- (void)clearPushUserinfo;
/// 新消息处理
- (void)handlePushInfo;

@end

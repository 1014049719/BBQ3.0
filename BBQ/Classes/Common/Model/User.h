//
//  User.h
//  BBQ
//
//  Created by 朱琨 on 15/12/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBQBabyModel.h"
#import "BBQClassDataModel.h"
#import "BBQSchoolDataModel.h"
#import "DynamicLabel.h"
#import "UserInfo.h"
#import "Dynamic.h"
#import "BBQLoginApi.h"
#import "BBQThemeManager.h"
#import "BBQTaskModel.h"

@interface User : NSObject <YYModel>

@property (assign, nonatomic) NSInteger netAlertCount;
@property (assign, nonatomic) BOOL isbind;
@property (assign, nonatomic) BOOL onlyViaWifi;
@property (assign, nonatomic) BOOL phone_bind;
@property (assign, nonatomic) BOOL qqbind;
@property (assign, nonatomic) BOOL wxbind;
@property (assign, nonatomic) BOOL didFinishAD;
@property (copy, nonatomic) NSArray *usedMedia;
@property (copy, nonatomic) NSArray *baobaodata;
@property (copy, nonatomic) NSArray *classdata;
@property (copy, nonatomic) NSArray *dynamic_label;
@property (copy, nonatomic) NSArray *schooldata;
@property (copy, nonatomic) NSNumber *rlflag;
@property (copy, nonatomic) NSNumber *schooltype;
@property (copy, nonatomic) NSString *qndns;
@property (copy, nonatomic) NSString *qntoken;
@property (copy, nonatomic) NSString *sessid;
@property (copy, nonatomic) NSString *td_ip;
@property (copy, nonatomic) NSString *openid;
@property (copy, nonatomic) NSString *access_token;
@property (assign, nonatomic) BBQLoginType authtype;
@property (assign, nonatomic) BBQThemeType themeType;
@property (strong, nonatomic) UserInfo *member;
/**
 *  通知公告
 */
@property (copy, nonatomic) NSArray *announcementTypes;

@property (strong, nonatomic) id curSelection;

@property (strong, nonatomic) BBQBabyModel *curBaby;
@property (strong, nonatomic) NSArray * taskArr;
@property (strong, nonatomic) BBQClassDataModel *curClass;
@property (strong, nonatomic) BBQSchoolDataModel *curSchool;

- (void)save;
- (BOOL)needCompleteBabyInfo;
- (BOOL)needCompleteUserInfo;
- (BOOL)needResetPassword;
- (BOOL)needJumpToAttentionList ;
- (BOOL)checkAuthorityWithDynamicModel:(Dynamic *)model;
- (BOOL)needWarnWifi;
- (BOOL)needRefreshNewGuideTask:(NSInteger )taskno;
- (void)addABaby:(BBQBabyModel *)baby;
- (void)deleteABaby:(BBQBabyModel *)baby;
- (void)updateBaby:(BBQBabyModel *)baby;
- (void)updataTaskModel:(NSInteger)taskNo;
- (BBQBabyModel *)babyWithUid:(NSNumber *)uid;

@end

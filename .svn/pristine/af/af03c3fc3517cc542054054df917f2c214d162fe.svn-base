//
//  User.m
//  BBQ
//
//  Created by 朱琨 on 15/12/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "User.h"
#import "JJFMDB.h"
#import "BBQTaskModel.h"
#import <AFNetworkReachabilityManager.h>

@implementation User

@synthesize curBaby = _curBaby;
@synthesize curClass = _curClass;
@synthesize curSchool = _curSchool;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _member = [UserInfo new];
    }
    
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"baobaodata": [BBQBabyModel class],
             @"schooldata": [BBQSchoolDataModel class],
             @"classdata": [BBQClassDataModel class],
             @"dynamic_label": [DynamicLabel class],
             @"taskArr":[BBQTaskModel class]
             };
}

+ (NSArray *)modelPropertyBlacklist {
    return @[@"usedMedia",
             @"onlyViaWifi",
             @"netAlertCount",
             @"announcementTypes",
             @"openid",
             @"access_token",
             @"authtype",
             @"themeType"
             ];
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    for (NSString *key in [self.class modelPropertyBlacklist]) {
        if ([dic containsObjectForKey:key]) {
            [self setValue:dic[key] forKey:key];
        }
    }
    return YES;
}

- (void)save {
    self.rowid = 1;
    [self insertUpdateSyncToDB:nil];
}

- (BOOL)needWarnWifi {
    return (!_onlyViaWifi && self.netAlertCount < 2);
}

- (void)addABaby:(BBQBabyModel *)baby {
    NSMutableArray *array = [NSMutableArray arrayWithArray:_baobaodata];
    [array addObject:baby];
    self.baobaodata = array;
    [self save];
}

- (void)deleteABaby:(BBQBabyModel *)baby {
    NSMutableArray *array = [NSMutableArray arrayWithArray:_baobaodata];
    [array enumerateObjectsUsingBlock:^(BBQBabyModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.uid isEqualToNumber:baby.uid]) {
            [array removeObject:obj];
            *stop = YES;
        }
    }];
    self.baobaodata = array;
    [self save];
}

- (void)updateBaby:(BBQBabyModel *)baby {
    NSMutableArray *array = [NSMutableArray arrayWithArray:_baobaodata];
    [array enumerateObjectsUsingBlock:^(BBQBabyModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([baby.uid isEqualToNumber:obj.uid]) {
            [array replaceObjectAtIndex:idx withObject:baby];
            if ([baby.uid isEqualToNumber:_curBaby.uid]) {
                _curBaby = baby;
            }
            *stop = YES;
        }
    }];
    self.baobaodata = array;
    [self save];
}
- (void)updataTaskModel:(NSInteger)taskNo {
    NSMutableArray *array = [NSMutableArray arrayWithArray:_taskArr];
    BBQTaskModel *taskModel = array[taskNo];
    taskModel.state = 1;
    [array replaceObjectAtIndex:taskNo withObject:taskModel];
    BBQTaskModel *totalModel = [array firstObject];
    BOOL totalTaskHasfinished =YES;
    for (BBQTaskModel *model in array) {
        if (model.taskno && !model.state) {
            totalTaskHasfinished = NO;
            break;
        }
    }
    if (totalTaskHasfinished) {
        totalModel.state =1;
        [array replaceObjectAtIndex:0 withObject:totalModel];
    }
    self.taskArr = array;
}
- (BBQBabyModel *)babyWithUid:(NSNumber *)uid {
    __block BBQBabyModel *baby;
    [_baobaodata enumerateObjectsUsingBlock:^(BBQBabyModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.uid isEqualToNumber:uid]) {
            baby = obj;
            *stop = YES;
        }
    }];
    return baby;
}

- (BOOL)needCompleteBabyInfo {
    return ((self.member.groupkey.integerValue == 1) &&
            (self.curBaby.gxid.integerValue < 1 ||
             ![self.curBaby.realname isNotBlank]));
}

- (BOOL)needCompleteUserInfo {
    return (self.curBaby.gxid.integerValue < 1 && self.member.groupkey.integerValue == 1);
}

- (BOOL)needRefreshNewGuideTask:(NSInteger )taskno {
    if (self.taskArr.count > taskno) {
        BBQTaskModel *model = self.taskArr[taskno];
        return !model.state;
    }else{
        return NO;
    }
}

- (BOOL)needJumpToAttentionList {
    return (self.member.groupkey.integerValue == 1 && !self.curBaby);
}

- (BOOL)needResetPassword {
    if (self.member.groupkey.integerValue != 1 ||
        (self.member.groupkey.integerValue == 1 && self.curBaby.qx.integerValue == 1)) {
        NSString *key =
        [@"firstLaunch_" stringByAppendingString:self.member.username];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:key] &&
            [self.member.password isEqualToString:@"123456"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
    }
    return NO;
}

- (BOOL)checkAuthorityWithDynamicModel:(Dynamic *)model {
    if ([model.creuid isEqualToNumber:self.member.uid]) {
        return YES;
    }

    BOOL authority = NO;
    switch (model.dtype.integerValue) {
        case BBQDynamicGroupTypeBaby: {
            if (self.member.groupkey.integerValue == BBQGroupkeyTypeParent &&
                (self.curBaby.qx.integerValue == BBQAuthorityTypeAdmin ||
                 self.curBaby.qx.integerValue == BBQAuthorityTypeManager)) {
                    authority = YES;
                }
        } break;
        case BBQDynamicGroupTypeClass: {
            if (self.member.groupkey.integerValue == BBQGroupkeyTypeTeacher &&
                [model.classuid
                 isEqualToNumber:self.curClass.classid]) {
                    authority = YES;
                }
            if ([self.member.groupkey isEqualToNumber:@3]) {
                if ([model.schoolid isEqualToNumber:self.curSchool.schoolid]) {
                    authority = YES;
                }
            }
        } break;
        case BBQDynamicGroupTypeSchool: {
            if (self.member.groupkey.integerValue == BBQGroupkeyTypeMaster &&
                (model.dtype.integerValue == BBQDynamicGroupTypeClass ||
                 model.dtype.integerValue == BBQDynamicGroupTypeSchool) &&
                ([model.schoolid
                  isEqualToNumber:self.curSchool.schoolid])) {
                authority = YES;
            }
        } break;
        default:
            break;
    }
    return authority;
}

#pragma mark - Getter & Setter
- (NSArray *)baobaodata {
    if (!_baobaodata) {
        _baobaodata = [NSArray array];
    }
    return _baobaodata;
}

- (NSArray *)classdata {
    if (!_classdata) {
        _classdata = [NSArray array];
    }
    return _classdata;
}

- (NSArray *)schooldata {
    if (!_schooldata) {
        _schooldata = [NSArray array];
    }
    return _schooldata;
}

- (BBQBabyModel *)curBaby {
    if (!_curBaby && _baobaodata.count) {
        [self willChangeValueForKey:@"curBaby"];
        _curBaby = _baobaodata.firstObject;
        [self didChangeValueForKey:@"curBaby"];
    }
    return _curBaby;
}

- (BBQClassDataModel *)curClass {
    if (!_curClass && _classdata.count) {
        _curClass = _classdata.firstObject;
    }
    return _curClass;
}

- (BBQSchoolDataModel *)curSchool {
    if (!_curSchool && _schooldata.count) {
        _curSchool = _schooldata.firstObject;
    }
    return _curSchool;
}

@end

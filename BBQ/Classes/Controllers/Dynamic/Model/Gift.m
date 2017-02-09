//
//  Gift.m
//  BBQ
//
//  Created by 朱琨 on 15/12/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "Gift.h"

NSString * const kGiftItems = @"GiftItems";

@implementation Gift

- (instancetype)initWithDynamic:(Dynamic *)dynamic giftID:(NSNumber *)giftID count:(NSNumber *)count items:(NSArray *)items {
    if (self = [super init]) {
        [items enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[obj[@"id"] numberValue] isEqualToNumber:giftID]) {
                _imgurl = obj[@"imgurl"];
                _giftname = obj[@"giftname"];
            }
        }];
        _dateline = @([[NSDate date] timeIntervalSince1970]);
        _fbztx = TheCurUser.member.avartar;
        _guid = dynamic.guid;
        _giftid = giftID;
        _giftcount = count;
        _groupkey = TheCurUser.member.groupkey;
#ifdef TARGET_PARENT
        _baobaoname = TheCurBaoBao.realname;
        _gxid = TheCurBaoBao.gxid;
        _gxname = TheCurBaoBao.gxname;
        _classname = TheCurBaoBao.curClass.classname;
        _schoolname = TheCurBaoBao.curSchool.schoolname;
#elif TARGET_TEACHER
        _classname = TheCurUser.curClass.classname;
        _schoolname = TheCurUser.curSchool.schoolname;
#else
        _schoolname = TheCurUser.curSchool.schoolname;
#endif
    }
    return self;
}

@end

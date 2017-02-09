//
//  MessageItemModel.m
//  BBQ
//
//  Created by slovelys on 15/7/25.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MessageItemModel.h"

@implementation MessageItemModel

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.messageid = pickJsonStrValue(dic, @"id");
        self.url = pickJsonStrValue(dic, @"url");
        self.avatar = pickJsonStrValue(dic, @"avatar");
        self.nickname = pickJsonStrValue(dic, @"nickname");
        self.content = pickJsonStrValue(dic, @"content");
        self.dateLine = pickJsonStrValue(dic, @"dateline");
        
        self.imgUrl = pickJsonStrValue(dic, @"imgurl");
        self.tsType = pickJsonStrValue(dic, @"tstype");
        self.nType = pickJsonStrValue(dic, @"ntype");
        self.nType2 = pickJsonStrValue(dic, @"ntype2");
        
        self.srcuid = pickJsonStrValue(dic, @"srcuid");
        
        self.omode = pickJsonIntValue(dic, @"omode");
    }
    return self;
}

@end

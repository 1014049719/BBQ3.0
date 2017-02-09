//
//  BBQPublishDynamicApi.m
//  BBQ
//
//  Created by 朱琨 on 15/12/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQPublishDynamicApi.h"

@interface BBQPublishDynamicApi ()

@property (strong, nonatomic) Dynamic *dynamic;

@end

@implementation BBQPublishDynamicApi

- (instancetype)initWithDynamic:(Dynamic *)dynamic {
    if (self = [super init]) {
        _dynamic = dynamic;
    }
    return self;
}

+ (instancetype)apiWithDynamic:(Dynamic *)dynamic {
    BBQPublishDynamicApi *api = [[BBQPublishDynamicApi alloc] initWithDynamic:dynamic];
    return api;
}

- (NSString *)requestUrl {
    if (_dynamic.reedit) {
        return URL_DYNAMIC_REEDIT;
    }
    if (_dynamic.mediaType == BBQDynamicMediaTypeBatch) return URL_UPLOAD_DYNA_BAT;
    return URL_UPLOAD_DYNA;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    NSArray *attachinfo = [_dynamic.attachinfo bk_map:^id(Attachment *obj) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"guid"] = obj.guid ?: @"";
        dic[@"itype"] = obj.itype;
        dic[@"filepath"] = obj.filepath;
        dic[@"remote"] = obj.remote;
        dic[@"width"] = obj.width;
        dic[@"height"] = obj.height;
        dic[@"graphtime"] = obj.graphtime;
        if (obj.data) {
            dic[@"data"] = obj.data;
        }
        return dic;
    }];
    
    if (_dynamic.reedit) {
        return @{
                 @"guid": _dynamic.guid ?: @"",
                 @"attachinfo": attachinfo ?: @"",
                 @"graphtime": _dynamic.graphtime ?: @"",
                 @"content": _dynamic.content ?: @"",
                 @"dynatag": _dynamic.dynatag ?: @""
                 };
    }
    return @{
             @"dtype": _dynamic.dtype,
             @"baobaouid": _dynamic.baobaouid ?: @"",
             @"baobaoname": _dynamic.baobaoname ?: @"",
             @"classuid": _dynamic.classuid ?: @"",
             @"classname": _dynamic.classname ?: @"",
             @"schoolid": _dynamic.schoolid ?: @"",
             @"schoolname": _dynamic.schoolname ?: @"",
             @"dynatag": _dynamic.dynatag ?: @"",
             @"content": _dynamic.content ?: @"",
             @"attachinfo": attachinfo ?: @"",
             @"graphtime": _dynamic.graphtime ?: @"",
             @"position": _dynamic.position ?: @"",
             @"localid": _dynamic.localid ?: @"",
             @"groupkey": _dynamic.groupkey,
             @"gxid": _dynamic.gxid ?: @"",
             @"gxname": _dynamic.gxname ?: @""
             };
}

@end

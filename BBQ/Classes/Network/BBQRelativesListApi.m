//
//  BBQRelativesListApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQRelativesListApi.h"

@implementation BBQRelativesListApi

- (NSString *)requestUrl {
    return URL_GET_RELATIVE_LIST;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"baobaouid": TheCurBaoBao.uid
             };
}

@end

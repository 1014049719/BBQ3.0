//
//  BBQLoginSingle.m
//  BBQ
//
//  Created by slovelys on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQLoginSingle.h"

@implementation BBQLoginSingle

+ (BBQLoginSingle *)sharedLoginSingle {
    static BBQLoginSingle *loginSingle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginSingle = [[self alloc] init];
    });
    return loginSingle;
}

@end

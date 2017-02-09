//
//  BBQUploadManager.m
//  BBQ
//
//  Created by 朱琨 on 15/12/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQUploadManager.h"

@implementation BBQUploadManager

+ (instancetype)sharedManager {
    static BBQUploadManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end

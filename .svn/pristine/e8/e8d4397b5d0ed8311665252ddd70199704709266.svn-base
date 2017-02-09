//
//  BBQDynamicDataManager.m
//  BBQ
//
//  Created by 朱琨 on 15/12/1.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicDataManager.h"
#import "Dynamic.h"

@implementation BBQDynamicDataManager

+ (instancetype)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (Dynamic *)dynamicWithGuid:(NSString *)guid {
    return nil;
}

- (void)saveDynamic:(Dynamic *)dynamic {

}

- (void)saveDynamics:(NSArray *)dynamics {

}

- (void)deleteDynamic:(Dynamic *)dynamic {
	
}

- (void)deleteDynamics:(NSArray *)dynamics {
	
}

@end

//
//  BBQDynamicDataManager.h
//  BBQ
//
//  Created by 朱琨 on 15/12/1.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Dynamic;

@interface BBQDynamicDataManager : NSObject

+ (instancetype)sharedManager;

- (Dynamic *)dynamicWithGuid:(NSString *)guid;
- (void)saveDynamic:(Dynamic *)dynamic;
- (void)saveDynamics:(NSArray *)dynamics;
- (void)deleteDynamic:(Dynamic *)dynamic;
- (void)deleteDynamics:(NSArray *)dynamics;

@end

//
//  BBQPublishManager.h
//  BBQ
//
//  Created by 朱琨 on 15/12/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dynamic.h"

@interface BBQPublishManager : NSObject

@property (assign, nonatomic) BOOL working;

+ (instancetype)sharedManager;
- (void)startWorking;
- (void)stopWorking;

- (void)addDynamic:(Dynamic *)dynamic;
- (void)publishDynamic:(Dynamic *)dynamic completion:(void (^)(Dynamic *dynamic, NSError *error))completion;

@end

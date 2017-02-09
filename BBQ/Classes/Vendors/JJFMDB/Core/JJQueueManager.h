//
//  JJQueueManager.h
//  BBQ
//
//  Created by 朱琨 on 15/12/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJDatabaseQueue.h"
#import "JJFMDB.h"

@interface JJQueueManager : NSObject

@property (strong, nonatomic) JJDatabaseQueue *queue;

+ (instancetype)sharedManager;

- (void)resetQueue;

@end

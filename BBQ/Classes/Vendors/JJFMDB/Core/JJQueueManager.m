//
//  JJQueueManager.m
//  BBQ
//
//  Created by 朱琨 on 15/12/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "JJQueueManager.h"

@implementation JJQueueManager

+ (instancetype)sharedManager {
    static JJQueueManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)resetQueue {
    if (_queue) {
        _queue = nil;
    }
    _queue = [JJDatabaseQueue databaseQueueWithPath:[NSObject jj_databasePath]];
}

#pragma mark - Getter & Setter
- (JJDatabaseQueue *)queue {
    if (!_queue) {
        _queue = [JJDatabaseQueue databaseQueueWithPath:[NSObject jj_databasePath]];
    }
    return _queue;
}

@end

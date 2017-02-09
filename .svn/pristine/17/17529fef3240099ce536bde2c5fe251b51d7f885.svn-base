//
//  NSObject+JJFMDBProtocol.m
//  JJFMDBDemo
//
//  Created by Jay on 15/12/6.
//  Copyright © 2015年 JJ. All rights reserved.
//

#import "NSObject+JJFMDBProtocol.h"
#import "JJQueueManager.h"
/** system */
#import <objc/runtime.h>

/** pods */
#import "JJSandBox.h"

/** Core */
#import "NSObject+JJFMDBMethods.h"
#import "JJDatabaseQueue.h"

@implementation NSObject (JJFMDBProtocol)

#pragma mark - JJFMDBProtocol
/** 返回表名(默认) */
+ (const NSString *)jj_tableName {
    return NSStringFromClass([self class]);
}

/** 获取数据库路径(默认) */
+ (NSString *)jj_databasePath {
    return [JJSandBox getPathForDocuments:@"BBQDatabase.db" inDir:[@"Database" stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] stringForKey:kLoginCurUid] ?: @"000000"]];
}

#pragma mark - Property

static char *kDbQueueKey;
+ (void)setDbQueue:(JJDatabaseQueue *)dbQueue {
    objc_setAssociatedObject(self, &kDbQueueKey, dbQueue, OBJC_ASSOCIATION_RETAIN);
    [self startToDB];
}

+ (JJDatabaseQueue *)dbQueue {
    JJDatabaseQueue *queue = objc_getAssociatedObject(self, &kDbQueueKey);
    if (![queue isEqual:[JJQueueManager sharedManager].queue]) {
        queue = [JJQueueManager sharedManager].queue;
        objc_setAssociatedObject(self, &kDbQueueKey, queue, OBJC_ASSOCIATION_RETAIN);
        [self startToDB];
    }
    return queue;
}


@end

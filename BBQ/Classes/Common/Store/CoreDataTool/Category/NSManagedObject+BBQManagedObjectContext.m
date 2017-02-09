//
//  NSManagedObject+BBQManagedObjectContext.m
//  BBQ
//
//  Created by Wenjing on 15/11/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "NSManagedObject+BBQManagedObjectContext.h"
#import "BBQCoreDataManager.h"

NSString *const BBQCoreDataCurrentThreadContext = @"BBQCoreData_CurrentThread_Context";

@implementation NSManagedObject (BBQManagedObjectContext)

+ (NSManagedObjectContext *)defaultPrivateContext {
    return [BBQCoreDataManager shareManager].privateContext;
}

+ (NSManagedObjectContext *)defaultMainContext {
    return [BBQCoreDataManager shareManager].mainContext;
}

+ (NSManagedObjectContext *)currentContext {
    if ([NSThread isMainThread]) {
        return [self defaultMainContext];
    }
    
    NSMutableDictionary *threadDict = [[NSThread currentThread] threadDictionary];
    NSManagedObjectContext *context = threadDict[BBQCoreDataCurrentThreadContext];
    if (context == nil) {
        context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [context setParentContext:[self defaultPrivateContext]];
        [context setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        context.undoManager = nil;
        threadDict[BBQCoreDataCurrentThreadContext] = context;
    }
    return context;
}

@end

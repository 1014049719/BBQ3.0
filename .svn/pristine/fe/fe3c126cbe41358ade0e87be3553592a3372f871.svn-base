//
//  NSManagedObject+BBQRequestOption.m
//  BBQ
//
//  Created by wenjing on 15/11/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "NSManagedObject+BBQRequestOption.h"
#import "NSManagedObject+BBQManagedObjectContext.h"
#import "BBQCoreDataManager.h"
#define _systermVersion_greter_8_0 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
@implementation NSManagedObject (BBQRequestOption)

+(NSString *)BBQ_entityName
{
    return NSStringFromClass(self);
}

+(NSFetchRequest *)BBQ_allRequest
{
    return [self BBQ_requestWithFetchLimit:0
                                batchSize:0];
}

+(NSFetchRequest *)BBQ_anyoneRequest
{
    return [self BBQ_requestWithFetchLimit:1
                                batchSize:1];
}

+(NSFetchRequest *)BBQ_requestWithFetchLimit:(NSUInteger)limit
                                  batchSize:(NSUInteger)batchSize
{
    return [self BBQ_requestWithFetchLimit:limit batchSize:batchSize fetchOffset:0];
}

+(NSFetchRequest *)BBQ_requestWithFetchLimit:(NSUInteger)limit
                                  batchSize:(NSUInteger)batchSize
                                fetchOffset:(NSUInteger)fetchOffset
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self BBQ_entityName]];
    fetchRequest.fetchLimit = limit;
    fetchRequest.fetchBatchSize = batchSize;
    fetchRequest.fetchOffset = fetchOffset;
    return fetchRequest;
}


#pragma mark - update methods
+ (void)BBQ_updateProperty:(NSString *)propertyName toValue:(id)value {
    [self BBQ_updateProperty:propertyName toValue:value where:nil];
}

+ (void)BBQ_updateProperty:(NSString *)propertyName toValue:(id)value where:(NSString *)condition {
    if(_systermVersion_greter_8_0){
        NSManagedObjectContext *manageOBjectContext = [self currentContext];
        
        [manageOBjectContext performBlock:^{
            NSBatchUpdateRequest *batchRequest = [NSBatchUpdateRequest batchUpdateRequestWithEntityName:[self BBQ_entityName]];
            batchRequest.propertiesToUpdate = @{propertyName:value};
            batchRequest.resultType = NSUpdatedObjectIDsResultType;
            batchRequest.affectedStores = [[manageOBjectContext persistentStoreCoordinator] persistentStores];
            if (condition) {
                batchRequest.predicate = [NSPredicate predicateWithFormat:condition];
            }
            
            NSError *requestError;
            NSBatchUpdateResult *result = (NSBatchUpdateResult *)[manageOBjectContext executeRequest:batchRequest error:&requestError];
            
            if ([[result result] respondsToSelector:@selector(count)]){
                if ([[result result] count] > 0){
                    [manageOBjectContext performBlock:^{
                        for (NSManagedObjectID *objectID in [result result]){
                            NSError         *faultError = nil;
                            NSManagedObject *object     = [manageOBjectContext existingObjectWithID:objectID error:&faultError];
                            // Observers of this context will be notified to refresh this object.
                            // If it was deleted, well.... not so much.
                            [manageOBjectContext refreshObject:object mergeChanges:YES];
                        }
                        
                        NSError *error = nil;
                        [manageOBjectContext save:&error];
                        NSLog(@"%s error is %@",__PRETTY_FUNCTION__,error);
                    }];
                } else {
                    // We got back nothing!
                }
            } else {
                // We got back something other than a collection
            }
        }];
    }else{
        
        [self BBQ_updateKeyPath:propertyName toValue:value where:condition];
    }
}
+ (void)BBQ_updateKeyPath:(NSString *)keyPath toValue:(id)value {
    [self BBQ_updateKeyPath:keyPath toValue:value where:nil];
}

+ (void)BBQ_updateKeyPath:(NSString *)keyPath toValue:(id)value where:(NSString *)condition {
    NSManagedObjectContext *manageObjectContext = [self currentContext];
    __block NSError *error = nil;
    [manageObjectContext performBlock:^{
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self BBQ_entityName]];
        if (condition) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:condition];
            fetchRequest.predicate = predicate;
        }
        NSArray *allObjects = [manageObjectContext executeFetchRequest:fetchRequest error:&error];
        if (allObjects != nil) {
            [allObjects enumerateObjectsUsingBlock:^(NSManagedObject *obj, NSUInteger idx, BOOL *stop) {
                [obj setValue:value forKey:keyPath];
            }];
            NSError *saveError = nil;
            [manageObjectContext save:&saveError];
            NSLog(@"%s save error is %@",__PRETTY_FUNCTION__,saveError);
        }else{
            NSLog(@"%s fetch error is %@",__PRETTY_FUNCTION__,error);
        }
    }];
}

#pragma mark - save methods
+ (BOOL)BBQ_saveAndWait:(void (^)(NSManagedObjectContext *))saveAndWait {
    NSAssert(saveAndWait != nil, @"saveAndWait block should not be nil!!!");
    NSManagedObjectContext *context = [self currentContext];
    __block BOOL success = YES;
    __block NSError *error = nil;
    [context performBlockAndWait:^{
        saveAndWait(context);
        success = [context save:&error];
        if (success) {
            [context.parentContext performBlockAndWait:^{
                [context.parentContext save:&error];
            }];
        }
        if (error != nil) {
            NSLog(@"%s error is %@",__PRETTY_FUNCTION__,error);
        }
    }];
    return success;
}

+ (void)BBQ_save:(void (^)(NSManagedObjectContext *))save completion:(void (^)(NSError *))completion {
    NSAssert(save, @"save block should not be nil!!!");
    __block BOOL success = YES;
    __block NSError *error = nil;
    NSManagedObjectContext *context = [self currentContext];
    [context performBlock:^{
        save(context);
        success = [context save:&error];
        if (error == nil) {
            [context.parentContext performBlockAndWait:^{
                [context.parentContext save:&error];
            }];
        }
        if (completion) {
            completion(error);
        }
    }];
}
#pragma mark - delete methods

+ (BOOL)BBQ_deleteAllInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self BBQ_allRequest];
    [request setReturnsObjectsAsFaults:YES];
    [request setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *objsToDelete = [context executeFetchRequest:request error:&error];
    for (id obj in objsToDelete ) {
        [context deleteObject:obj];
    }
    return YES;
}
#pragma mark - fetch methods

+ (id)BBQ_anyone {
    return [self BBQ_anyoneWithPredicate:nil];
}

+   (NSArray *)BBQ_all {
    return [self BBQ_allWithPredicate:nil];
}

+ (void)BBQ_allWithHandler:(void (^)(NSError *, NSArray *))handler {
    NSFetchRequest *request = [self BBQ_allRequest];
    NSManagedObjectContext *context = [self currentContext];
    __block NSError *error = nil;
    if (_systermVersion_greter_8_0) {
        [context performBlock:^{
            NSAsynchronousFetchRequest *asyncRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:request completionBlock:^(NSAsynchronousFetchResult *result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (handler) {
                        handler(error,[result.finalResult copy]);
                    }
                });
            }];
            [context executeRequest:asyncRequest error:&error];
        }];
    }else{
        [context performBlock:^{
            NSArray *results = [context executeFetchRequest:request error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(error,results);
                }
            });
        }];
    }
}

+ (NSArray *)BBQ_whereProperty:(NSString *)property equalTo:(id)value {
    return [self BBQ_whereProperty:property equalTo:value sortedKeyPath:nil ascending:NO];
}

+ (void)BBQ_whereProperty:(NSString *)property equalTo:(id)value handler:(void (^)(NSError *, NSArray *))handler {
    return [self BBQ_whereProperty:property equalTo:value sortedKeyPath:nil ascending:NO handler:handler];
}

+ (id)BBQ_firstWhereProperty:(NSString *)property equalTo:(id)value {
    NSFetchRequest *request = [self BBQ_requestWithFetchLimit:1 batchSize:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%K == %@",property,value]];
    NSManagedObjectContext *context = [self currentContext];
    __block id obj = nil;
    [context performBlockAndWait:^{
        NSArray *objs = [context executeFetchRequest:request error:nil];
        if (objs.count > 0) {
            obj = objs[0];
        }
    }];
    return obj;
}

+ (NSArray *)BBQ_whereProperty:(NSString *)property
                      equalTo:(id)value
                sortedKeyPath:(NSString *)keyPath
                    ascending:(BOOL)ascending {
    return [self BBQ_whereProperty:property
                          equalTo:value
                    sortedKeyPath:keyPath
                        ascending:ascending
                   fetchBatchSize:0
                       fetchLimit:0
                      fetchOffset:0];
}

+   (void)BBQ_whereProperty:(NSString *)property
                   equalTo:(id)value
             sortedKeyPath:(NSString *)keyPath
                 ascending:(BOOL)ascending
                   handler:(void (^)(NSError *, NSArray *))handler {
    return [self BBQ_whereProperty:property
                          equalTo:value
                    sortedKeyPath:keyPath
                        ascending:ascending
                   fetchBatchSize:0
                       fetchLimit:0
                      fetchOffset:0
                          handler:handler];
}


+ (NSArray *)BBQ_allWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [self BBQ_allRequest];
    if (predicate != nil) {
        [request setPredicate:predicate];
    }
    NSManagedObjectContext *context = [self currentContext];
    __block NSArray *objs = nil;
    [context performBlockAndWait:^{
        NSError *error = nil;
        objs = [context executeFetchRequest:request error:&error];
    }];
    return objs;
    
}

+ (id)BBQ_anyoneWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [self BBQ_anyoneRequest];
    if (predicate != nil) {
        [request setPredicate:predicate];
    }
    NSManagedObjectContext *context = [self currentContext];
    __block id obj = nil;
    [context performBlockAndWait:^{
        NSError *error = nil;
        obj = [[context executeFetchRequest:request error:&error] lastObject];
    }];
    return obj;
}

+ (NSArray *)BBQ_whereProperty:(NSString *)property
                      equalTo:(id)value
                sortedKeyPath:(NSString *)keyPath
                    ascending:(BOOL)ascending
               fetchBatchSize:(NSUInteger)batchSize
                   fetchLimit:(NSUInteger)fetchLimit
                  fetchOffset:(NSUInteger)fetchOffset {
    return [self BBQ_sortedKeyPath:keyPath
                        ascending:ascending
                   fetchBatchSize:batchSize
                       fetchLimit:fetchLimit
                      fetchOffset:fetchOffset
                            where:@"%K == %@",property,value];
}

+ (void)BBQ_whereProperty:(NSString *)property
                 equalTo:(id)value
           sortedKeyPath:(NSString *)keyPath
               ascending:(BOOL)ascending
          fetchBatchSize:(NSUInteger)batchSize
              fetchLimit:(NSUInteger)fetchLimit
             fetchOffset:(NSUInteger)fetchOffset
                 handler:(void (^)(NSError *, NSArray *))handler {
    NSFetchRequest *request = [self BBQ_requestWithFetchLimit:fetchLimit batchSize:batchSize fetchOffset:fetchOffset];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%K == %@",property,value]];
    if (keyPath != nil) {
        NSSortDescriptor *sorted = [NSSortDescriptor sortDescriptorWithKey:keyPath ascending:ascending];
        [request setSortDescriptors:@[sorted]];
    }
    NSManagedObjectContext *context = [self currentContext];
    [context performBlock:^{
        NSError *error = nil;
        NSArray *objs = [context executeFetchRequest:request error:&error];
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(error,objs);
            });
        }
    }];
}

+ (NSArray *)BBQ_where:(NSString *)condition, ... {
    NSFetchRequest *request = [self BBQ_allRequest];
    if (condition != nil) {
        va_list arguments;
        va_start(arguments, condition);
        NSPredicate *predicate = [NSPredicate predicateWithFormat:condition arguments:arguments];
        va_end(arguments);
        [request setPredicate:predicate];
    }
    NSManagedObjectContext *context = [self currentContext];
    __block NSArray *objs = nil;
    [context performBlockAndWait:^{
        NSError *error = nil;
        objs = [context executeFetchRequest:request error:&error];
    }];
    return objs;
}

+ (NSArray *)BBQ_sortedKeyPath:(NSString *)keyPath
                    ascending:(BOOL)ascending
                    batchSize:(NSUInteger)batchSize
                        where:(NSString *)condition, ... {
    NSFetchRequest *request = [self BBQ_requestWithFetchLimit:0
                                                   batchSize:batchSize];
    if (condition != nil) {
        va_list arguments;
        va_start(arguments, condition);
        NSPredicate *predicate = [NSPredicate predicateWithFormat:condition arguments:arguments];
        va_end(arguments);
        [request setPredicate:predicate];
    }
    if (keyPath != nil) {
        NSSortDescriptor *sorted = [NSSortDescriptor sortDescriptorWithKey:keyPath ascending:ascending];
        [request setSortDescriptors:@[sorted]];
    }
    NSManagedObjectContext *context = [self currentContext];
    __block NSArray *objs = nil;
    [context performBlockAndWait:^{
        NSError *error = nil;
        objs = [context executeFetchRequest:request error:&error];
    }];
    return objs;
}

+ (NSArray *)BBQ_sortedKeyPath:(NSString *)keyPath
                    ascending:(BOOL)ascending
               fetchBatchSize:(NSUInteger)batchSize
                   fetchLimit:(NSUInteger)fetchLimit
                  fetchOffset:(NSUInteger)fetchOffset
                        where:(NSString *)condition, ... {
    NSFetchRequest *request = [self BBQ_requestWithFetchLimit:fetchLimit
                                                   batchSize:batchSize
                                                 fetchOffset:fetchOffset];
    if (condition != nil) {
        va_list arguments;
        va_start(arguments, condition);
        NSPredicate *predicate = [NSPredicate predicateWithFormat:condition arguments:arguments];
        va_end(arguments);
        [request setPredicate:predicate];
    }
    if (keyPath != nil) {
        NSSortDescriptor *sorted = [NSSortDescriptor sortDescriptorWithKey:keyPath ascending:ascending];
        [request setSortDescriptors:@[sorted]];
    }
    NSManagedObjectContext *context = [self currentContext];
    __block NSArray *objs = nil;
    [context performBlockAndWait:^{
        NSError *error = nil;
        objs = [context executeFetchRequest:request error:&error];
    }];
    return objs;
}

+ (NSUInteger)BBQ_count {
    return [self BBQ_countWhere:nil];
}

+ (NSUInteger)BBQ_countWhere:(NSString *)condition, ... {
    NSManagedObjectContext *manageObjectContext = [self currentContext];
    __block NSInteger count = 0;
    NSFetchRequest *request = [self BBQ_allRequest];
    request.resultType = NSCountResultType;
    [request setIncludesSubentities:NO]; //Omit subentities. Default is YES (i.e. include subentities)
    if (condition) {
        va_list arguments;
        va_start(arguments, condition);
        NSPredicate *predicate = [NSPredicate predicateWithFormat:condition arguments:arguments];
        va_end(arguments);
        [request setPredicate:predicate];
        request.predicate = predicate;
    }
    [manageObjectContext performBlockAndWait:^{
        NSError *err;
        count = [manageObjectContext countForFetchRequest:request error:&err];
    }];
    
    return count;
}
#pragma mark - common create

+ (id)BBQ_new {
    NSManagedObjectContext *manageContext = [self defaultPrivateContext];
    return [NSEntityDescription insertNewObjectForEntityForName:[self BBQ_entityName] inManagedObjectContext:manageContext];
}

+ (id)BBQ_newInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:[self BBQ_entityName] inManagedObjectContext:context];
}
@end

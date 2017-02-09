//
//  BBQCoreDataStore.h
//  NewBBQ
//
//  Created by 朱琨 on 15/10/12.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

typedef void(^BBQDataStoreFetchCompletionBlock)(NSArray *results);

@interface BBQCoreDataStore : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSPersistentStore *persistentStore;

- (void)fetchEntriesWithPredicate:(NSPredicate *)predicate
                  sortDescriptors:(NSArray *)sortDescriptors
                  completionBlock:(BBQDataStoreFetchCompletionBlock)completionBlock;
- (User *)newUser;
- (void)saveContext;

@end

//
//  BBQCoreDataStore.m
//  NewBBQ
//
//  Created by 朱琨 on 15/10/12.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import "BBQCoreDataStore.h"
#import "User.h"

@interface BBQCoreDataStore ()

@end

@implementation BBQCoreDataStore

- (instancetype)init {
  self = [super init];
  if (self) {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BBQCoreData"
                                              withExtension:@"momd"];
    _managedObjectModel =
        [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
        initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory]
        URLByAppendingPathComponent:@"BBQCoreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason =
        @"There was an error creating or loading the application's saved data.";
    NSDictionary *options =
        [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithBool:YES],
                          NSMigratePersistentStoresAutomaticallyOption,
                          [NSNumber numberWithBool:YES],
                          NSInferMappingModelAutomaticallyOption, nil];

    if (![_persistentStoreCoordinator
            addPersistentStoreWithType:NSSQLiteStoreType
                         configuration:nil
                                   URL:storeURL
                               options:options
                                 error:&error]) {
      // Report any error we got.
      NSMutableDictionary *dict = [NSMutableDictionary dictionary];
      dict[NSLocalizedDescriptionKey] =
          @"Failed to initialize the application's saved data";
      dict[NSLocalizedFailureReasonErrorKey] = failureReason;
      dict[NSUnderlyingErrorKey] = error;
      error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN"
                                  code:9999
                              userInfo:dict];
      // Replace this with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate.
      // You should not use this function in a shipping application, although it
      // may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }

    _managedObjectContext = [[NSManagedObjectContext alloc]
        initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext
        setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    _managedObjectContext.undoManager = nil;
  }
  return self;
}

- (void)saveContext {
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] &&
        ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error
      // appropriately.
      // abort() causes the application to generate a crash log and terminate.
      // You should not use this function in a shipping application, although it
      // may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

- (NSURL *)applicationDocumentsDirectory {
  return [[[NSFileManager defaultManager]
      URLsForDirectory:NSDocumentDirectory
             inDomains:NSUserDomainMask] lastObject];
}

- (User *)newUser {
  NSEntityDescription *entityDescription =
      [NSEntityDescription entityForName:@"User"
                  inManagedObjectContext:self.managedObjectContext];
  User *newUser = (User *)
      [[NSManagedObject alloc] initWithEntity:entityDescription
               insertIntoManagedObjectContext:self.managedObjectContext];

  return newUser;
}

- (void)fetchEntriesWithPredicate:(NSPredicate *)predicate
                  sortDescriptors:(NSArray *)sortDescriptors
                  completionBlock:
                      (BBQDataStoreFetchCompletionBlock)completionBlock {
  NSFetchRequest *fetchRequest =
      [NSFetchRequest fetchRequestWithEntityName:@"User"];
  [fetchRequest setPredicate:predicate];
  [fetchRequest setSortDescriptors:sortDescriptors];

  [self.managedObjectContext performBlock:^{
    NSArray *results =
        [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    if (completionBlock) {
      completionBlock(results);
    }
  }];
}
@end

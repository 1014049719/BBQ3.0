//
//  BBQCoreDataManager.h
//  BBQ
//
//  Created by wenjing on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BBQCoreDataManager : NSObject
@property (readonly, nonatomic, strong) NSManagedObjectContext *privateContext;
@property (readonly, nonatomic, strong) NSManagedObjectContext *mainContext;

@property (readonly, nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)shareManager;
-(void)removeAllRecord;

@end

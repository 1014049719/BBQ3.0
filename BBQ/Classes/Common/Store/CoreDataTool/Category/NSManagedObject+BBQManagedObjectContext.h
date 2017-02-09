//
//  NSManagedObject+BBQManagedObjectContext.h
//  BBQ
//
//  Created by Wenjing on 15/11/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (BBQManagedObjectContext)
/**
 *  get the persitanceController default private context
 *
 *  @return the private context
 */
+ (NSManagedObjectContext *)defaultPrivateContext;

/**
 *  get the persistanceContoller default main context
 *
 *  @return the main context
 */
+ (NSManagedObjectContext *)defaultMainContext;
/**
 *  get current thread context
 *
 *  @return current context
 */
+ (NSManagedObjectContext *)currentContext;


@end

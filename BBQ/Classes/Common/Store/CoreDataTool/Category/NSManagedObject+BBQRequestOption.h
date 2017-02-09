//
//  NSManagedObject+BBQRequestOption.h
//  BBQ
//
//  Created by wenjing on 15/11/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (BBQRequestOption)
#pragma Mark Query
/**
 *  获取实体类型名
 *  @return 实体类型名
 */
+(NSString *)BBQ_entityName;
/**
 *  获取实体表中所有数据
 *  @return 实体表中所有数据
 */
+(NSFetchRequest *)BBQ_allRequest;
/**
 *  获取实体表中任意一个数据 可用来判断实体表是否为空
 *  @return 任意一个实体数据
 */
+(NSFetchRequest *)BBQ_anyoneRequest;
/**
 *  获取实体表中数据 limt限制一次做多获取多少个 batchSize用来限制内存中一次加载多少个
 */
+(NSFetchRequest *)BBQ_requestWithFetchLimit:(NSUInteger)limit
                                  batchSize:(NSUInteger)batchSize;
/**
 *  获取实体表中数据 limt限制一次做多获取多少个 batchSize用来限制内存中一次加载多少个 fetchOffset表示从第几条数据开始获取
 */
+(NSFetchRequest *)BBQ_requestWithFetchLimit:(NSUInteger)limit
                                  batchSize:(NSUInteger)batchSize
                                fetchOffset:(NSUInteger)fetchOffset;

/*-----------------------------------------------------------------------*/


+(id)BBQ_anyone;

+(NSArray *)BBQ_all;
/**
 *  异步获取所有数据
 */
+(void)BBQ_allWithHandler:(void(^)(NSError *error, NSArray *objects))handler;
/**
 *  同步方法
 *  获取符合（property）属性值 等于value 条件所有数据
 */
+(NSArray *)BBQ_whereProperty:(NSString *)property
                     equalTo:(id)value;
/**
 *  异步方法
 *  获取符合（property）属性值 等于value 条件所有数据
 */
+(void)BBQ_whereProperty:(NSString *)property
                equalTo:(id)value
                handler:(void(^)(NSError *error, NSArray *objects))handler;
/**
 *  同步方法
 *  获取符合（property）属性值 等于value 条件的第一条数据
 */
+(id)BBQ_firstWhereProperty:(NSString *)property
                   equalTo:(id)value;
/**
 *  同步方法
 *  获取符合（property）属性值 等于value 条件的所有数据 并且按照（keyPath）进行排序 YES升序 NO降序
 */

+(NSArray *)BBQ_whereProperty:(NSString *)property
                     equalTo:(id)value
               sortedKeyPath:(NSString *)keyPath
                   ascending:(BOOL)ascending;
/**
 *  异步方法
 *  获取符合（property）属性值 等于value 条件的所有数据 并且按照（keyPath）进行排序 YES升序 NO降序
 */
+(void)BBQ_whereProperty:(NSString *)property
                equalTo:(id)value
          sortedKeyPath:(NSString *)keyPath
              ascending:(BOOL)ascending
                handler:(void (^)(NSError *, NSArray *))handler;

/**
 *  获取符合条件（predicate）的所有数据
 */
+(NSArray *)BBQ_allWithPredicate:(NSPredicate *)predicate;
/**
 *  获取符合条件（predicate）的任一条数据
 */
+(id)BBQ_anyoneWithPredicate:(NSPredicate *)predicate;

/**
 *  同步方法
 *  获取符合（property）属性值 等于value 条件的所有数据 并且按照（keyPath）进行排序 YES升序 NO降序
 *  fetchLimit限制一次做多获取多少个 fetchBatchSize用来限制内存中一次加载多少个 fetchOffset表示从第几条数据开始获取
 */
+(NSArray *)BBQ_whereProperty:(NSString *)property
                     equalTo:(id)value
               sortedKeyPath:(NSString *)keyPath
                   ascending:(BOOL)ascending
              fetchBatchSize:(NSUInteger)batchSize
                  fetchLimit:(NSUInteger)fetchLimit
                 fetchOffset:(NSUInteger)fetchOffset;
/**
 *  异步方法
 *  获取符合（property）属性值 等于value 条件的所有数据 并且按照（keyPath）进行排序 YES升序 NO降序
 *  fetchLimit限制一次做多获取多少个 fetchBatchSize用来限制内存中一次加载多少个 fetchOffset表示从第几条数据开始获取
 */
+(void)BBQ_whereProperty:(NSString *)property
                equalTo:(id)value
          sortedKeyPath:(NSString *)keyPath
              ascending:(BOOL)ascending
         fetchBatchSize:(NSUInteger)batchSize
             fetchLimit:(NSUInteger)fetchLimit
            fetchOffset:(NSUInteger)fetchOffset
                handler:(void(^)(NSError *error, NSArray *objects))handler;

/**
 *  同步方法
 *  获取符合condition 条件的所有数据 
 */
+(NSArray *)BBQ_where:(NSString *)condition,...;

/**
 *  同步方法
 *  获取符合condition 条件的所有数据 并且按照（keyPath）进行排序 YES升序 NO降序
 */
+(NSArray *)BBQ_sortedKeyPath:(NSString *)keyPath
                   ascending:(BOOL)ascending
                   batchSize:(NSUInteger)batchSize
                       where:(NSString *)condition,...;

/**
 *  同步方法
 *  获取符合condition 条件的所有数据 并且按照（keyPath）进行排序 YES升序 NO降序
 *  fetchLimit限制一次做多获取多少个 fetchBatchSize用来限制内存中一次加载多少个 fetchOffset表示从第几条数据开始获取
 */
+(NSArray *)BBQ_sortedKeyPath:(NSString *)keyPath
                   ascending:(BOOL)ascending
              fetchBatchSize:(NSUInteger)batchSize
                  fetchLimit:(NSUInteger)fetchLimit
                 fetchOffset:(NSUInteger)fetchOffset
                       where:(NSString *)condition,...;

/**
 *  @return the entity's count
 */
+(NSUInteger)BBQ_count;
/**
 *  @return 符合condition 条件的count
 */
+(NSUInteger)BBQ_countWhere:(NSString *)condition,...;

/**
 *  删除context中所有数据
 */

+(BOOL)BBQ_deleteAllInContext:(NSManagedObjectContext *)context;

//save methods

/**
 *  同步保存数据
 */
+ (BOOL)BBQ_saveAndWait:(void(^)(NSManagedObjectContext *currentContext))saveAndWait;
/**
 *  异步保存数据
 */
+ (void)BBQ_save:(void(^)(NSManagedObjectContext *currentContext))save completion:(void(^)(NSError *error))completion;


/*-----------------------------------------------------------------------------------------------------------------------------*/
#pragma mark update methods
/**
 *  更新指定属性名（propertyName）值为value IOS8以上
 */
+(void)BBQ_updateProperty:(NSString *)propertyName toValue:(id)value;
/**
 *  更新指定属性名（propertyName）值为value 且符合特定（where）条件 IOS8以上
 */
+(void)BBQ_updateProperty:(NSString *)propertyName toValue:(id)value where:(NSString *)condition;
/**
 *  更新指定属性名（propertyName）值为value IOS7
 */
+(void)BBQ_updateKeyPath:(NSString *)keyPath toValue:(id)value;
/**
 *  更新指定属性名（propertyName）值为value 且符合特定（where）条件 IOS7
 */
+(void)BBQ_updateKeyPath:(NSString *)keyPath toValue:(id)value where:(NSString *)condition;

/*-----------------------------------------------------------------------------------------------------------------------------*/

/**
 *  creat an entity in default private queue context
 *
 *  @return entity
 */
+ (id)BBQ_new;

/**
 *  creat an new entity in your context
 *
 *  @param context your context
 *
 *  @return entity
 */
+ (id)BBQ_newInContext:(NSManagedObjectContext *)context;

@end

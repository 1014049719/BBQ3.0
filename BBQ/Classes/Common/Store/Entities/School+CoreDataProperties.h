//
//  School+CoreDataProperties.h
//  
//
//  Created by 朱琨 on 15/10/12.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "School.h"

NS_ASSUME_NONNULL_BEGIN

@interface School (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *schoolid;
@property (nullable, nonatomic, retain) NSString *schoolname;
@property (nullable, nonatomic, retain) NSSet<Banji *> *classes;
@property (nullable, nonatomic, retain) User *user;

@end

@interface School (CoreDataGeneratedAccessors)

- (void)addClassesObject:(Banji *)value;
- (void)removeClassesObject:(Banji *)value;
- (void)addClasses:(NSSet<Banji *> *)values;
- (void)removeClasses:(NSSet<Banji *> *)values;

@end

NS_ASSUME_NONNULL_END

//
//  Banji+CoreDataProperties.h
//  
//
//  Created by 朱琨 on 15/10/12.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Banji.h"

NS_ASSUME_NONNULL_BEGIN

@interface Banji (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *classname;
@property (nullable, nonatomic, retain) NSString *classuid;
@property (nullable, nonatomic, retain) NSSet<Baby *> *babies;
@property (nullable, nonatomic, retain) School *school;
@property (nullable, nonatomic, retain) User *user;

@end

@interface Banji (CoreDataGeneratedAccessors)

- (void)addBabiesObject:(Baby *)value;
- (void)removeBabiesObject:(Baby *)value;
- (void)addBabies:(NSSet<Baby *> *)values;
- (void)removeBabies:(NSSet<Baby *> *)values;

@end

NS_ASSUME_NONNULL_END

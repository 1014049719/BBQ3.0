//
//  User+CoreDataProperties.h
//  
//
//  Created by 朱琨 on 15/10/12.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *avatar;
@property (nullable, nonatomic, retain) NSNumber *bbq_fdt_num;
@property (nullable, nonatomic, retain) NSNumber *bbq_jifen_num;
@property (nullable, nonatomic, retain) NSNumber *bbq_ld_num;
@property (nullable, nonatomic, retain) NSNumber *bbq_pic_num;
@property (nullable, nonatomic, retain) NSDate *birthday;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSNumber *gender;
@property (nullable, nonatomic, retain) NSNumber *groupkey;
@property (nullable, nonatomic, retain) NSString *gxid;
@property (nullable, nonatomic, retain) NSString *gxname;
@property (nullable, nonatomic, retain) NSNumber *ismainjiazhang;
@property (nullable, nonatomic, retain) NSNumber *isqzk;
@property (nullable, nonatomic, retain) NSString *mobile;
@property (nullable, nonatomic, retain) NSNumber *myledou;
@property (nullable, nonatomic, retain) NSString *nickname;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSNumber *qx;
@property (nullable, nonatomic, retain) NSNumber *qzb_flag;
@property (nullable, nonatomic, retain) NSString *realname;
@property (nullable, nonatomic, retain) NSString *telephone;
@property (nullable, nonatomic, retain) NSString *uid;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSNumber *visit_count;
@property (nullable, nonatomic, retain) NSString *visit_dateline;
@property (nullable, nonatomic, retain) NSSet<Address *> *addresses;
@property (nullable, nonatomic, retain) NSSet<Baby *> *babies;
@property (nullable, nonatomic, retain) Baby *baby;
@property (nullable, nonatomic, retain) NSSet<Banji *> *classes;
@property (nullable, nonatomic, retain) NSSet<Gift *> *receivedgifts;
@property (nullable, nonatomic, retain) NSSet<School *> *schools;
@property (nullable, nonatomic, retain) NSSet<Dynamic *> *dynamics;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAddressesObject:(Address *)value;
- (void)removeAddressesObject:(Address *)value;
- (void)addAddresses:(NSSet<Address *> *)values;
- (void)removeAddresses:(NSSet<Address *> *)values;

- (void)addBabiesObject:(Baby *)value;
- (void)removeBabiesObject:(Baby *)value;
- (void)addBabies:(NSSet<Baby *> *)values;
- (void)removeBabies:(NSSet<Baby *> *)values;

- (void)addClassesObject:(Banji *)value;
- (void)removeClassesObject:(Banji *)value;
- (void)addClasses:(NSSet<Banji *> *)values;
- (void)removeClasses:(NSSet<Banji *> *)values;

- (void)addReceivedgiftsObject:(Gift *)value;
- (void)removeReceivedgiftsObject:(Gift *)value;
- (void)addReceivedgifts:(NSSet<Gift *> *)values;
- (void)removeReceivedgifts:(NSSet<Gift *> *)values;

- (void)addSchoolsObject:(School *)value;
- (void)removeSchoolsObject:(School *)value;
- (void)addSchools:(NSSet<School *> *)values;
- (void)removeSchools:(NSSet<School *> *)values;

- (void)addDynamicsObject:(Dynamic *)value;
- (void)removeDynamicsObject:(Dynamic *)value;
- (void)addDynamics:(NSSet<Dynamic *> *)values;
- (void)removeDynamics:(NSSet<Dynamic *> *)values;

@end

NS_ASSUME_NONNULL_END

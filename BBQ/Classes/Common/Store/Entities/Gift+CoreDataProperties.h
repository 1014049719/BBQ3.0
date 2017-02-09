//
//  Gift+CoreDataProperties.h
//  
//
//  Created by 朱琨 on 15/10/12.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Gift.h"

NS_ASSUME_NONNULL_BEGIN

@interface Gift (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *giftname;
@property (nullable, nonatomic, retain) NSNumber *gifttype;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *imgurl;
@property (nullable, nonatomic, retain) NSNumber *ldcount;
@property (nullable, nonatomic, retain) NSNumber *usetype;
@property (nullable, nonatomic, retain) User *user;
@property (nullable, nonatomic, retain) Dynamic *dynamic;

@end

NS_ASSUME_NONNULL_END

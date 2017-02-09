//
//  BBQSchoolDataModel.h
//  BBQ
//
//  Created by 朱琨 on 15/12/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBQClassDataModel.h"

typedef NS_ENUM(NSInteger, BBQSchoolType) {
    BBQSchoolTypeKindergarten,
    BBQSchoolTypePrimary,
    BBQSchoolTypeMiddle,
    BBQSchoolTypeTraining
};

@interface BBQSchoolDataModel : NSObject

@property (copy, nonatomic) NSNumber *schoolid;
@property (copy, nonatomic) NSString *schoolname;
@property (copy, nonatomic) NSNumber *schooltype;
@property (copy, nonatomic) NSString *resideprovince;
@property (copy, nonatomic) NSString *residecity;
@property (copy, nonatomic) NSString *residedist;
@property (copy, nonatomic) NSString *schoolavartar;
@property (copy, nonatomic) NSArray *classdata;

- (NSString *)schoolTypeName;

@end

//
//  BBQSchoolDataModel.m
//  BBQ
//
//  Created by 朱琨 on 15/12/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQSchoolDataModel.h"

@implementation BBQSchoolDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"classdata": [BBQClassDataModel class]
             };
}

- (NSString *)schoolTypeName {
    NSString *name;
    switch ((BBQSchoolType)self.schooltype.integerValue) {
        case BBQSchoolTypeKindergarten: {
            name = @"幼儿园";
        } break;
        case BBQSchoolTypePrimary:
        case BBQSchoolTypeMiddle:
        case BBQSchoolTypeTraining: {
            name = @"学校";
        } break;
        default:
            break;
    }
    return name;
}

@end

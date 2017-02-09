//
//  BBQBabyModel.h
//  BBQ
//
//  Created by slovelys on 15/11/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "Person.h"
#import "DynamicTag.h"
#import "BBQSchoolDataModel.h"

@interface BBQBabyModel : Person <YYModel>

@property (assign, nonatomic) BOOL isadmin;
@property (assign, nonatomic) BOOL isqzk;
@property (assign, nonatomic) BOOL manager;
@property (copy, nonatomic) NSArray *baobaoschooldata;
@property (copy, nonatomic) NSArray *dynamictags;
@property (copy, nonatomic) NSArray *shbaobaoschooldata;
@property (copy, nonatomic) NSNumber *gxid;
@property (copy, nonatomic) NSNumber *qx;
@property (copy, nonatomic) NSNumber *qyt_count;
@property (copy, nonatomic) NSString *education;
@property (copy, nonatomic) NSString *graduateschool;
@property (copy, nonatomic) NSString *gxname;
@property (copy, nonatomic) NSString *gxapplyname;
@property (copy, nonatomic) NSString *gxrealname;
@property (copy, nonatomic) NSString *gxusername;
@property (copy, nonatomic) NSString *occupation;
@property (copy, nonatomic) NSString *position;

@property (strong, nonatomic) BBQSchoolDataModel *curSchool;
@property (strong, nonatomic) BBQClassDataModel *curClass;

@end

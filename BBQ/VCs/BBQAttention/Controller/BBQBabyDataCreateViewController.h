//
//  BBQBabyDataCreateViewController.h
//  BBQ
//
//  Created by wenjing on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "MTABaseViewController.h"
typedef NS_ENUM(NSUInteger, BBQBabyDataCreateType) {
    BBQBabyDataCreateTypeNormal,
    BBQBabyDataCreateTypeLogin,
};
@class BBQSchoolDataModel,BBQClassDataModel;

@interface BBQBabyDataCreateViewController : BBQBaseViewController
@property (assign, nonatomic) BBQBabyDataCreateType type;
@property (nonatomic, strong) BBQSchoolDataModel *selectedSchool;
@property (nonatomic, strong) BBQClassDataModel *selectedClass;
@end

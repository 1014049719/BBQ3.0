//
//  BBQBabyModel.m
//  BBQ
//
//  Created by slovelys on 15/11/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBabyModel.h"

@implementation BBQBabyModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dynamictags": [DynamicTag class],
             @"baobaoschooldata": [BBQSchoolDataModel class],
             @"shbaobaoschooldata": [BBQSchoolDataModel class]
             };
}

- (BBQSchoolDataModel *)curSchool {
    if (!_curSchool && _baobaoschooldata.count) {
        _curSchool = _baobaoschooldata.firstObject;
    }
    return _curSchool;
}

- (BBQClassDataModel *)curClass {
    if (!_curClass && self.curSchool.classdata.count) {
        _curClass = _curSchool.classdata.firstObject;
    }
    return _curClass;
}

@end

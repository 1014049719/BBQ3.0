//
//  BBQDynamics.h
//  BBQ
//
//  Created by 朱琨 on 15/10/28.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynaModel.h"
#import "BussDataDef.h"

typedef NS_ENUM(NSUInteger, DynamicType) {
    DynamicTypeSpecifiedBaby,
    DynamicTypeBabyInClass,
    DynamicTypeBabyInSchool,
    DynamicTypeClass,
    DynamicTypeSchool,
    DynamicTypeClassInSchool,
};
@interface BBQDynamics : NSObject

@property (strong, nonatomic) NSNumber *graphtime;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;
@property (assign, nonatomic) DynamicType dynamicType;
@property (strong, nonatomic) NSMutableArray *list;
@property (strong, nonatomic) DynaModel *nextTweet;

+ (instancetype)dynamicsWithType:(DynamicType)dynamicType;
- (void)configWithDynamics:(NSArray *)responseA;

- (NSDictionary *)toParams;

@end

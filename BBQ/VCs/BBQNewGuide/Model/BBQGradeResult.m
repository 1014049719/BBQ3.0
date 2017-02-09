//
//  BBQGradeResult.m
//  BBQ
//
//  Created by anymuse on 15/12/21.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQGradeResult.h"

@implementation BBQGradeResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"goodsarr": [BBQTaskGoods class],
             @"rulearr": [BBQTaskRule class]
             };
}
@end

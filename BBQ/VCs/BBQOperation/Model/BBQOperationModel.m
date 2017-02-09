//
//  BBQOperationModel.m
//  BBQ
//
//  Created by anymuse on 16/1/4.
//  Copyright © 2016年 bbq. All rights reserved.
//

#import "BBQOperationModel.h"

@implementation BBQOperationModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"expand": [BBQOperationExpand class]
             };
}
@end

//
//  JsonManager.h
//  BBQ
//
//  Created by slovelys on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonManager : NSObject

/// 将数组变成字符串
+ (NSString *)arrayToJson:(NSArray *)sourceAry;

/// 将字典变成字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)sourceDict;


/// 代替nil
+ (id)replaceNullValue:(id)val def:(id)defVal;

@end

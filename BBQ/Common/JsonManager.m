//
//  JsonManager.m
//  BBQ
//
//  Created by slovelys on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "JsonManager.h"

@implementation JsonManager

/// 将数组变成字符串
+ (NSString *)arrayToJson:(NSArray *)sourceAry {
  if (0 == [sourceAry count]) {
    return nil;
  }

  NSData *data =
      [NSJSONSerialization dataWithJSONObject:sourceAry
                                      options:NSJSONWritingPrettyPrinted
                                        error:nil];
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/// 将字典变成字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)sourceDict {
  if (0 == [[sourceDict allKeys] count]) {
    return nil;
  }
  NSData *data =
      [NSJSONSerialization dataWithJSONObject:sourceDict options:0 error:nil];
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/// 代替nil
+ (id)replaceNullValue:(id)val def:(id)defVal {
  if (!val || [val isKindOfClass:[NSNull class]]) {
    return defVal;
  } else {
    return val;
  }
}

@end

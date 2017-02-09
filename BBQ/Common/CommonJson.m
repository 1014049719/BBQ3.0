//
//  CommonJson.m
//  BBQ
//
//  Created by mwt on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

///////////////////////////////
///////全局函数////////////
id pickJsonValue(NSDictionary *jObj, NSString *jsKey, id defVal) {
  id val = [jObj objectForKey:jsKey];
  if (!val || [val isKindOfClass:[NSNull class]]) {
    return defVal;
  } else {
    return val;
  }
}

BOOL pickJsonBOOLValue(NSDictionary *jObj, NSString *jsKey, BOOL defVal) {
  return [(NSNumber *)pickJsonValue(
      jObj, jsKey, [NSNumber numberWithBool:defVal]) boolValue];
}

// int pickJsonIntValue(NSDictionary* jObj, NSString* jsKey, int defVal)
//{
//	return [(NSNumber*)pickJsonValue(jObj, jsKey, [NSNumber
//numberWithInt:defVal]) intValue];
//}

int pickJsonIntValue(NSDictionary *jObj, NSString *jsKey) {
  return [(NSNumber *)pickJsonValue(jObj, jsKey, [NSNumber numberWithInt:0])
          intValue];
}

float pickJsonFloatValue(NSDictionary *jObj, NSString *jsKey, float defVal) {
  return [(NSNumber *)pickJsonValue(
      jObj, jsKey, [NSNumber numberWithFloat:defVal]) floatValue];
}

double pickJsonDoubleValue(NSDictionary *jObj, NSString *jsKey, double defVal) {
  return [(NSNumber *)pickJsonValue(
      jObj, jsKey, [NSNumber numberWithDouble:defVal]) doubleValue];
}

// NSString* pickJsonStrValue(NSDictionary* jObj, NSString* jsKey, NSString*
// defVal)
//{
//	return (NSString*)pickJsonValue(jObj, jsKey, defVal);
//}

NSString *pickJsonStrValue(NSDictionary *jObj, NSString *jsKey) {
  return [NSString stringWithFormat:@"%@", pickJsonValue(jObj, jsKey, @"")];
}

id replaceNullValue(id val, id defVal) {
  if (!val || [val isKindOfClass:[NSNull class]]) {
    return defVal;
  } else {
    return val;
  }
}

///////////////////////////////

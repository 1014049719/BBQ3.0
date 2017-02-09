//
//  CommonJson.h
//  BBQ
//
//  Created by mwt on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#ifndef BBQ_CommonJson_h
#define BBQ_CommonJson_h


//不支持NSDictionary和NSArray
id pickJsonValue(NSDictionary* jObj, NSString* jsKey, id defVal);
BOOL pickJsonBOOLValue(NSDictionary* jObj, NSString* jsKey, BOOL defVal);
//int pickJsonIntValue(NSDictionary* jObj, NSString* jsKey, int defVal);
int pickJsonIntValue(NSDictionary* jObj, NSString* jsKey);
float pickJsonFloatValue(NSDictionary* jObj, NSString* jsKey, float defVal);
double pickJsonDoubleValue(NSDictionary* jObj, NSString* jsKey, double defVal);
//NSString* pickJsonStrValue(NSDictionary* jObj, NSString* jsKey, NSString* defVal);
NSString* pickJsonStrValue(NSDictionary* jObj, NSString* jsKey);


id replaceNullValue(id val, id defVal);

#endif

//
//  GiftModel.m
//  BBQ
//
//  Created by mwt on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "VirtualGiftModel.h"

@implementation VirtualGiftModel

- (id)initWithDic:(NSDictionary *)dic {
  self = [super init];

  self.giftid = [NSNumber numberWithInt:[[dic objectForKey:@"id"] intValue]];
  self.giftname =
      [JsonManager replaceNullValue:pickJsonStrValue(dic, @"giftname")
                                def:@""];
  self.imgurl =
      [JsonManager replaceNullValue:pickJsonStrValue(dic, @"imgurl") def:@""];
  self.ldcount =
      [NSNumber numberWithInt:[[dic objectForKey:@"ldcount"] intValue]];

  return self;
}

@end

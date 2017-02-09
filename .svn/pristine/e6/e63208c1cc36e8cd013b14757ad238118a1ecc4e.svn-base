//
//  GiftModel.m
//  BBQ
//
//  Created by anymuse on 15/7/21.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "GiftModel.h"
#import "CommonJson.h"

@implementation GiftModel

- (instancetype)initWithDic:(NSDictionary *)dic {
  if (self = [super init]) {
    self.giftid = pickJsonStrValue(dic, @"giftid");
    self.giftname = pickJsonStrValue(dic, @"giftname");
    self.giftcount = pickJsonStrValue(dic, @"giftcount");
    self.fbztx = dic[@"fbztx"];
    self.imgurl = dic[@"imgurl"];
    self.dateline = dic[@"dateline"];
    self.nickname = dic[@"nickname"];

    self.schoolname = pickJsonStrValue(dic, @"schoolname");
    self.classname = pickJsonStrValue(dic, @"classname");
    self.groupkey =
        [NSNumber numberWithInt:[[dic objectForKey:@"groupkey"] intValue]];
    self.gxid = [NSNumber numberWithInt:[[dic objectForKey:@"gxid"] intValue]];
    self.gxname = pickJsonStrValue(dic, @"gxname");
    self.baobaoname = dic[@"baobaoname"];
    self.baobaouid = dic[@"baobaouid"];
  }
  return self;
}

- (NSDictionary *)toDictionary {
  if (!self.giftid)
    self.giftid = @"";
  if (!self.giftname)
    self.giftname = @"";
  if (!self.giftcount)
    self.giftcount = @"";
  if (!self.fbztx)
    self.fbztx = @"";
  if (!self.imgurl)
    self.imgurl = @"";
  if (!self.dateline)
    self.dateline = @"";
  if (!self.nickname)
    self.nickname = @"";

  if (!self.schoolname)
    self.schoolname = @"";
  if (!self.classname)
    self.classname = @"";
  if (!self.groupkey)
    self.groupkey = @1;
  if (!self.gxid)
    self.gxid = @0;
  if (!self.gxname)
    self.gxname = @"";

  NSDictionary *dic = @{
    @"giftid" : self.giftid,
    @"giftname" : self.giftname,
    @"giftcount" : self.giftcount,
    @"fbztx" : self.fbztx,
    @"imgurl" : self.imgurl,
    @"dateline" : self.dateline,
    @"nickname" : self.nickname,

    @"schoolname" : self.schoolname,
    @"classname" : self.classname,
    @"groupkey" : self.groupkey,
    @"gxid" : self.gxid,
    @"gxname" : self.gxname
  };
  return dic;
}

@end

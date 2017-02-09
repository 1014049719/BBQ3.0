//
//  CommentModel.m
//  BBQ
//
//  Created by anymuse on 15/7/21.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "CommentModel.h"
#import "CommonJson.h"

@implementation CommentModel

- (instancetype)initWithDic:(NSDictionary *)dic {
  if (self = [super init]) {
    self.content = pickJsonStrValue(dic, @"content");
    self.uid = pickJsonStrValue(dic, @"uid");
    self.nickname = pickJsonStrValue(dic, @"nickname");
    self.reuid = pickJsonStrValue(dic, @"reuid");
    self.renickname = pickJsonStrValue(dic, @"renickname");

    self.fbztx = dic[@"fbztx"];
    self.isreplay = dic[@"isreplay"];
    self.dateLine = pickJsonStrValue(dic, @"dateline");
    self.flag = pickJsonStrValue(dic, @"flag");
    self.cguid = pickJsonStrValue(dic, @"cguid");

    self.schoolname = pickJsonStrValue(dic, @"schoolname");
    self.classname = pickJsonStrValue(dic, @"classname");
    self.groupkey =
        [NSNumber numberWithInt:[[dic objectForKey:@"groupkey"] intValue]];
    self.gxid = [NSNumber numberWithInt:[[dic objectForKey:@"gxid"] intValue]];
    self.gxname = pickJsonStrValue(dic, @"gxname");
    self.regxname = pickJsonStrValue(dic, @"regxname");
    self.baobaoname = dic[@"baobaoname"];
  }
  return self;
}

- (NSDictionary *)toDictionary {
  if (!self.content)
    self.content = @"";
  if (!self.uid)
    self.uid = @"";
  if (!self.nickname)
    self.nickname = @"";
  if (!self.reuid)
    self.reuid = @"";
  if (!self.renickname)
    self.renickname = @"";

  if (!self.fbztx)
    self.fbztx = @"";
  if (!self.isreplay)
    self.isreplay = @0;
  //    if ( !self.guid ) self.guid = @"";
  if (!self.dateLine)
    self.dateLine = @"";
  if (!self.flag)
    self.flag = @"";
  if (!self.cguid)
    self.cguid = @"";

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
  if (!self.regxname)
    self.regxname = @"";
  self.baobaoname = self.baobaoname ?: @"";

  NSDictionary *dic = @{
    @"content" : self.content,
    @"uid" : self.uid,
    @"nickname" : self.nickname,
    @"reuid" : self.reuid,
    @"renickname" : self.renickname,

    @"fbztx" : self.fbztx,
    @"isreplay" : self.isreplay,
    //                          @"guid":self.guid,
    @"dateline" : self.dateLine,
    @"flag" : self.flag,
    @"cguid" : self.cguid,

    @"schoolname" : self.schoolname,
    @"classname" : self.classname,
    @"groupkey" : self.groupkey,
    @"gxid" : self.gxid,
    @"gxname" : self.gxname,
    @"regxname" : self.regxname,
    @"baobaoname" : self.baobaoname
  };
  return dic;
}

@end

//
//  TestJSObject.m
//  BBQ
//
//  Created by wth on 15/10/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "TestJSObject.h"
//#import "SBJson.h"
//#import "JSON.h"

@implementation TestJSObject

//以下方法都是只是打了个log 等会看log 以及参数能对上就说明js调用了此处的iOS
//原生方法

//-(void)TestNOParameter
//{
//    NSLog(@".....this is ios TestNOParameter....");
//}
//-(void)TestOneParameter:(NSString *)message
//{
//    NSLog(@"this is ios TestOneParameter=%@",message);
//}
//-(void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString
//*)message2
//{
//    NSLog(@"this is ios TestTowParameter=%@  Second=%@",message1,message2);
//}

- (void)onAppFunc:(NSString *)str {

  NSDictionary *dic = [str jsonValueDecoded];
  NSLog(@"......得到反馈。。。。%@", dic[@"action"]);

    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:@"CZS_Action" object:nil userInfo:dic];

}

@end

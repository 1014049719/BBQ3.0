//
//  TestJSObject.h
//  BBQ
//
//  Created by wth on 15/10/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


//首先创建一个实现了JSExport协议的协议
@protocol TestJSObjectProtocol <JSExport>

//此处我们测试几种参数的情况

//-(void)TestNOParameter;
//-(void)TestOneParameter:(NSString *)message;
//-(void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2;

//项目用
-(void)onAppFunc:(NSString *)str;

@end



@interface TestJSObject : NSObject<TestJSObjectProtocol>

@end


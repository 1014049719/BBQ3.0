//
//  WebViewController.h
//  BBQ
//
//  Created by mwt on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : BBQBaseViewController<UIWebViewDelegate>

@property(nonatomic,copy) NSString *url;
@property(nonatomic,assign) BOOL bFirstInfo;
/// 公告栏目名字
@property (copy, nonatomic) NSString *annceounmentName;


@end

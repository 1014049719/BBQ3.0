//
//  BabyDailyReportViewController.h
//  BBQ
//
//  Created by anymuse on 15/8/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BabyDailyReportViewController : BBQBaseViewController

@property (strong, nonatomic) NSDictionary *dataDic;

@property (assign,nonatomic) BOOL bIsMessage;
@property (copy,nonatomic) NSString *baobaouid;
@property (copy,nonatomic) NSString *strDate;

@end

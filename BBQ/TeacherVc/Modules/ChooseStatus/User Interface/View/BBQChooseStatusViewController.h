//
//  BBQChooseStatusViewController.h
//  DailyReportDemo
//
//  Created by 朱琨 on 15/10/8.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBQChooseStatusViewInterface.h"
#import "BBQChooseStatusModuleInterface.h"

@interface BBQChooseStatusViewController : UIViewController <BBQChooseStatusViewInterface>

@property (strong, nonatomic) id<BBQChooseStatusModuleInterface> eventHandler;

@end

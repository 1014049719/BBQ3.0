//
//  BBQTaskResult.h
//  BBQ
//
//  Created by anymuse on 15/12/21.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBQTaskModel.h"

@interface BBQTaskResult : NSObject
/** 任务个数*/
@property (nonatomic, copy) NSString *tasknum;
/** 任务数组*/
@property (strong, nonatomic) NSArray *taskarr;
@end

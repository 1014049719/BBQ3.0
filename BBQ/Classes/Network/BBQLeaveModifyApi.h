//
//  BBQLeaveModifyApi.h
//  BBQ
//
//  Created by slovelys on 15/12/3.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQLeaveModifyApi : YTKRequest

- (instancetype)initWithBid:(int)bid type:(int)type dotime_s:(NSString *)dotime_s dotime_e:(NSString *)dotime_e content:(NSString *)content;

@end

//
//  BBQCreateLeaveApi.h
//  BBQ
//
//  Created by slovelys on 15/12/2.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQCreateLeaveApi : YTKRequest

/** @brief 新建请假
 *
 * @param  baobaouid     宝宝uid
 * @param  school        学校数据
 * @param  dotime_s      请假开始时间
 * @param  dotime_e      请假结束时间
 * @param  content       请假内容
 *
 */
- (instancetype)initWithDic:(NSDictionary *)dic;

@end

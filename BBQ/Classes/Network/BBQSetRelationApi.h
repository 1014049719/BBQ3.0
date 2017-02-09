//
//  BBQSetRelationApi.h
//  BBQ
//
//  Created by 朱琨 on 15/11/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQSetRelationApi : YTKRequest

- (instancetype)initWithGxID:(NSNumber *)gxid gxname:(NSString *)gxname nickname:(NSString *)nickname baobaouid:(NSNumber *)uid;

@end

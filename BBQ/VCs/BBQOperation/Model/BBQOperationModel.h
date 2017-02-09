//
//  BBQOperationModel.h
//  BBQ
//
//  Created by anymuse on 16/1/4.
//  Copyright © 2016年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBQOperationExpand.h"

@interface BBQOperationModel : NSObject
/** 拓展字段 */
@property (nonatomic, strong) NSArray *expand;
/** 宝宝uid */
@property (nonatomic, assign) NSInteger baobaouid;
/** 序言内容 */
@property (nonatomic, copy) NSString *preface;
@end

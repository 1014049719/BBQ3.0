//
//  BBQPlaceModel.h
//  BBQ
//
//  Created by wenjing on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface BBQPlaceModel : NSObject<MJKeyValue>
/** 节点*/
@property (nonatomic, copy) NSString *nodeid;
/** 名称*/
@property (nonatomic, copy) NSString *name;
/** 级别*/
@property (nonatomic, copy) NSString *level;
/** usetype*/
@property (nonatomic, copy) NSString *usetype;
/** 父节点*/
@property (nonatomic, copy) NSString *upid;
/** :排序号*/
@property (nonatomic, copy) NSString *displayorder;
@end

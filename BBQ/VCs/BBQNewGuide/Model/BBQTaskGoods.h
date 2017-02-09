//
//  BBQTaskGoods.h
//  BBQ
//
//  Created by anymuse on 15/12/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBQTaskGoods : NSObject
/** 物品id */
@property (nonatomic, copy) NSString *goodsid;
/** 物品名称*/
@property (nonatomic, copy) NSString *goodsname;
/** 数量 */
@property (nonatomic, copy) NSString *num;
/** 物品类型*/
@property (nonatomic, copy) NSString *type;
/** 物品图片*/
@property (nonatomic, copy) NSString *imgurl;
@end

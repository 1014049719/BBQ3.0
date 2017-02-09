//
//  GiftModel.h
//  BBQ
//
//  Created by mwt on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VirtualGiftModel : NSObject

@property(strong,nonatomic) NSNumber *giftid;
@property(copy,nonatomic) NSString *giftname;
@property(copy,nonatomic) NSString *imgurl;
@property(strong,nonatomic) NSNumber *ldcount;


- (id)initWithDic:(NSDictionary *)dic;

@end

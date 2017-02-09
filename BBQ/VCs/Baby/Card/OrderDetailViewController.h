//
//  OrderDetailViewController.h
//  BBQ
//
//  Created by mwt on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : BBQBaseViewController

@property(strong,nonatomic)NSString *strName;
@property(strong,nonatomic)NSString *strDesc;
@property(strong,nonatomic)NSString *strOrdrer;
@property(strong,nonatomic)NSString *strOrderTime;
@property(strong,nonatomic)NSString *bookNum;
@property(strong,nonatomic)NSString *strOrderMoney;
@property(strong,nonatomic)NSString *strOrderUser;
@property(strong,nonatomic)NSDictionary *charge;
@property(assign,nonatomic)int buytype; //1:亲子包  2:乐豆

@end

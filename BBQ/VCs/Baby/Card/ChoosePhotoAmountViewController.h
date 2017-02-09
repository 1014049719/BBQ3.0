//
//  ChoosePhotoAmountViewController.h
//  BBQ
//
//  Created by 朱琨 on 15/7/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DidMakeAChoice)(NSInteger);

@interface ChoosePhotoAmountViewController : BBQBaseViewController

@property (strong, nonatomic) DidMakeAChoice block;
@property (assign, nonatomic) NSInteger currentChoice;
@property (strong, nonatomic) NSArray* pricedata; //照片内容数

@end

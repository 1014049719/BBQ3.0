//
//  LeDouPayCell.h
//  BBQ
//
//  Created by mwt on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeDouPayCell : UITableViewCell
//原乐豆
@property (weak, nonatomic) IBOutlet UILabel *lbLedou;
//折扣乐豆
@property (weak, nonatomic) IBOutlet UILabel *LeDou_zhekouLabel;

//选择对勾Imageview
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
//价格
@property (weak, nonatomic) IBOutlet UILabel *OriginalPriceLabel;

@end

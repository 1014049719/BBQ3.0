//
//  GiftCell.h
//  BBQ
//
//  Created by mwt on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbLedounum;

@property (weak, nonatomic) IBOutlet UILabel *lbgiftname;
@property (weak, nonatomic) IBOutlet UIImageView *ivgift;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;
@end

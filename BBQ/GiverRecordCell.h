//
//  GiverRecordCell.h
//  BBQ
//
//  Created by slovelys on 15/8/12.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiverRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *headerBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *giftLabel;

@property (weak, nonatomic) IBOutlet UILabel *datelineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *giftImage;

@end

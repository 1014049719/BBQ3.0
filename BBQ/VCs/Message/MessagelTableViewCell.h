//
//  MessagelTableViewCell.h
//  BBQ
//
//  Created by slovelys on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *dynaPic;
@property (weak, nonatomic) IBOutlet UILabel *dateLineLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeadingCons;
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@property (weak, nonatomic) IBOutlet UIImageView *videoPalyImgView;
@end

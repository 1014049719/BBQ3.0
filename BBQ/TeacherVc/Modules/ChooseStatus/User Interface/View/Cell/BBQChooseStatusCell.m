//
//  BBQChooseStatusCell.m
//  DailyReportDemo
//
//  Created by 朱琨 on 15/10/8.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import "BBQChooseStatusCell.h"

@interface BBQChooseStatusCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxButton;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation BBQChooseStatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end

//
//  BBQDualListSecondaryCell.m
//  BBQ
//
//  Created by slovelys on 15/12/29.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDualListSecondaryCell.h"

NSString * const kDualListSecondaryCellIdentifier = @"DualListSecondaryCellIdentifier";

@interface BBQDualListSecondaryCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectionImageView;

@end

@implementation BBQDualListSecondaryCell

- (void)awakeFromNib {
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = CGRectGetHeight(self.headerImageView.frame) / 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionImageView.highlighted = selected;
}

- (void)setModel:(id)model {
    _model = model;
    if ([model isKindOfClass:[BBQClassDataModel class]]) {
        self.nameLabel.text = ((BBQClassDataModel *)model).classname;
        self.headerImageView.image = [UIImage imageNamed:@"classItem"];
    } else if ([model isKindOfClass:[BBQBabyModel class]]) {
        BBQBabyModel *baby = model;
        self.nameLabel.text = baby.realname;
        [self.headerImageView setImageWithURL:[NSURL URLWithString:baby.avartar] placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    }
}

@end

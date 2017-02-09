//
//  BBQDualListPrimaryCell.m
//  BBQ
//
//  Created by 朱琨 on 15/12/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDualListPrimaryCell.h"

NSString * const kDualListPrimaryCellIdentifier = @"DualListPrimaryCellIdentifier";

@interface BBQDualListPrimaryCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectionImageView;

@end

@implementation BBQDualListPrimaryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionImageView.highlighted = selected;
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : UIColorHex(f5f5f5);
}

- (void)setModel:(id)model {
    _model = model;
    if ([model isKindOfClass:[BBQSchoolDataModel class]]) {
        self.selectionImageView.image = [UIImage imageNamed:@"unselected"];
        self.selectionImageView.highlightedImage = [UIImage imageNamed:@"selected"];
        self.nameLabel.text = ((BBQSchoolDataModel *)model).schoolname;
    } else if ([model isKindOfClass:[BBQClassDataModel class]]) {
        self.selectionImageView.image = [UIImage imageNamed:@"arrow_relationship"];
        self.nameLabel.text = ((BBQClassDataModel *)model).classname;
    }
}

@end

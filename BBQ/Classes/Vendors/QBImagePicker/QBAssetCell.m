//
//  QBAssetCell.m
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/06.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "QBAssetCell.h"

@interface QBAssetCell ()

@end

@implementation QBAssetCell

- (void)awakeFromNib {
    self.checkMarkView.image = [UIImage imageNamed:@"photo_unselected"];
    self.checkMarkView.highlightedImage = [UIImage imageNamed:@"photo_selected"];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.checkMarkView.highlighted = selected;
}

@end

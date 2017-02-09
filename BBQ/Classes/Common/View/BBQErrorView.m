//
//  BBQErrorView.m
//  BBQ
//
//  Created by 朱琨 on 15/12/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQErrorView.h"

@interface BBQErrorView ()

@property (weak, nonatomic) IBOutlet UIButton *reloadButton;

@end

@implementation BBQErrorView

- (void)awakeFromNib {
    self.reloadButton.layer.masksToBounds = YES;
    self.reloadButton.layer.cornerRadius = 5;
    self.reloadButton.layer.borderColor =
    UIColorHex(999999).CGColor;
    self.reloadButton.layer.borderWidth = 1;
}

- (IBAction)reload:(id)sender {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

@end

//
//  LoadingMoreCell.m
//  BBQ
//
//  Created by 朱琨 on 15/9/3.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "LoadingMoreCell.h"
#import "WDActivityIndicator.h"
#import <Masonry.h>

@interface LoadingMoreCell ()
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *lableLeadingCons;
@property(weak, nonatomic) IBOutlet UIView *centerView;
@property(weak, nonatomic) IBOutlet UILabel *statusLabel;
@property(strong, nonatomic) WDActivityIndicator *activityIndicator;

@end

@implementation LoadingMoreCell

- (void)awakeFromNib {
  self.loadingButton.layer.masksToBounds = YES;
  self.loadingButton.layer.cornerRadius = 5;
  self.loadingButton.layer.borderColor =
      [UIColor colorWithHexString:@"333333"].CGColor;
  self.loadingButton.layer.borderWidth = 2;
  self.activityIndicator = [WDActivityIndicator new];
}

- (void)setStatus:(BBQLoadingMoreCellStatus)status {
  _status = status;
  switch (status) {
  case BBQLoadingMoreCellStatusLoading: {
    self.statusLabel.text = @"正在载入";
    self.statusLabel.textColor = [UIColor colorWithHexString:@"999999"];
  } break;

  default:
    break;
  }
}

- (void)showActivityIndicator {
  [self.centerView addSubview:self.activityIndicator];
  self.lableLeadingCons.constant = 25;
  [self.activityIndicator startAnimating];
  //    [self.contentView setNeedsUpdateConstraints];
  //    [self.contentView updateConstraintsIfNeeded];
  [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.centerView);
    make.width.height.equalTo(22);
    make.centerY.equalTo(self.centerView);
  }];
}

- (void)dismissActivityIndicator {
  [self.activityIndicator stopAnimating];
  [self.activityIndicator removeFromSuperview];
  self.lableLeadingCons.constant = 0;
  //    [self.contentView setNeedsUpdateConstraints];
  //    [self.contentView updateConstraintsIfNeeded];
}

@end

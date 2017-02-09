//
//  DailyReportTitleCell.m
//  BBQ
//
//  Created by 朱琨 on 15/8/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "DailyReportTitleCell.h"
#import <Masonry.h>

@interface DailyReportTitleCell ()

@end

@implementation DailyReportTitleCell

- (void)awakeFromNib {
#ifdef TARGET_PARENT
  [self.babyHeadImageView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.contentView);
    make.width.equalTo(0);
  }];

#endif
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end

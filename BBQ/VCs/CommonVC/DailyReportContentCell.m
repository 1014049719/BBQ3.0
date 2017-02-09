//
//  DailyReportContentCell.m
//  BBQ
//
//  Created by 朱琨 on 15/8/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "DailyReportContentCell.h"

@implementation DailyReportContentCell

- (void)awakeFromNib {
  self.bgView.layer.masksToBounds = YES;
  self.bgView.layer.cornerRadius = 5;
}

- (void)setModel:(BabyDailyReportCategoryModel *)model {
  _model = model;

  NSString *imageName = nil;
  NSString *title = nil;
  switch (model.category) {
  case BabyDailyReportCategoryBreakfast: {
    imageName = @"dailyreport_breakfast";
    title = @"早餐";
  } break;
  case BabyDailyReportCategoryLunch: {
    imageName = @"dailyreport_lunch";
    title = @"午餐";
  } break;

  case BabyDailyReportCategoryNoonBreak: {
    imageName = @"dailyreport_noonbreak";
    title = @"午睡";
  } break;

  case BabyDailyReportCategoryDrinking: {
    imageName = @"dailyreport_drinking";
    title = @"喝水";
  } break;

  case BabyDailyReportCategoryEmotion: {
    imageName = @"dailyreport_emotion";
    title = @"情绪";
  } break;

  case BabyDailyReportCategoryHealth: {
    imageName = @"dailyreport_health";
    title = @"健康";
  } break;

  case BabyDailyReportCategoryStudy: {
    imageName = @"dailyreport_study";
    title = @"学习";
  } break;

  case BabyDailyReportCategoryWords: {
    imageName = @"dailyreport_words";
    title = @"老师寄语";
  } break;

  default: { imageName = @"placeholder_panda"; } break;
  }

  self.categoryImageView.image = [UIImage imageNamed:imageName];
  self.categoryTitle.text = title;
  self.categoryContentLabel.text = model.content;
}

@end

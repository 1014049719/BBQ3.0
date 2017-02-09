//
//  BBQDailyReportEditBabyListCell.h
//  BBQ
//
//  Created by 朱琨 on 15/10/20.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBQEditWordsBabyListModel.h"

@interface BBQDailyReportEditBabyListCell : UICollectionViewCell

@property (strong, nonatomic) BBQEditWordsBabyListModel *model;
@property (strong, nonatomic) BBQBabyModel *baby;

@end

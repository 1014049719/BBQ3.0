//
//  GroupCell.h
//  BBQ
//
//  Created by anymuse on 15/7/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeadView;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestTime;
@property (weak, nonatomic) IBOutlet UILabel *vipLabel;

@end

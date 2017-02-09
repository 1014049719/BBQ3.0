//
//  CardUpCell.h
//  BBQ
//
//  Created by anymuse on 15/7/22.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardUpCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userHeadView;
@property (weak, nonatomic) IBOutlet UILabel *momentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *beanCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudCountLabel;



@end

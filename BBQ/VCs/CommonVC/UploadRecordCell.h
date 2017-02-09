//
//  UploadRecordCell.h
//  BBQ
//
//  Created by anymuse on 15/8/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dynamic.h"

@interface UploadRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) Dynamic *model;

@end

//
//  FriendsCell.h
//  BBQ
//
//  Created by mwt on 15/8/3.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ivAvatar;

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIImageView *selectionView;


@end

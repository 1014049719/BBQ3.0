//
//  CommentView.h
//  BBQ
//
//  Created by 朱琨 on 15/8/2.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLLinkLabel.h"

@interface CommentView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *fbztxImageView;
@property (weak, nonatomic) IBOutlet MLLinkLabel *contentLabel;
@property (copy, nonatomic) NSString *cguid;

@end

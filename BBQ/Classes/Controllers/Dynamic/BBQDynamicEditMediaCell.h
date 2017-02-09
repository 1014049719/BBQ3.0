//
//  BBQDynamicEditMediaCell.h
//  BBQ
//
//  Created by 朱琨 on 15/12/4.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Attachment;

extern NSString * const kDynamicEditMediaIdentifier;

@interface BBQDynamicEditMediaCell : UICollectionViewCell

@property (strong, nonatomic) Attachment *attach;
@property (weak, nonatomic) IBOutlet UIButton *deselectButton;
@property (copy, nonatomic) void (^deselectMedia)(Attachment *attach);

+ (CGFloat)cellWidth;

@end

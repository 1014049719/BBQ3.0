//
//  ShareView.h
//  BBQ
//
//  Created by anymuse on 15/7/23.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dynamic.h"

@interface ShareView : UIView

@property (copy, nonatomic) NSString *guid;
@property (strong, nonatomic ) Dynamic *model;

@property (assign, nonatomic) BBQShareType shareType;

@property (copy, nonatomic) NSString *shareURL;

@property (copy, nonatomic) NSString *shareTitle;

@property (copy, nonatomic) NSString *shareContent;

+ (instancetype)sharedInstance;

- (void)showShareView;
- (void)dismiss;

@end

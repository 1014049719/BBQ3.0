//
//  RootPhotoView.h
//  BBQ
//
//  Created by anymuse on 15/7/24.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootPhotoView : UIView

+ (instancetype)sharedInstance;

- (void)showInView:(UIView *)view;

@end

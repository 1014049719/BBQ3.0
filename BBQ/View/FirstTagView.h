//
//  FirstTagView.h
//  BBQ
//
//  Created by 朱琨 on 15/8/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FirstTagViewDelegate <NSObject>

- (void)didClickCancelButton;
- (void)didClickTag:(NSString *)tag;

@end

@interface FirstTagView : UIView

@property (weak, nonatomic) id<FirstTagViewDelegate> delegate;
@property (strong, nonatomic) NSArray *tagsArray;
@property (assign, nonatomic) BOOL isVisible;
@property (assign, nonatomic) BOOL didChooseTag;

- (void)show;
- (void)dismiss;

@end

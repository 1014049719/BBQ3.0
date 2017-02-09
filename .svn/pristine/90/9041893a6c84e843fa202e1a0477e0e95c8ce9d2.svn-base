//
//  BBQDynamicCommentLayout.h
//  BBQ
//
//  Created by 朱琨 on 15/11/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBQDynamicCell.h"
#import "Comment.h"

@class BBQDynamicLayout;

@protocol BBQDynamicCellDelegate;
@interface BBQDynamicCommentLayout : NSObject

@property (weak, nonatomic) id<BBQDynamicCellDelegate> delegate;
@property (strong, nonatomic) Comment *comment;
@property (assign, nonatomic) BBQDynamicStyle style;

@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) YYTextLayout *textLayout;

- (instancetype)initWithComment:(Comment *)comment style:(BBQDynamicStyle)style;
- (void)layout;

@end

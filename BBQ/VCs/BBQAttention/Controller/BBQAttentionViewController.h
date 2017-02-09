//
//  BBQAttentionViewController.h
//  BBQ
//
//  Created by Wenjing on 15/11/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "MTABaseViewController.h"
typedef NS_ENUM(NSUInteger, BBQAttentionViewType) {
    BBQAttentionViewTypeNormal,
    BBQAttentionViewTypeLogin,
};
@interface BBQAttentionViewController : BBQBaseViewController

@property (assign, nonatomic) BBQAttentionViewType type;
@property (copy, nonatomic) void (^didSelectClassBlock)(NSString *classname);

@end

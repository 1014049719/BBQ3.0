//
//  BBQNewGuideViewController.h
//  BBQ
//
//  Created by anymuse on 15/12/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBQTaskModel;
typedef void(^StartGuideBlock)(BOOL isOK);
@interface BBQNewGuideViewController : UIViewController
@property (copy, nonatomic) StartGuideBlock block;
@property (strong, nonatomic) BBQTaskModel *taskModel;
@end

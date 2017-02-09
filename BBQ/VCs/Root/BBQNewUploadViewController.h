//
//  BBQNewUploadViewController.h
//  BBQ
//
//  Created by slovelys on 15/10/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ShowNewGuiderBlock)();

@interface BBQNewUploadViewController : BBQBaseViewController
@property (nonatomic, copy) ShowNewGuiderBlock showNewGuiderBlock;

@end

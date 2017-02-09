//
//  jyexViewController.h
//  BBQ
//
//  Created by mwt on 15/8/9.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>

@interface jyexViewController : BBQBaseViewController<UIWebViewDelegate, iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) NSMutableArray *segmentItems;

@end

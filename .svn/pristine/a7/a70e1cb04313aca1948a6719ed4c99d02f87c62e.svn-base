//
//  BBQSetPlaceViewController.h
//  BBQ
//
//  Created by anymuse on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "MTABaseViewController.h"
@class BBQPlaceParam;
typedef void (^ReturnPlaceParamBlock)(NSString *showText,BBQPlaceParam *placeParam);

@interface BBQSetPlaceViewController : BBQBaseViewController
@property (nonatomic, copy) ReturnPlaceParamBlock returnTextBlock;

- (void)returnText:(ReturnPlaceParamBlock)block;

@end

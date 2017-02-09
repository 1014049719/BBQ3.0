//
//  BBQSetSchoolViewController.h
//  BBQ
//
//  Created by anymuse on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "MTABaseViewController.h"
@class BBQSchoolDataModel,BBQPlaceParam;
typedef void (^ReturnSchoolModelBlock)(BBQSchoolDataModel *model);

@interface BBQSetSchoolViewController : BBQBaseViewController
@property (nonatomic, strong) BBQPlaceParam *placeParam;
@property (nonatomic, copy) ReturnSchoolModelBlock returnTextBlock;

- (void)returnText:(ReturnSchoolModelBlock)block;

@end

//
//  BBQSetClassViewController.h
//  BBQ
//
//  Created by anymuse on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "MTABaseViewController.h"
@class BBQSchoolDataModel,BBQClassDataModel;
typedef void (^ReturnClassModelBlock)(BBQClassDataModel *model);
@interface BBQSetClassViewController : BBQBaseViewController
@property (nonatomic, copy) ReturnClassModelBlock returnTextBlock;
@property (nonatomic, strong) BBQSchoolDataModel *selectedSchool;
- (void)returnText:(ReturnClassModelBlock)block;

@end

//
//  LoadingMoreCell.h
//  BBQ
//
//  Created by 朱琨 on 15/9/3.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BBQLoadingMoreCellStatus) {
    BBQLoadingMoreCellStatusLoading,
    BBQLoadingMoreCellStatusNoMore,
    BBQLoadingMoreCellStatusTapToLoad,
};

@interface LoadingMoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *loadingButton;
@property (assign, nonatomic) BBQLoadingMoreCellStatus status;

@end

//
//  BBQDailyReportEditCell.h
//  BBQ
//
//  Created by 朱琨 on 15/10/20.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBQEditWordsModel.h"

typedef void(^BBQDidTapChooseWordsViewBlock)(NSArray *wordsList, NSIndexPath *indexPath);
typedef void(^BBQWordTextViewDidChangeBlock)(NSString *word, NSIndexPath *indexPath);

@interface BBQDailyReportEditCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UITextView *wordTextView;
@property (copy, nonatomic) BBQDidTapChooseWordsViewBlock block;
@property (copy, nonatomic) BBQWordTextViewDidChangeBlock textViewBlock;
@property (strong, nonatomic) BBQEditWordsModel *model;

@end

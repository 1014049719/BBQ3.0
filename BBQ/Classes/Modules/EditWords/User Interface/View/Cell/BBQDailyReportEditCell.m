//
//  BBQDailyReportEditCell.m
//  BBQ
//
//  Created by 朱琨 on 15/10/20.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDailyReportEditCell.h"
#import "BBQDailyReportEditBabyListCell.h"
#import <Masonry.h>

@interface BBQDailyReportEditCell () <
    UICollectionViewDataSource, UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout, UITextViewDelegate>
@property(weak, nonatomic) IBOutlet UILabel *statusLabel;
@property(weak, nonatomic) IBOutlet UILabel *statusCountLabel;
@property(weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(weak, nonatomic) IBOutlet UIView *chooseWordView;

@end

@implementation BBQDailyReportEditCell

- (void)awakeFromNib {
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  self.wordTextView.layer.masksToBounds = YES;
  self.wordTextView.layer.cornerRadius = 5;
  self.wordTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
  self.wordTextView.layer.borderWidth = 1;
  self.wordTextView.delegate = self;

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(didTapChooseWordsView)];
  [self.chooseWordView addGestureRecognizer:tap];
}

- (void)setModel:(BBQEditWordsModel *)model {
  _model = model;
  CGFloat itemPerRow = floor((kScreenWidth - 30) / 50);
  CGFloat row = ceil(_model.babyList.count / itemPerRow);
  [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.height.equalTo(70 * row);
  }];
  self.statusLabel.text = _model.status;
  self.wordTextView.text = _model.selectedWord;
  self.statusCountLabel.text =
      [NSString stringWithFormat:@"(%@/%@)", @(_model.babyList.count),
                                 @(_model.totalCount)];
  [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _model.babyList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  BBQDailyReportEditBabyListCell *cell = [collectionView
      dequeueReusableCellWithReuseIdentifier:@"DailyReportEditBabyListCell"
                                forIndexPath:indexPath];
  cell.baby = _model.babyList[indexPath.row];
  return cell;
}

- (void)didTapChooseWordsView {
  if (self.block) {
    self.block(self.model.wordList, self.indexPath);
  }
}

- (void)textViewDidChange:(UITextView *)textView {
  self.model.selectedWord = textView.text;
  if (self.textViewBlock) {
    self.textViewBlock(textView.text, self.indexPath);
  }
}

@end

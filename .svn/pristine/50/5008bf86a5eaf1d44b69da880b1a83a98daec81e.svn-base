//
//  BBQDailyReportEditViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/10/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDailyReportEditViewController.h"
#import "BBQDailyReportEditCell.h"
#import "BBQDailyReportWordCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "BBQChooseWordViewController.h"
#import <CNPPopupController.h>
#import <DateTools.h>

@interface BBQDailyReportEditViewController () <
    UITableViewDataSource, UITableViewDelegate, CNPPopupControllerDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSIndexPath *curIndexPath;
@property(strong, nonatomic) CNPPopupController *popupController;
@property(strong, nonatomic) BBQEditWordsModel *curEditModel;
@property(strong, nonatomic) IBOutlet UITableView *wordsTableView;
@property(weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation BBQDailyReportEditViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.submitButton.layer.masksToBounds = YES;
  self.submitButton.layer.cornerRadius =
      CGRectGetHeight(self.submitButton.frame) / 2.0;
  self.wordsTableView.frame =
      CGRectMake(0, 0, kScreenWidth - 30, kScreenHeight * 0.6);
  self.wordsTableView.tableFooterView = [UIView new];
  self.tableView.tableFooterView = [UIView new];

  self.popupController =
      [[CNPPopupController alloc] initWithContents:@[ self.wordsTableView ]];
  self.popupController.delegate = self;
  self.popupController.theme = [CNPPopupTheme defaultTheme];
  self.popupController.theme.presentationStyle =
      CNPPopupPresentationStyleFadeIn;
  self.popupController.theme.maxPopupWidth = kScreenWidth - 30;
  self.popupController.theme.popupContentInsets = UIEdgeInsetsZero;
}
#pragma mark - Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (tableView == self.wordsTableView) {
    return self.curEditModel.wordList.count;
  }
  return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView == self.wordsTableView) {
    BBQDailyReportWordCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"WordCell"
                                        forIndexPath:indexPath];
    cell.wordLabel.text = self.curEditModel.wordList[indexPath.row];
    if (indexPath.row == self.curEditModel.curSelect) {
      [tableView selectRowAtIndexPath:indexPath
                             animated:NO
                       scrollPosition:UITableViewScrollPositionTop];
      cell.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
      cell.wordLabel.textColor = [UIColor whiteColor];
    } else {
      [tableView deselectRowAtIndexPath:indexPath animated:NO];
      cell.wordLabel.textColor = [UIColor colorWithHexString:@"333333"];
      cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
  }
  BBQDailyReportEditCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"DailyReportEditCell"
                                      forIndexPath:indexPath];
  cell.model = self.dataSource[indexPath.row];
  cell.indexPath = indexPath;
  cell.block = ^(NSArray *words, NSIndexPath *indexPath) {
    self.curEditModel = self.dataSource[indexPath.row];
    self.curIndexPath = indexPath;
    [self presentWordList:words];
  };
  //    cell.textViewBlock = ^(NSString *word, NSIndexPath *indexPath) {
  //
  //    };
  return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView == self.wordsTableView) {
    return [tableView
        fd_heightForCellWithIdentifier:@"WordCell"
                      cacheByIndexPath:indexPath
                         configuration:^(BBQDailyReportWordCell *cell) {
                           cell.wordLabel.text =
                               self.curEditModel.wordList[indexPath.row];
                         }];
  }
  return [tableView
      fd_heightForCellWithIdentifier:@"DailyReportEditCell"
                    cacheByIndexPath:indexPath
                       configuration:^(BBQDailyReportEditCell *cell) {
                         cell.model = self.dataSource[indexPath.row];
                       }];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView == self.wordsTableView) {
    if (self.curEditModel.curSelect != indexPath.row) {
      BBQDailyReportWordCell *cell =
          [tableView cellForRowAtIndexPath:indexPath];
      cell.wordLabel.textColor = [UIColor whiteColor];
      cell.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
      self.curEditModel.curSelect = indexPath.row;
      self.curEditModel.selectedWord = cell.wordLabel.text;
      [self.tableView reloadRowsAtIndexPaths:@[ self.curIndexPath ]
                            withRowAnimation:UITableViewRowAnimationNone];
    } else {
      dispatch_after(
          dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
          dispatch_get_main_queue(), ^{
            [self.popupController dismissPopupControllerAnimated:YES];
          });
    }
  }
}

- (void)tableView:(UITableView *)tableView
    didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView == self.wordsTableView) {
    tableView.userInteractionEnabled = NO;
    BBQDailyReportWordCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.wordLabel.textColor = [UIColor colorWithHexString:@"333333"];
    cell.backgroundColor = [UIColor whiteColor];
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
        dispatch_get_main_queue(), ^{
          [self.popupController dismissPopupControllerAnimated:YES];
        });
  }
}

#pragma mark - Scroll View Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (scrollView == self.tableView) {
    [self.view endEditing:YES];
  }
}

#pragma mark - Event
- (void)presentWordList:(NSArray *)words {
  self.wordsTableView.userInteractionEnabled = YES;
  [self.view endEditing:YES];
  [self.wordsTableView reloadData];
  [self.popupController presentPopupControllerAnimated:YES];
}

- (IBAction)didTapSubmitButton:(id)sender {
  [SVProgressHUD showWithStatus:@"正在提交，请稍候..."];
  NSMutableArray *userData = [NSMutableArray array];
  for (BBQEditWordsModel *model in self.dataSource) {
    for (BBQBabyModel *baby in model.babyList) {
      [userData addObject:@{
        @"baobaoid" : baby.uid,
        @"baobaoname" : baby.realname,
        @"cid" : model.cid,
        @"cval" : model.cval,
        @"dynamic" : model.selectedWord
      }];
    }
  }

  NSDictionary *param = @{
    @"schoolid" : TheCurUser.curSchool.schoolid,
    @"schoolname" : TheCurUser.curSchool.schoolname,
    @"classuid" : TheCurUser.curClass.classid,
    @"classname" : TheCurUser.curClass.classname,
    @"typeid" : self.typeID,
    @"typename" : self.title,
    @"typeval" : self.typeval,
    @"userData" : userData,
    @"date" : [self.date formattedDateWithFormat:@"yyyyMMdd"]
  };

  [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeAddDailyReport
      param:param
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        NSString *str = @"提交成功！";
        [SVProgressHUD showSuccessWithStatus:str];
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW,
                          (int64_t)(HUD_DURATION(str) * NSEC_PER_SEC)),
            dispatch_get_main_queue(), ^{
              [self.navigationController popToRootViewControllerAnimated:YES];
            });
      }
      errorHandler:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", responseObject);
      }
      failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", error.localizedDescription);
      }];
}
#pragma mark - Popup Delegate

@end

//
//  BBQChooseStatusViewController.m
//  DailyReportDemo
//
//  Created by 朱琨 on 15/10/8.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import "BBQChooseStatusViewController.h"
#import "BBQChooseStatusCell.h"
#import "NSArray+HOM.h"
#import "BBQDailyReportOptionModel.h"
#import "BBQDailyReportOption.h"
#import <DateTools.h>
#import "BBQChooseDatePresentationTransition.h"
#import "BBQChooseDateDismissalTransition.h"
#import "BBQChooseDateViewController.h"
#import "BBQDailyReportEditViewController.h"
#import "BBQEditWordsModel.h"
#import <NSMutableArray+BlocksKit.h>
#import <CNPPopupController.h>
#import "BBQCalendar.h"
#import <Masonry.h>
#import <BlocksKit.h>

@interface BBQChooseStatusViewController () <
    UITableViewDelegate, UITableViewDataSource, CNPPopupControllerDelegate,
    FSCalendarDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(copy, nonatomic) NSArray *dataSource;
@property(assign, nonatomic, getter=isSeletedAll) BOOL seletedAll;
@property(weak, nonatomic) IBOutlet UIImageView *selectAllView;
@property(weak, nonatomic) IBOutlet UIButton *nextButton;
@property(copy, nonatomic) NSArray *options;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(strong, nonatomic) NSDate *selectedDate;
@property(copy, nonatomic) NSString *typeval;
@property(strong, nonatomic) CNPPopupController *popupController;
@property(strong, nonatomic) BBQCalendar *calendar;

@end

@implementation BBQChooseStatusViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  NSDate *date = [NSDate date];
  self.selectedDate = date;
  self.nextButton.layer.masksToBounds = YES;
  self.nextButton.layer.cornerRadius =
      CGRectGetHeight(self.nextButton.frame) / 2.0;
  self.tableView.tableFooterView = [UIView new];
  BBQDailyReportOption *option = [BBQDailyReportOption new];
  self.options = [option optionsForType:self.flag];
  NSString *title = @"";
  switch (self.flag) {
  case 0: {
    title = @"早餐";
    self.typeval = @"zaocan";
  } break;
  case 1: {
    title = @"午餐";
    self.typeval = @"zhongcan";
  } break;
  case 2: {
    title = @"午睡";
    self.typeval = @"wushui";
  } break;
  case 3: {
    title = @"喝水";
    self.typeval = @"heshui";
  } break;
  case 4: {
    title = @"学习";
    self.typeval = @"xxzd";
  } break;
  case 5: {
    title = @"情绪";
    self.typeval = @"qingxu";
  } break;
  case 6: {
    title = @"健康";
    self.typeval = @"jkzk";
  } break;
  case 7: {
    title = @"寄语";
    self.typeval = @"qt";
  } break;
  default:
    break;
  }

  self.title = title;
  self.dataSource = [TheCurUser.baobaodata
      arrayFromObjectsCollectedWithBlock:^id(BBQBabyModel *baby) {
        BBQBabyStatusModel *model = [BBQBabyStatusModel new];
        model.baby = baby;
        model.options = self.options;
        return model;
      }];
  _seletedAll = YES;
  self.selectAllView.highlighted = YES;

  [self setupCalendar];
  [self setupPopupController];
}

- (void)setupCalendar {
  self.calendar = [[BBQCalendar alloc] initWithType:BBQCalendarTypeChooseDate];
  self.calendar.delegate = self;
  self.calendar.frame =
      CGRectMake(0, 0, kScreen_Width - 30, kScreen_Height * 0.6);
}

- (void)setupPopupController {
  self.popupController =
      [[CNPPopupController alloc] initWithContents:@[ self.calendar ]];
  self.popupController.delegate = self;
  self.popupController.theme = [CNPPopupTheme defaultTheme];
  self.popupController.theme.presentationStyle =
      CNPPopupPresentationStyleFadeIn;
  self.popupController.theme.maxPopupWidth = kScreenWidth - 30;
  self.popupController.theme.popupContentInsets = UIEdgeInsetsZero;
  //    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
  //        make.edges.equalTo(self.calendar.superview);
  //    }];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.eventHandler updateView];
}

- (void)fetchDailyReport {
  NSString *date = [self.selectedDate formattedDateWithFormat:@"yyyyMMdd"];
  [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGetDailyReport
      param:@{
        @"classuid" : self.classuid,
        @"datetime" : date,
        @"typeid" : @(self.flag + 1)
      }
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        NSMutableArray *result = [responseObject[@"data"][@"arr"] mutableCopy];
        if (result && result.count) {
          for (BBQBabyStatusModel *model in self.dataSource) {
            NSArray *stringArray =
                [model.options bk_map:^id(BBQDailyReportOptionModel *obj) {
                  return obj.cval;
                }];
            for (NSDictionary *dic in result) {
              if ([model.baby.uid.stringValue isEqualToString:dic[@"baobaouid"]]) {
                NSInteger index = [stringArray indexOfObject:dic[@"content"]];
                if (index != NSNotFound) {
                  model.selectedStatus = index;
                }
                [result removeObject:dic];
                break;
              }
            }
          }
          dispatch_async_on_main_queue(^{
            [self.tableView reloadData];
          });
        }
      }
      errorHandler:^(NSDictionary *responseObject) {

      }
      failureHandler:^(AFHTTPRequestOperation *operation, NSError *error){

      }];
}

#pragma mark - Setters

- (void)setSelectedDate:(NSDate *)selectedDate {
  _selectedDate = selectedDate;
  self.dateLabel.text =
      [NSString stringWithFormat:@"%@/%@/%@", @(selectedDate.year),
                                 @(selectedDate.month), @(selectedDate.day)];
  [self fetchDailyReport];
}

- (void)setSeletedAll:(BOOL)seletedAll {
  _seletedAll = seletedAll;
  self.selectAllView.highlighted = _seletedAll;
  for (BBQBabyStatusModel *model in self.dataSource) {
    model.selected = _seletedAll;
  }
  [self.tableView reloadData];
}

#pragma mark - Interface
- (void)reloadEntries {
  [self.tableView reloadData];
}

- (void)reloadEntryAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)showBabyList:(NSArray *)data {
  self.dataSource = data;
  [self reloadEntries];
}

#pragma mark - Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BBQChooseStatusCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"ChooseStatusCell"
                                      forIndexPath:indexPath];
  cell.indexPath = indexPath;
  cell.expandBlock = ^(NSIndexPath *indexPath) {
    [self didTapExpandViewAtIndexPath:indexPath];
  };
  cell.model = self.dataSource[indexPath.row];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  BBQBabyStatusModel *model = self.dataSource[indexPath.row];
  if (model.expand) {
    return 100;
  }
  return 50;
}

#pragma mark - Table View Delegate

#pragma mark - Event
- (IBAction)didTapChooseAll:(UITapGestureRecognizer *)recognizerer {
  self.seletedAll = !self.isSeletedAll;
}

- (IBAction)didTapDateView:(id)sender {
  [self.popupController presentPopupControllerAnimated:YES];
}

- (void)didTapExpandViewAtIndexPath:(NSIndexPath *)indexPath {
  BBQBabyStatusModel *model = self.dataSource[indexPath.row];
  model.expand = !model.expand;
  [self reloadEntries];
}

- (IBAction)didTapNextButton:(id)sender {
  //    [self.eventHandler nextStep];
  NSMutableArray *optionArray = [NSMutableArray array];
  for (NSInteger i = 0; i < self.options.count; i++) {
    BBQEditWordsModel *model = [BBQEditWordsModel new];
    model.totalCount = self.dataSource.count;
    model.status = ((BBQDailyReportOptionModel *)self.options[i]).cval;
    model.wordList =
        ((BBQDailyReportOptionModel *)self.options[i]).contentArray;
    model.cid = ((BBQDailyReportOptionModel *)self.options[i]).cid;
    model.cval = ((BBQDailyReportOptionModel *)self.options[i]).cval;
    model.selectedWord = model.wordList.firstObject;
    [optionArray addObject:model];
  }

  for (BBQBabyStatusModel *statusModel in self.dataSource) {
    if (statusModel.selected) {
      BBQEditWordsModel *model = optionArray[statusModel.selectedStatus];
      [model.babyList addObject:statusModel.baby];
    }
  }

  [optionArray bk_performSelect:^BOOL(BBQEditWordsModel *obj) {
    return obj.babyList.count;
  }];

  UIStoryboard *sb =
      [UIStoryboard storyboardWithName:@"DailyReport" bundle:nil];
  BBQDailyReportEditViewController *vc =
      [sb instantiateViewControllerWithIdentifier:@"DailyReportEditVC"];
  vc.dataSource = optionArray;
  vc.date = self.selectedDate;
  vc.typeID = @(self.flag + 1);
  vc.typeval = self.typeval;
  vc.title = self.title;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Popup Delegate
- (void)popupControllerWillPresent:(CNPPopupController *)controller {
  [self.calendar selectDate:self.selectedDate];
}

#pragma mark - FSCalendar Delegate
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date {
  if ([date isLaterThan:[NSDate date]]) {
    return NO;
  }
  return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
  self.selectedDate = date;
  [self.popupController dismissPopupControllerAnimated:YES];
}

@end

//
//  BBQCalendarViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/8/10.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQCalendarViewController.h"
#import "BBQCalendar.h"
#import <DateTools.h>
#import <Masonry.h>
#import "BabyDailyReportViewController.h"
#import "FSCalendarAppearance+BBQCalendarAppearance.h"

@interface BBQCalendarViewController () <FSCalendarDataSource,
FSCalendarDelegate>

@property (strong, nonatomic) BBQBabyModel *baby;
@property (strong, nonatomic) BBQCalendar *calendar;
@property (strong, nonatomic) NSMutableDictionary *dataSource;
@property (strong, nonatomic) NSMutableArray *eventDateArray;
@property (copy, nonatomic) NSString *baobaoname;

@end

@implementation BBQCalendarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = [NSMutableDictionary dictionary];
        _eventDateArray = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithBaby:(BBQBabyModel *)baby {
    if (self = [self init]) {
        _baby = baby;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:kScreen_Bounds];
    self.view.backgroundColor = UIColorHex(f5f5f5);
    _calendar = [[BBQCalendar alloc] initWithType:BBQCalendarTypeDailyReport];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    if (!self.navigationController.navigationBar.hidden) {
        self.navigationItem.title = self.baby.realname;
    }
    
    [self setUpCalendar];
    [self refreshEntireData];
}

- (void)refreshEntireData {
    [self.dataSource removeAllObjects];
    self.calendar.currentPage = [NSDate date];
    [self refreshSpecifyData:@{
                               @"year" : @([[NSDate date] year]),
                               @"month" : @([[NSDate date] month])
                               }];
}

- (void)refreshSpecifyData:(id)sender {
    NSDictionary *param = @{
                            @"baobaouid" :
                                self.baby.uid ?: _BaobaoId,
                            @"year" : sender[@"year"],
                            @"month" : sender[@"month"]
                            };
    
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeBabyDailyReportByMonth
     param:param
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         self.needsRefreshEntireData = NO;
         NSInteger year = [param[@"year"] integerValue];
         NSInteger month = [param[@"month"] integerValue];
         NSString *str =
         [NSString stringWithFormat:@"%ld%02ld", (long)year, (long)month];
         self.dataSource[str] = responseObject[@"data"];
         
         [self.eventDateArray removeAllObjects];
         self.needsRefreshEntireData = NO;
         [self.calendar reloadData];
     } errorHandler:nil
     failureHandler:nil];
}

- (void)setUpCalendar {
    self.calendar = [[BBQCalendar alloc] initWithType:BBQCalendarTypeDailyReport];
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
    [self.view addSubview:self.calendar];
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view)
        .insets(UIEdgeInsetsMake(15, 15, 0, 15));
        make.height.equalTo(self.view).multipliedBy(0.7);
    }];
}

#pragma mark - FSCalendar Delegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    NSSet *set = [NSSet setWithArray:self.eventDateArray];
    NSArray *arr = [set allObjects];
    if ([self calendar:self.calendar hasEventForDate:date] &&
        [date month] == [calendar.currentPage month]) {
        NSArray *array = self.dataSource[
                                         [calendar.currentPage formattedDateWithFormat:@"yyyyMM"]][@"arrdata"];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
        BabyDailyReportViewController *vc = [sb instantiateViewControllerWithIdentifier:@"BabyDailyReportVc"];
        NSDictionary *dic = array[[arr
                                   indexOfObject:date]];
        if (!dic) {
            [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"成长报告数据有误" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:nil];
            return;
        }
        vc.dataDic = array[[self.eventDateArray
                            indexOfObject:date]];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([[NSDate date] isSameDay:date]) {
        [SVProgressHUD showInfoWithStatus:@"当天数据未录入"];
    }
}

- (BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)date {
    if (!self.dataSource.count) {
        return NO;
    }
    NSArray *array = self.dataSource[
                                     [calendar.currentPage formattedDateWithFormat:@"yyyyMM"]][@"arr"];
    
    if ([date day] > array.count ||
        [date month] != [calendar.currentPage month] ||
        [array[[date day] - 1] integerValue] == 0) {
        return NO;
    }
    [self.eventDateArray addObject:date];
    if (self.eventDateArray.count ==
        ((NSArray *)self.dataSource[
                                    [calendar.currentPage formattedDateWithFormat:@"yyyyMM"]][@"arrdata"])
        .count) {
        [self.eventDateArray
         sortUsingComparator:^NSComparisonResult(NSDate *date1, NSDate *date2) {
             return [date2 isEarlierThan:date1];
         }];
    }
    return YES;
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar {
    if (self.dataSource[[calendar.currentPage formattedDateWithFormat:@"yyyyMM"]]) {
        [self.eventDateArray removeAllObjects];
        [calendar reloadData];
    } else {
        [self refreshSpecifyData:@{
                                   @"year" : @([calendar.currentPage year]),
                                   @"month" : @([calendar.currentPage month])
                                   }];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CalendarToReport"]) {
        BabyDailyReportViewController *vc = segue.destinationViewController;
        vc.dataDic = sender;
    }
}

#pragma mark - Getter & Setter
- (BBQBabyModel *)baby {
    if (!_baby) {
        _baby = TheCurBaoBao;
    }
    return _baby;
}

@end

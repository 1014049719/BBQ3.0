//
//  BabyDailyReportViewController.m
//  BBQ
//
//  Created by anymuse on 15/8/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BabyDailyReportViewController.h"
#import "DailyReportTitleCell.h"
#import "DailyReportContentCell.h"
#import "BabyDailyReportCategoryModel.h"
#import "BabyDailyReportModel.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <DateTools.h>

@interface BabyDailyReportViewController () <UITableViewDataSource,
UITableViewDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *dataSource;
@property(strong, nonatomic) BabyDailyReportModel *reportModel;
@property (copy, nonatomic) NSString *baobaoname;

@end

@implementation BabyDailyReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.bIsMessage) {
        [self downloaddata];
    } else {
        [self prepareDataSource:self.dataDic];
    }
}

- (void)prepareDataSource:(NSDictionary *)datadic {
    self.dataSource = [NSMutableArray array];
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       self.baobaoname = datadic[@"baobaoname"];
                       self.reportModel =
                       [[BabyDailyReportModel alloc] initWithDictionary:datadic];
                       
                       if (self.reportModel.zaocan.length) {
                           BabyDailyReportCategoryModel *breakfastModel =
                           [BabyDailyReportCategoryModel new];
                           breakfastModel.category = BabyDailyReportCategoryBreakfast;
                           breakfastModel.content = self.reportModel.zaocan;
                           [self.dataSource addObject:breakfastModel];
                       }
                       
                       if (self.reportModel.zhongcan.length) {
                           BabyDailyReportCategoryModel *lunchModel =
                           [BabyDailyReportCategoryModel new];
                           lunchModel.category = BabyDailyReportCategoryLunch;
                           lunchModel.content = self.reportModel.zhongcan;
                           [self.dataSource addObject:lunchModel];
                       }
                       if (self.reportModel.wushui.length) {
                           BabyDailyReportCategoryModel *noonbreakModel =
                           [BabyDailyReportCategoryModel new];
                           noonbreakModel.category = BabyDailyReportCategoryNoonBreak;
                           noonbreakModel.content = self.reportModel.wushui;
                           [self.dataSource addObject:noonbreakModel];
                       }
                       if (self.reportModel.heshui.length) {
                           BabyDailyReportCategoryModel *drinkingModel =
                           [BabyDailyReportCategoryModel new];
                           drinkingModel.category = BabyDailyReportCategoryDrinking;
                           drinkingModel.content = self.reportModel.heshui;
                           [self.dataSource addObject:drinkingModel];
                       }
                       if (self.reportModel.xxzd.length) {
                           BabyDailyReportCategoryModel *studyModel =
                           [BabyDailyReportCategoryModel new];
                           studyModel.category = BabyDailyReportCategoryStudy;
                           studyModel.content = self.reportModel.xxzd;
                           [self.dataSource addObject:studyModel];
                       }
                       if (self.reportModel.qingxu.length) {
                           BabyDailyReportCategoryModel *emotionModel =
                           [BabyDailyReportCategoryModel new];
                           emotionModel.category = BabyDailyReportCategoryEmotion;
                           emotionModel.content = self.reportModel.qingxu;
                           [self.dataSource addObject:emotionModel];
                       }
                       if (self.reportModel.jkzk.length) {
                           BabyDailyReportCategoryModel *healthModel =
                           [BabyDailyReportCategoryModel new];
                           healthModel.category = BabyDailyReportCategoryHealth;
                           healthModel.content = self.reportModel.jkzk;
                           [self.dataSource addObject:healthModel];
                       }
                       if (self.reportModel.qt.length) {
                           BabyDailyReportCategoryModel *wordsModel =
                           [BabyDailyReportCategoryModel new];
                           wordsModel.category = BabyDailyReportCategoryWords;
                           wordsModel.content = self.reportModel.qt;
                           [self.dataSource addObject:wordsModel];
                       }
                      
//                       [self.dataSource addObjectsFromArray:@[
//                                                              breakfastModel,
//                                                              lunchModel,
//                                                              noonbreakModel,
//                                                              drinkingModel,
//                                                              studyModel,
//                                                              emotionModel,
//                                                              healthModel,
//                                                              wordsModel
//                                                              ]];
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [self.tableView reloadData];
                       });
                   });
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = (DailyReportTitleCell *)
        [tableView dequeueReusableCellWithIdentifier:@"DailyReportTitleCell"
                                        forIndexPath:indexPath];
        NSDate *date = [NSDate dateWithString:self.reportModel.datetime
                                 formatString:@"yyyyMMdd"];
        NSString *dateString = [date formattedDateWithFormat:@"yyyy年MM月dd日"];
        ((DailyReportTitleCell *)cell).reportTitleLabel.text = [NSString stringWithFormat:@"%@的 %@ 报告", self.baobaoname, dateString];
    } else {
        cell = (DailyReportContentCell *)
        [tableView dequeueReusableCellWithIdentifier:@"DailyReportContentCell"
                                        forIndexPath:indexPath];
        ((DailyReportContentCell *)cell).model = self.dataSource[indexPath.row - 1];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"DailyReportTitleCell"
                                        cacheByIndexPath:indexPath
                                           configuration:nil];
    }
    return [tableView
            fd_heightForCellWithIdentifier:@"DailyReportContentCell"
            cacheByIndexPath:indexPath
            configuration:^(DailyReportContentCell *cell) {
                cell.model = self.dataSource[indexPath.row - 1];
            }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///数据请求
- (void)downloaddata {
    
    NSString *year = [self.strDate substringToIndex:4];
    NSRange range = NSMakeRange(4, 2);
    NSString *month = [self.strDate substringWithRange:range];
    NSString *day = [self.strDate substringWithRange:NSMakeRange(6, 2)];
    int nDay = [day intValue];
    
    NSDictionary *param = @{
                            @"baobaouid" : self.baobaouid,
                            @"year" : year,
                            @"month" : month
                            };
    
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeBabyDailyReportByMonth
     param:param
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         
         NSArray *arrflag = responseObject[@"data"][@"arr"];
         NSArray *arrdata = responseObject[@"data"][@"arrdata"];
         int num = pickJsonIntValue(responseObject[@"data"], @"num");
         
         //计算位置
         int count = 0;
         for (int i = 0; i < [day intValue]; i++)
             if ([[arrflag objectAtIndex:i] intValue] == 1)
                 count++;
         
         if (arrflag && nDay <= arrflag.count && nDay > 0 &&
             [[arrflag objectAtIndex:nDay - 1] intValue] == 1 && count <= num &&
             count > 0) {
             NSDictionary *dic = [arrdata objectAtIndex:count - 1];
             [self prepareDataSource:dic];
             return;
         } else {
             [SVProgressHUD showErrorWithStatus:@"对不起，没有这一天的成长报告"];
         }
     } errorHandler:nil
     failureHandler:nil];
}

@end

//
//  DailyReportListViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/9/11.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "DailyReportListViewController.h"

#import "EverydayReportModel.h"
#import "EverydayReportCell.h"
#import "WebViewController.h"
#import "NetConstDefine.h"
#import "LoadingView.h"
#import "BBQChooseStatusWireframe.h"

@interface DailyReportListViewController () <UITableViewDataSource,
                                             UITableViewDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *dataAry;
@property(strong, nonatomic) LoadingView *loadingView;

@end

@implementation DailyReportListViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"成长报告";

  self.tableView.tableFooterView = [UIView new];
  self.loadingView =
      [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil]
          .firstObject;
  [self.view addSubview:self.loadingView];
  [self.view bringSubviewToFront:self.loadingView];

  WS(weakSelf)
  self.loadingView.buttonBlock = ^{
    [weakSelf dailyReportRequest];
  };
  [self dailyReportRequest];
  [self initValues];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)initValues {
  if (self.dataAry == nil) {
    self.dataAry = [NSMutableArray arrayWithCapacity:0];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  EverydayReportCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"cell1"
                                      forIndexPath:indexPath];

  EverydayReportModel *model = self.dataAry[indexPath.row];

  // 还需要记录的状态
  if ([model.flag intValue] == 0) {
    cell.contentLabel.text =
        [NSString stringWithFormat:@"宝宝们的%@状态需要记录啦~",
                                   model.itemName];
  } else {
    cell.contentLabel.text =
        [NSString stringWithFormat:@"宝宝们的%@状态已经记录啦~",
                                   model.itemName];
    cell.contentLabel.textColor = [UIColor colorWithHexString:@"333333"];
  }

  if ([model.itemName isEqualToString:@"早餐"]) {
    cell.imageView.image = [UIImage imageNamed:@"dailyreport_breakfast"];
  } else if ([model.itemName isEqualToString:@"午餐"]) {
    cell.imageView.image = [UIImage imageNamed:@"dailyreport_lunch"];
  } else if ([model.itemName isEqualToString:@"午睡"]) {
    cell.imageView.image = [UIImage imageNamed:@"dailyreport_noonbreak"];
  } else if ([model.itemName isEqualToString:@"喝水"]) {
    cell.imageView.image = [UIImage imageNamed:@"dailyreport_drinking"];
  } else if ([model.itemName isEqualToString:@"学习"]) {
    cell.imageView.image = [UIImage imageNamed:@"dailyreport_study"];
  } else if ([model.itemName isEqualToString:@"情绪"]) {
    cell.imageView.image = [UIImage imageNamed:@"dailyreport_emotion"];
  } else if ([model.itemName isEqualToString:@"健康"]) {
    cell.imageView.image = [UIImage imageNamed:@"dailyreport_health"];
  } else if ([model.itemName isEqualToString:@"寄语"]) {
    cell.imageView.image = [UIImage imageNamed:@"dailyreport_words"];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  //选中 反选
  [tableView deselectRowAtIndexPath:indexPath animated:YES];

  EverydayReportModel *model = self.dataAry[indexPath.row];
  int flag = 0;
  if ([model.itemName isEqualToString:@"早餐"]) {
    flag = 0;
  } else if ([model.itemName isEqualToString:@"午餐"]) {
    flag = 1;
  } else if ([model.itemName isEqualToString:@"午睡"]) {
    flag = 2;
  } else if ([model.itemName isEqualToString:@"喝水"]) {
    flag = 3;
  } else if ([model.itemName isEqualToString:@"学习"]) {
    flag = 4;
  } else if ([model.itemName isEqualToString:@"情绪"]) {
    flag = 5;
  } else if ([model.itemName isEqualToString:@"健康"]) {
    flag = 6;
  } else if ([model.itemName isEqualToString:@"寄语"]) {
    flag = 7;
  }

  NSString *path;
  NSString *strDate = [CommonFunc getCurrentDate];
  strDate = [strDate stringByReplacingOccurrencesOfString:@"-" withString:@""];

  BBQClassDataModel *classModel = TheCurUser.classdata.firstObject;

  if (flag == 0)
    path = [NSString stringWithFormat:URL_ZAOCAN, classModel.classid, strDate];
  else if (flag == 1)
    path =
        [NSString stringWithFormat:URL_ZHONGCAN, classModel.classid, strDate];
  else if (flag == 2)
    path = [NSString stringWithFormat:URL_WUSHUI, classModel.classid, strDate];
  else if (flag == 3)
    path = [NSString stringWithFormat:URL_HESHUI, classModel.classid, strDate];
  else if (flag == 4)
    path = [NSString stringWithFormat:URL_XUEXI, classModel.classid, strDate];
  else if (flag == 5)
    path = [NSString stringWithFormat:URL_QINGXU, classModel.classid, strDate];
  else if (flag == 6)
    path =
        [NSString stringWithFormat:URL_JIANGKANG, classModel.classid, strDate];
  else if (flag == 7)
    path =
        [NSString stringWithFormat:URL_SHUOMING, classModel.classid, strDate];

  //
  //    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar"
  //    bundle:nil];
  //    WebViewController *vc = [sb
  //    instantiateViewControllerWithIdentifier:@"WebViewController"];
  //
  //    vc.url = path;
  //    [self.navigationController pushViewController:vc animated:NO];
  //
  //
  BBQChooseStatusWireframe *wireframe = [BBQChooseStatusWireframe new];
  wireframe.flag = flag;
  wireframe.classuid = classModel.classid.stringValue;
  [wireframe presentChooseStatusControllerFromNavigationController:
                 self.navigationController];
}

/// 每日报告
- (void)dailyReportRequest {
  [self.dataAry removeAllObjects];
  BBQClassDataModel *classModel = TheCurUser.classdata[0];
  NSDictionary *params = @{ @"classid" : classModel.classid };
  [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeDailyReport
      param:params
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        dispatch_async(
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              NSArray *tempAry = responseObject[@"data"][@"arrdata"];
              if (tempAry.count) {
                for (NSDictionary *tempDic in tempAry) {
                  EverydayReportModel *model =
                      [[EverydayReportModel alloc] initWithDic:tempDic];
                  [self.dataAry addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                  [self.tableView reloadData];
                  [self.loadingView dismiss];
                });
              } else {
                if (self.loadingView.isShowing) {
                  self.loadingView.status = BBQLoadingViewStatusNoContent;
                } else {
                  [self.view addSubview:self.loadingView];
                  [self.view bringSubviewToFront:self.loadingView];
                  self.loadingView.status = BBQLoadingViewStatusNoContent;
                }
              }
            });
      }
      errorHandler:^(NSDictionary *responseObject) {
        if (self.loadingView.isShowing) {
          self.loadingView.status = BBQLoadingViewStatusError;
        } else {
          [self.view addSubview:self.loadingView];
          [self.view bringSubviewToFront:self.loadingView];
          self.loadingView.status = BBQLoadingViewStatusError;
        }
      }
      failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (self.loadingView.isShowing) {
          self.loadingView.status = BBQLoadingViewStatusError;
        } else {
          [self.view addSubview:self.loadingView];
          [self.view bringSubviewToFront:self.loadingView];
          self.loadingView.status = BBQLoadingViewStatusError;
        }
      }];
}

@end

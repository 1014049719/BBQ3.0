//
//  TeLeDouViewController.m
//  BBQ
//
//  Created by wth on 15/8/18.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "TeLeDouViewController.h"
#import "LeDouModel.h"
#import "LeDouCell.h"
#import <Masonry.h>
#import "LoadingView.h"
#import <DateTools.h>

@interface TeLeDouViewController () <UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) IBOutlet UITableView *tableview;

@property(strong, nonatomic) NSMutableArray *dataAry;
@property(weak, nonatomic) IBOutlet UILabel *leDouCountLabel;
@property(strong, nonatomic) LoadingView *loadingView;
@end

@implementation TeLeDouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [UIView new];
    _dataAry = [NSMutableArray arrayWithCapacity:0];
    
    self.loadingView =
    [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil]
    .firstObject;
    [self.view insertSubview:self.loadingView aboveSubview:self.tableview];
    self.loadingView.status = BBQLoadingViewStatusLoading;
    WS(weakSelf)
    self.loadingView.buttonBlock = ^{
        [weakSelf getLeDouHistory];
    };
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (self.bbq_ld_num) {
        NSString *string =
        [NSString stringWithFormat:@"总乐豆:%@", self.bbq_ld_num];
        NSMutableAttributedString *attString =
        [[NSMutableAttributedString alloc] initWithString:string];
        [attString addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"ff6440"]
                          range:NSMakeRange(4, self.bbq_ld_num.length)];
        
        [self.leDouCountLabel setAttributedText:attString];
    }
    
    [self getLeDouHistory];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataAry count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeDouCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                      forIndexPath:indexPath];
    LeDouModel *model = self.dataAry[indexPath.row];
    cell.dateLineLabel.text = [NSDate timeAgoSinceDate:[NSDate dateWithTimeIntervalSince1970:[model.dateLine doubleValue]]];
    NSMutableArray *rangeArray = [NSMutableArray array];
    
    NSRange originRange = NSMakeRange(0, model.desc.length);
    while (1) {
        NSRange tempRange = [model.desc
                             rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]
                             options:NSBackwardsSearch
                             range:originRange];
        if (tempRange.location == NSNotFound) {
            break;
        }
        [rangeArray addObject:[NSValue valueWithRange:tempRange]];
        if (tempRange.location == 0) {
            break;
        }
        originRange = NSMakeRange(0, tempRange.location);
    }
    
    NSMutableAttributedString *str =
    [[NSMutableAttributedString alloc] initWithString:model.desc];
    
    [rangeArray
     enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL *stop) {
         NSRange range = [value rangeValue];
         [str addAttribute:NSForegroundColorAttributeName
                     value:[UIColor colorWithHexString:@"ff6440"]
                     range:range];
     }];
    
    cell.descLabel.attributedText = str;
    
    return cell;
}

/// 帮助点击
- (IBAction)helpBtnEvent:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    UIViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"HelpViewVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取乐豆记录
- (void)getLeDouHistory {
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGetLeDouHistory
                            param:nil
                   successHandler:^(AFHTTPRequestOperation *operation,
                                    NSDictionary *responseObject, bool apiSuccess) {
                       dispatch_async(
                                      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                          NSArray *tempAry = responseObject[@"data"][@"arr"];
                                          if (tempAry && [tempAry isKindOfClass:[NSArray class]] &&
                                              [tempAry count] > 0) {
                                              for (NSDictionary *tempDic in tempAry) {
                                                  LeDouModel *model = [[LeDouModel alloc] initWithDic:tempDic];
                                                  [_dataAry addObject:model];
                                              }
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self.tableview reloadData];
                                              });
                                              [self.loadingView dismiss];
                                          } else {
                                              self.loadingView.status = BBQLoadingViewStatusNoContent;
                                          }
                                      });
                   }
                     errorHandler:^(NSDictionary *responseObject) {
                         self.loadingView.status = BBQLoadingViewStatusError;
                     }
                   failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                       self.loadingView.status = BBQLoadingViewStatusError;
                   }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little
 preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

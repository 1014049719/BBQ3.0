//
//  JifenDetailTableViewController.m
//  BBQ
//
//  Created by wth on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "JifenDetailTableViewController.h"
#import "TeJiFenDetailModel.h"
#import "JiFenDetailCell.h"
#import <DateTools.h>

@interface JifenDetailTableViewController ()

@property(strong, nonatomic) NSMutableArray *dataAry;

@end

@implementation JifenDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    if (_dataAry == nil) {
        _dataAry = [NSMutableArray arrayWithCapacity:0];
    }
    
    [self getJiFenDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JiFenDetailCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"cell"
                                    forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    TeJiFenDetailModel *model = self.dataAry[indexPath.row];
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

#pragma mark - 获取积分明细
- (void)getJiFenDetail {
    [SVProgressHUD showWithStatus:@"请稍候..."];
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetJiFenDetail
     param:nil
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         [SVProgressHUD dismiss];
         dispatch_async(
                        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            NSArray *tempAry = responseObject[@"data"][@"arr"];
                            for (NSDictionary *tempDic in tempAry) {
                                TeJiFenDetailModel *model =
                                [[TeJiFenDetailModel alloc] initWithDic:tempDic];
                                [_dataAry addObject:model];
                            }
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.tableView reloadData];
                            });
                        });
     } errorHandler:nil
     failureHandler:nil];
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

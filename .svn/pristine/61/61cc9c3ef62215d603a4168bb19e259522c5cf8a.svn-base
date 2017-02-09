//
//  GiverRecordTableViewController.m
//  BBQ
//
//  Created by wth on 15/8/12.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "GiverRecordTableViewController.h"
#import "TeGiverRecordModel.h"
#import "GiverRecordCell.h"
#import <DateTools.h>
#import "NSString+Common.h"

@interface GiverRecordTableViewController ()

@property(strong, nonatomic) NSMutableArray *dataAry;

@end

@implementation GiverRecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self initValues];
    [self getGiftRecord];
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
    GiverRecordCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"GiverRecordCell"
                                    forIndexPath:indexPath];
    
    TeGiverRecordModel *model = self.dataAry[indexPath.row];
    [cell.headerBtn setBackgroundImageWithURL:[NSURL URLWithString:model.fbztx] forState:UIControlStateNormal placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionRefreshImageCache completion:nil];
    if ([model.groupKey integerValue] == BBQGroupkeyTypeParent) {
        NSString *relation = [NSString relationshipWithID:model.gxid.numberValue gxname:model.gxname];
        cell.nameLabel.text = [model.baobaoname stringByAppendingString:relation];
    } else {
        cell.nameLabel.text = model.nickName;
    }
    
    cell.giftLabel.text = [NSString
                           stringWithFormat:@"赠送了%@份%@", model.giftCount, model.giftName];
    cell.datelineLabel.text = [NSDate timeAgoSinceDate:[NSDate dateWithTimeIntervalSince1970:[model.dateLine doubleValue]]];
    [cell.giftImage setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholder:Placeholder_avatar];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - 网络请求

- (void)getGiftRecord {
    [SVProgressHUD showWithStatus:@"请稍候..."];
    NSDictionary *params = @{ @"giftid" : self.giftID };
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetGiverRecord
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         [SVProgressHUD dismiss];
         dispatch_async(
                        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            NSArray *tempAry = responseObject[@"data"][@"arr"];
                            for (NSDictionary *tempDic in tempAry) {
                                TeGiverRecordModel *model =
                                [[TeGiverRecordModel alloc] initWithDic:tempDic];
                                [self.dataAry addObject:model];
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

//
//  JifenViewController.m
//  BBQ
//
//  Created by wth on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "JifenViewController.h"
#import "TeJiFenModel.h"
#import "TeJiFenCell.h"
#import "TeSetLocationTableViewController.h"

@interface JifenViewController () <
UICollectionViewDelegate, UICollectionViewDataSource, UIAlertViewDelegate>

@property(weak, nonatomic) IBOutlet UICollectionView *JifenCollectionView;

@property(strong, nonatomic) NSMutableArray *dataAry;

@property(strong, nonatomic) TeJiFenModel *jiFenModel;

@property(copy, nonatomic) NSString *jiFenNum;

@end

@implementation JifenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    _JifenCollectionView.delegate = self;
    _JifenCollectionView.dataSource = self;
    
    [self initValues];
    [self getJiFenData];
}

- (void)initValues {
    if (self.dataAry == nil) {
        self.dataAry = [NSMutableArray arrayWithCapacity:0];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.dataAry.count;
}
// cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 60) / 2;
    return CGSizeMake(itemWidth + 10, itemWidth - 10);
}
//上下行距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)
collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}
//左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)
collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
//偏移量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(15, 12, 15, 12);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeJiFenCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                              forIndexPath:indexPath];
    
    TeJiFenModel *model = self.dataAry[indexPath.row];
    [cell.JiFenImage setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholder:Placeholder_avatar];
    cell.JiFenGiftName.text = model.giftName;
    NSString *str = [NSString stringWithFormat:@"%@积分", model.jiFen];
    NSMutableAttributedString *attString =
    [[NSMutableAttributedString alloc] initWithString:str];
    [attString addAttribute:NSForegroundColorAttributeName
                      value:[UIColor redColor]
                      range:NSMakeRange(0, model.jiFen.length)];
    [cell.JiFenNum setAttributedText:attString];
    cell.exchangeBtn.tag = indexPath.row;
    
    if ([model.jiFen intValue] > [self.jiFenNum intValue]) {
        [cell.exchangeBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return cell;
}

#pragma mark - 网络请求

- (void)getJiFenData {
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetJiFenGiftData
     param:nil
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         dispatch_async(
                        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            NSArray *tempAry = responseObject[@"data"][@"arr"];
                            for (NSDictionary *tempDic in tempAry) {
                                TeJiFenModel *model =
                                [[TeJiFenModel alloc] initWithDic:tempDic];
                                [self.dataAry addObject:model];
                            }
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSString *string = [NSString
                                                    stringWithFormat:@"%@", responseObject[@"data"][@"jifen"]];
                                if ([string isEqualToString:@"(null)"]) {
                                    string = @"0";
                                }
                                self.jiFenNumLabel.text = string;
                                self.jiFenNum = string;
                                [self.JifenCollectionView reloadData];
                            });
                        });
     } errorHandler:nil
     failureHandler:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 兑换button点击
- (IBAction)exchangeBtnEvent:(UIButton *)sender {
    self.jiFenModel = self.dataAry[sender.tag];
    
    if ([self.jiFenModel.jiFen intValue] > [self.jiFenNum intValue]) {
        [SVProgressHUD showErrorWithStatus:@"积分不足"];
    } else {
        [self createAlertViewWithModel:self.jiFenModel];
    }
}

- (void)createAlertViewWithModel:(TeJiFenModel *)model {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:[NSString
                                   stringWithFormat:@"是否兑换 %@， 兑换后， "
                                   @"您的积分将扣除 %@。",
                                   model.giftName, model.jiFen]
                          delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1: {
            //            [self exchangeGift];
            
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
            TeSetLocationTableViewController *vc =
            [SB instantiateViewControllerWithIdentifier:@"TeSetLocationVC"];
            vc.callBackJiFenBlock = ^(NSString *jiFen) {
                self.jiFenNumLabel.text = [NSString
                                           stringWithFormat:@"%d", [self.jiFenNum intValue] - [jiFen intValue]];
                self.jiFenNum = self.jiFenNumLabel.text;
                NSString *message = @"恭喜您已经成功兑换，我们将在一个月内发出您的京东礼品卡，可拨打客服电话400-090-3011查询快递详情";
                [UIAlertView bk_showAlertViewWithTitle:@"提示" message:message cancelButtonTitle:@"确定" otherButtonTitles:nil handler:nil];
            };
            vc.jiFenModel = self.jiFenModel;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
            
        default:
            break;
    }
}

/// 兑换礼品网络请求
- (void)exchangeGift {
    [SVProgressHUD showWithStatus:@"请稍候..."];
    NSDictionary *params = @{
                             @"giftid" : self.jiFenModel.giftID,
                             @"giftname" : self.jiFenModel.giftName,
                             @"giftnum" : @1
                             };
    
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeExchangeGift
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         NSString *successMessage = @"兑换成功";
         [SVProgressHUD showSuccessWithStatus:successMessage];
         dispatch_after(
                        dispatch_time(
                                      DISPATCH_TIME_NOW,
                                      (int64_t)(HUD_DURATION(successMessage) * NSEC_PER_SEC)),
                        dispatch_get_main_queue(), ^{
                            self.jiFenNumLabel.text = [NSString
                                                       stringWithFormat:@"%d", [self.jiFenNum intValue] -
                                                       [self.jiFenModel.jiFen intValue]];
                            self.jiFenNum = [NSString
                                             stringWithFormat:@"%d", [self.jiFenNum intValue] -
                                             [self.jiFenModel.jiFen intValue]];
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

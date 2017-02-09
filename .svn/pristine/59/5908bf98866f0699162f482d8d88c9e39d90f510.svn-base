//
//  TeSetLocationTableViewController.m
//  BBQ
//
//  Created by wth on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "TeSetLocationTableViewController.h"
#import "CityPicker.h"
#import "SetLocationModel.h"
#import <BlocksKit.h>

@interface TeSetLocationTableViewController () <UITableViewDelegate>

@property(strong, nonatomic) CityPicker *cityPicker;

@property(weak, nonatomic) IBOutlet UIButton *locationBtn;

@property(weak, nonatomic) IBOutlet UILabel *locationLabel;

@property(weak, nonatomic) IBOutlet UITextField *nameTextField;

@property(weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property(weak, nonatomic) IBOutlet UITextField *postNumTextField;

@property(weak, nonatomic) IBOutlet UITextField *addressTextField;
/// 是否有地址
@property(assign, nonatomic) BOOL haveLocation;

@property(strong, nonatomic) SetLocationModel *locationModel;

@end

@implementation TeSetLocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置收货地址";
    self.tableView.tableFooterView = [UIView new];
    
    // 城市选择器
    NSArray *ary =
    [[NSBundle mainBundle] loadNibNamed:@"CityPicker" owner:self options:nil];
    _cityPicker = ary[0];
    self.tableView.delegate = self;
    
    [self getLocationData];
}

//选择地区
- (IBAction)selectCityBtnClick:(id)sender {
    
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.postNumTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    
    __weak typeof(self) weakSelf = self;
    _cityPicker.cityPickerBlock = ^(CityPickerModel *model) {
        weakSelf.locationLabel.text = [NSString
                                       stringWithFormat:@"%@%@%@", model.provice, model.city, model.area];
    };
    [self.view addSubview:_cityPicker];
}

//确认提交
- (IBAction)EnterBtnClick:(id)sender {
    
    [self.nameTextField endEditing:YES];
    [self.phoneTextField endEditing:YES];
    [self.postNumTextField endEditing:YES];
    [self.addressTextField endEditing:YES];
    
    if (self.nameTextField.text.length == 0) {
        [CommonFunc showAlertView:@"请填写收货人姓名"];
    } else if (self.phoneTextField.text.length == 0) {
        [CommonFunc showAlertView:@"请填写收货人手机号码"];
    } else if (self.postNumTextField.text.length == 0) {
        [CommonFunc showAlertView:@"请填写邮编"];
    } else if (self.locationLabel.text.length == 0 ||
               [self.locationLabel.text
                isEqualToString:@"请选择所在地区"]) {
                   [CommonFunc showAlertView:@"请选择收货人所在地区"];
               } else if (self.addressTextField.text.length == 0) {
                   [CommonFunc showAlertView:@"请填写收货人详细地址"];
               }
    
               else {
                   if (self.haveLocation == NO) {
                       [self addNewGoodsLocation];
                   } else if (self.locationModel &&
                              [self.locationModel isKindOfClass:[SetLocationModel class]] &&
                              self.haveLocation == YES) {
                       
                       /**
                        * 收货地址有变动的情况
                        * 1. 先进行修改收货地址网络请求
                        * 2. 修改地址成功之后再进去兑换礼物请求
                        */
                       if (![self.locationModel.name isEqualToString:self.nameTextField.text] ||
                           ![self.locationModel.phone
                             isEqualToString:self.phoneTextField.text] ||
                           ![self.locationModel.postNumber
                             isEqualToString:self.postNumTextField.text] ||
                           ![self.locationModel.area isEqualToString:self.locationLabel.text] ||
                           ![self.locationModel.address
                             isEqualToString:self.addressTextField.text]) {
                               
                               [self modifyGoodsLocation];
                           }
                       
                       /**
                        * 收货地址没有变动的情况
                        * 直接进行兑换礼物请求
                        */
                       else {
                           if (self.jiFenModel &&
                               [self.jiFenModel isKindOfClass:[TeJiFenModel class]]) {
                               [self exchangeGift];
                           } else {
                               [SVProgressHUD showErrorWithStatus:@"地址没有变动"];
                           }
                       }
                   }
               }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/// 查询收货地址
- (void)getLocationData {
    [SVProgressHUD showWithStatus:@"请稍候..."];
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetGoodsLocation
     param:nil
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         [SVProgressHUD dismiss];
         NSArray *tempAry = responseObject[@"data"][@"arr"];
         if (tempAry.count > 0) {
             // 已有收货地址数据
             self.haveLocation = YES;
             NSDictionary *tempDic = tempAry[0];
             self.locationModel = [[SetLocationModel alloc] initWithDic:tempDic];
             // 更新页面数据
             [self updateMainViewWithModel:self.locationModel];
         }
     } errorHandler:nil
     failureHandler:nil];
}

/// 新增收货地址
- (void)addNewGoodsLocation {
    [SVProgressHUD showWithStatus:@"请稍候..."];
    NSDictionary *params = @{
                             @"rceive_name" : self.nameTextField.text,
                             @"phone" : self.phoneTextField.text,
                             @"yzbm" : self.postNumTextField.text,
                             @"area" : self.locationLabel.text,
                             @"address" : self.addressTextField.text
                             };
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeAddNewGoodsLocation
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         if (self.jiFenModel &&
             [self.jiFenModel isKindOfClass:[TeJiFenModel class]]) {
             
             [self exchangeGift];
         }
         // 如果是直接进入收货地址页面 新增成功之后返回
         else {
             [SVProgressHUD showSuccessWithStatus:@"新增成功"];
             dispatch_after(
                            dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.74 * NSEC_PER_SEC)),
                            dispatch_get_main_queue(), ^{
                                [self.navigationController popViewControllerAnimated:YES];
                            });
         }
     } errorHandler:nil
     failureHandler:nil];
}

/// 编辑收货地址
- (void)modifyGoodsLocation {
    [SVProgressHUD showWithStatus:@"请稍候..."];
    NSDictionary *params = @{
                             @"rceive_name" : self.nameTextField.text,
                             @"phone" : self.phoneTextField.text,
                             @"yzbm" : self.postNumTextField.text,
                             @"area" : self.locationLabel.text,
                             @"address" : self.addressTextField.text,
                             @"id" : self.locationModel.locationID
                             };
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeModifyGoodsLocation
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         if (self.jiFenModel &&
             [self.jiFenModel isKindOfClass:[TeJiFenModel class]]) {
             
             [self exchangeGift];
         }
         // 如果是直接进入收货地址页面 编辑成功之后返回
         else {
             [SVProgressHUD showSuccessWithStatus:@"修改成功"];
             dispatch_after(
                            dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.74 * NSEC_PER_SEC)),
                            dispatch_get_main_queue(), ^{
                                [self.navigationController popViewControllerAnimated:YES];
                            });
         }
     } errorHandler:nil
     failureHandler:nil];
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
         [SVProgressHUD dismiss];
         
         dispatch_async_on_main_queue(^{
             // 兑换成功之后通知 我的 页面刷新数据
             [[NSNotificationCenter defaultCenter]
              postNotificationName:kSetNeedsRefreshEntireDataNotification
              object:nil
              userInfo:@{
                         @"type" : @(BBQRefreshNotificationTypeUserInfo)
                         }];
             if (self.callBackJiFenBlock) {
                 self.callBackJiFenBlock(self.jiFenModel.jiFen);
                 
                 [self.navigationController popViewControllerAnimated:YES];
             }
         });
     } errorHandler:nil
     failureHandler:nil];
}

- (void)updateMainViewWithModel:(SetLocationModel *)model {
    self.nameTextField.text = model.name;
    self.phoneTextField.text = model.phone;
    self.postNumTextField.text = model.postNumber;
    self.locationLabel.text = model.area;
    self.addressTextField.text = model.address;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.postNumTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
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

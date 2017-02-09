//
//  RemindPhotoViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/9/11.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "RemindPhotoViewController.h"
#import "TeRemindPhotoCell.h"
#import "TeRemindPhotoModel.h"
#import "BBQSchoolDataModel.h"
#import "AppMacro.h"
#import "AuthorizationHelper.h"
#import "QBImagePickerController.h"
#import "LoadingView.h"

@interface RemindPhotoViewController ()
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *dataAry;
@property(strong, nonatomic) LoadingView *loadingView;

@end

@implementation RemindPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.loadingView =
    [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil]
    .firstObject;
    [self.view addSubview:self.loadingView];
    [self.view bringSubviewToFront:self.loadingView];
    WS(weakSelf)
    self.loadingView.buttonBlock = ^{
        [weakSelf photoRemindRequest];
    };
    [self initValues];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self photoRemindRequest];
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
    
    TeRemindPhotoCell *cell1 =
    [tableView dequeueReusableCellWithIdentifier:@"Cell1"
                                    forIndexPath:indexPath];
    
    TeRemindPhotoModel *model = self.dataAry[indexPath.row];
    [cell1.headerButton setBackgroundImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionRefreshImageCache completion:nil];
    cell1.nameLabel.text = model.baobaoName;
    
    // 不是会员
    if ([model.qzkbz intValue] == 0) {
        cell1.todayPhotoLabel.text = @"暂未开通成长书服务";
        cell1.needPhotoImg.hidden = YES;
    } else {
        
        if ([model.finished intValue] == 1) {
            cell1.needPhotoImg.hidden = YES;
            NSString *string = [NSString
                                stringWithFormat:@"已帮宝宝拍完%@张照片~", model.pic_num2];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc] initWithString:string];
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithHexString:@"ff6440"]
                         range:NSMakeRange(6, model.pic_num2.length)];
            [cell1.todayPhotoLabel setAttributedText:text];
        } else {
            if ([model.flag intValue] == 1) {
                NSString *string =
                [NSString stringWithFormat:@"今日还有%@张照片待拍哦~",
                 model.pic_num3];
                NSMutableAttributedString *text =
                [[NSMutableAttributedString alloc] initWithString:string];
                [text addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithHexString:@"ff6440"]
                             range:NSMakeRange(4, model.pic_num3.length)];
                [cell1.todayPhotoLabel setAttributedText:text];
                cell1.needPhotoImg.hidden = NO;
            } else {
                
                NSString *string = [NSString
                                    stringWithFormat:@"%@还有%@张照片待拍哦~",
                                    [CommonFunc
                                     getDateString:[model.dateLine doubleValue]],
                                    model.pic_num3];
                NSMutableAttributedString *text =
                [[NSMutableAttributedString alloc] initWithString:string];
                [text addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithHexString:@"ff6440"]
                             range:NSMakeRange(12, model.pic_num3.length)];
                [cell1.todayPhotoLabel setAttributedText:text];
                cell1.needPhotoImg.hidden = NO;
            }
        }
    }
    
    return cell1;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TeRemindPhotoModel *model = self.dataAry[indexPath.row];
    BBQBabyModel *baby = [BBQBabyModel new];
    
    for (BBQBabyModel *babyModel in TheCurUser.baobaodata) {
        if ([model.uid isEqualToString:[babyModel.uid stringValue]]) {
            baby = babyModel;
        }
    }
    //跳转到发表
    if (![AuthorizationHelper checkPhotoLibraryAuthorizationStatus]) {
        return;
    }
    Dynamic *dynamic = [Dynamic dynamicWithMediaType:BBQDynamicMediaTypePhoto object:baby];
    [self createNewDynamic:dynamic];
}
- (void)createNewDynamic:(Dynamic *)dynamic {
    QBImagePickerController *imagePicker = [[QBImagePickerController alloc] initWithDynamic:dynamic];
    [self.navigationController
     pushViewController:imagePicker
     animated:YES];
}
#pragma mark - 网络请求

/// 拍照提醒
- (void)photoRemindRequest {
    [SVProgressHUD showWithStatus:@"请稍候"];
    [self.dataAry removeAllObjects];
    BBQClassDataModel *classModel = TheCurUser.classdata[0];
    NSDictionary *params = @{ @"classid" : classModel.classid };
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypePhotoRemind
                            param:params
                   successHandler:^(AFHTTPRequestOperation *operation,
                                    NSDictionary *responseObject, bool apiSuccess) {
                       [SVProgressHUD dismiss];
                       dispatch_async(
                                      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                          NSArray *tempAry = responseObject[@"data"][@"arr"];
                                          if (tempAry.count) {
                                              for (NSDictionary *tempDic in tempAry) {
                                                  TeRemindPhotoModel *model =
                                                  [[TeRemindPhotoModel alloc] initWithDic:tempDic];
                                                  [self.dataAry addObject:model];
                                              }
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self.tableView reloadData];
                                                  [self.loadingView dismiss];
                                              });
                                          } else {
                                              dispatch_async_on_main_queue(^{
                                                  if (self.loadingView.isShowing) {
                                                      self.loadingView.status = BBQLoadingViewStatusNoContent;
                                                  } else {
                                                      [self.view addSubview:self.tableView];
                                                      [self.view bringSubviewToFront:self.loadingView];
                                                      self.loadingView.status = BBQLoadingViewStatusNoContent;
                                                  }
                                              });
                                          }
                                      });
                   }
                     errorHandler:^(NSDictionary *responseObject) {
                         [SVProgressHUD dismiss];
                         if (self.loadingView.isShowing) {
                             self.loadingView.status = BBQLoadingViewStatusError;
                         } else {
                             [self.view addSubview:self.tableView];
                             [self.view bringSubviewToFront:self.loadingView];
                             self.loadingView.status = BBQLoadingViewStatusError;
                         }
                     }
                   failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                       [SVProgressHUD dismiss];
                       if (self.loadingView.isShowing) {
                           self.loadingView.status = BBQLoadingViewStatusError;
                       } else {
                           [self.view addSubview:self.tableView];
                           [self.view bringSubviewToFront:self.loadingView];
                           self.loadingView.status = BBQLoadingViewStatusError;
                       }
                   }];
}

@end

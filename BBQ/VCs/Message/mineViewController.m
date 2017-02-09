//
//  mineViewController.m
//  JYEX
//
//  Created by wth on 15/7/20.
//  Copyright (c) 2015年 广州洋基. All rights reserved.
//

#import "mineViewController.h"
#import "RelativeModel.h"
#import "userModifyTableViewController.h"
#import "UserDataShowViewController.h"
#import <UINavigationBar+Awesome.h>
#import "UserDataModel.h"
#import "UIImageView+Extension.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "ResetUserDataTableViewController.h"
#import "userModifyTableViewController.h"
#import <IMYThemeConfig.h>
#import "BBQUserInfoApi.h"

@interface mineViewController ()

@property(weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *dynaLabel;
@property(weak, nonatomic) IBOutlet UILabel *photosLabel;
/// 用来保存传到下个页面的model
@property(strong, nonatomic) RelativeModel *jumpModel;
@property(weak, nonatomic) IBOutlet UIImageView *userHeadView;

@property(strong, nonatomic) UserDataModel *userDataModel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

#pragma mark 老师端
//容器
@property(weak, nonatomic) IBOutlet UIView *containerView;

// iphone4s layout变化
//头像布局
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *headLayout_top;
//文字布局
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelLayout_top;

@end

@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController hidesBottomBarWhenPushed];
    self.navBar.translucent = YES;
    [self.navBar lt_setBackgroundColor:[UIColor clearColor]];
    
    
    [self.bgImgView imy_setImageForKey:@"login_bg"];
    UITapGestureRecognizer *tapHeadView =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(checkUserInfo:)];
    [self.userHeadView addGestureRecognizer:tapHeadView];
    
    self.userHeadView.layer.masksToBounds = YES;
    self.userHeadView.layer.cornerRadius =
    CGRectGetHeight(self.userHeadView.frame) / 2.0;
    self.userHeadView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userHeadView.layer.borderWidth = 2;
    
    //先设置头像
    [self displayHeadView];
    if (kScreenHeight < 568) {
        self.headLayout_top.constant = 47;
        self.nameLabelLayout_top.constant = 3;
    } else {
        
        self.headLayout_top.constant = 68;
        self.nameLabelLayout_top.constant = 15;
    }
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    self.nameLabel.text = TheCurUser.member.nickname;
    [self getUserData];
}

- (void)displayHeadView {
    [self.userHeadView DispNetorLocalImg:TheCurUser.member.avartar];
}

- (void)updateHeaderViewWith:(RelativeModel *)model {
    [self displayHeadView];
    self.dynaLabel.text = model.fbdt_num;
    self.photosLabel.text = model.pic_num;
}

- (void)getUserData {
    
#ifdef TARGET_PARENT
    NSDictionary *params = @{ @"baobaouid" : TheCurBaoBao.uid ?:@"0" };
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetRelativeList
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         //        NSDictionary *tempDic = responseObject[@"data"];
         //        _userDataModel = [[UserDataModel alloc] initWithDic:tempDic];
         //        [self updateHeaderViewWith:_userDataModel];
         
         NSDictionary *dict = responseObject[@"data"];
         NSArray *arr = dict[@"qyarr"];
         for (NSDictionary *tempDic in arr) {
             RelativeModel *model = [[RelativeModel alloc] initWithDic:tempDic];
             if ([model.uid isEqualToString:TheCurUser.member.uid.stringValue]) {
                 _jumpModel = model;
                 [self updateHeaderViewWith:model];
             }
         }
         
         //成长书开通状态传值
         NSString *czsStateStr = _jumpModel.qzb_flag;
         if (czsStateStr) {
             //成长书状态通知
             NSDictionary *czsDic = @{ @"szcState" : _jumpModel };
             [[NSNotificationCenter defaultCenter]
              postNotificationName:@"setCZSstate"
              object:nil
              userInfo:czsDic];
         }
     } errorHandler:nil
     failureHandler:nil];
    
#else
    BBQUserInfoApi *infoApi = [[BBQUserInfoApi alloc] initWithUid:TheCurUser.member.uid];
    @weakify(self)
    [infoApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        @strongify(self)
        _userDataModel = [UserDataModel modelWithDictionary:request.responseJSONObject[@"data"]];
        [self displayHeadView];
        self.dynaLabel.text = _userDataModel.bbq_fdt_num;
        self.photosLabel.text = _userDataModel.bbq_pic_num;
    } failure:nil];
#endif
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    userModifyTableViewController *umtvc = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"idSegue"]) {
        umtvc.userDataModel = _userDataModel;
        umtvc.type = BBQModifyUserInfoTypeNormal;
    } else if ([segue.identifier isEqualToString:@"mineToUserData"]) {
        UserDataShowViewController *uservc = segue.destinationViewController;
        uservc.uid = sender;
    }
}

- (void)checkUserInfo:(UITapGestureRecognizer *)recognizer {
    [self performSegueWithIdentifier:@"mineToUserData" sender:TheCurUser.member.uid];
}

//修改个人信息按钮事件
- (IBAction)EditDataBtnClick:(id)sender {
#ifdef TARGET_PARENT
    UIStoryboard *storyBoard =
    [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
    ResetUserDataTableViewController *vc = [storyBoard
                                            instantiateViewControllerWithIdentifier:@"ResetUserDataTbVcl"];
    vc.resetType = BBQResetUserDataTypeNormal;
    [self.navigationController pushViewController:vc animated:YES];
    
#elif TARGET_TEACHER
    ResetUserDataTableViewController *ResetUserDataTbVcl =
    [[UIStoryboard storyboardWithName:@"Teacher" bundle:nil]
     instantiateViewControllerWithIdentifier:@"ResetUserDataTbVcl"];
    [self.navigationController pushViewController:ResetUserDataTbVcl
                                         animated:YES];
    
#elif TARGET_MASTER
    UIStoryboard *RootStoryboard =
    [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
    UIViewController *MasterResetDataVcl = [RootStoryboard
                                            instantiateViewControllerWithIdentifier:@"ResetUserDataTbVcl"];
    [self.navigationController pushViewController:MasterResetDataVcl
                                         animated:YES];
#endif
}

@end

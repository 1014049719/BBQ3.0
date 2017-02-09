//
//  MineTableViewController.m
//  JYEX
//
//  Created by anymuse on 15/7/17.
//  Copyright (c) 2015年 广州洋基. All rights reserved.
//

#import "MineTableViewController.h"
#import "VerifyCodeViewController.h"
#import "UserDataModel.h"
#import "RelativeModel.h"
#import "BBQNewCardViewController.h"
#import "BBQAttentionViewController.h"
#import "BBQLevelViewController.h"
#import "BBQGradeResult.h"


@interface MineTableViewController ()
@property(retain, nonatomic) IBOutlet UITableView *tableview;
//成长书开通状态
@property(weak, nonatomic) IBOutlet UILabel *czsSateLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@property(weak, nonatomic) IBOutlet UILabel *leDouNumLabel;

//new标记
@property (weak, nonatomic) IBOutlet UILabel *label_new;
@property (weak, nonatomic) IBOutlet UILabel *label_dian;
@property(nonatomic,strong)BBQGradeResult *gradeResult;
//缓存
@property(strong,nonatomic)NSUserDefaults *UserDefault;

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _UserDefault=[NSUserDefaults standardUserDefaults];
    if ([_UserDefault boolForKey:@"guanzhuliebiao"]) {
        [self.label_new removeFromSuperview];
    }
    if ([_UserDefault boolForKey:@"shezhi_dian"]) {
        [self.label_dian removeFromSuperview];
    }
    
    //去掉多余分割线
    self.tableView.tableFooterView = [UIView new];
    @weakify(self)
    [[NSNotificationCenter defaultCenter]
     addObserverForName:@"setCZSstate"
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) {
         @strongify(self)
         RelativeModel *model = note.userInfo[@"szcState"];
         if ([model.qzb_flag intValue] == 1) {
             self.czsSateLabel.text = @"已购买";
         } else {
             self.czsSateLabel.text = @"未购买";
         }
         
         self.leDouNumLabel.text = model.ledou_num;
     }];
}
-(void)viewWillAppear:(BOOL)animated{
    [self setupLevelRequest];
}
#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath .row ==0) {
        if (self.gradeResult) {
            BBQLevelViewController *levelVC = [[BBQLevelViewController alloc] init];
            levelVC.title = @"我的等级";
            levelVC.gradeResult = self.gradeResult;
            levelVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:levelVC animated:YES];
        }
    }else if (indexPath.row == 2) {
        
        NSLog(@"点击了第2");
        [_UserDefault setBool:YES forKey:@"guanzhuliebiao"];
        [_label_new removeFromSuperview];
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
        BBQAttentionViewController *vc =
        [sb instantiateViewControllerWithIdentifier:@"AttentionListBoard"];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    else if (indexPath.row == 2) {
//
//        BBQNewCardViewController *BBQNewCardVcl=[[BBQNewCardViewController alloc] init];
//        BBQNewCardVcl.title = @"成长书";
//        BBQNewCardVcl.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:BBQNewCardVcl animated:YES];}
    else if (indexPath.row==3){
        
        NSLog(@"点击了第3");
        [_UserDefault setBool:YES forKey:@"shezhi_dian"];
        [_label_dian removeFromSuperview];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        return 0;
    }
    
    else
        return 44;
}
-(void)setupLevelRequest{
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetGRADE
     param:nil
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         [SVProgressHUD dismiss];
         self.gradeResult = [BBQGradeResult modelWithDictionary:responseObject[@"data"]];
         self.levelLabel.text =[NSString stringWithFormat:@"LV%@",self.gradeResult.level?:@0];
     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
         
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
     }];
}

@end

//
//  TeMineTableViewController.m
//  BBQ
//
//  Created by wth on 15/8/6.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "TeMineTableViewController.h"
#import "TeJiFenModel.h"
#import "UserDataModel.h"
#import "TeLeDouViewController.h"
#import "BBQTeacherInviteViewController.h"
#import "BBQNewCardViewController.h"

@interface TeMineTableViewController ()

@property(copy, nonatomic) NSString *jiFenNum;

@property(strong, nonatomic) NSMutableArray *dataAry;

@property(strong, nonatomic) UserDataModel *model;

//设置 红点
@property (weak, nonatomic) IBOutlet UILabel *label_dian;
//缓存
@property(strong,nonatomic)NSUserDefaults *UserDefault;

@end

@implementation TeMineTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

    _UserDefault=[NSUserDefaults standardUserDefaults];
    if ([_UserDefault boolForKey:@"shezhi_dian"]) {
        [self.label_dian removeFromSuperview];
    }
    
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation
  // bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
  self.tableView.tableFooterView = [UIView new];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self getJiFenData];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  if (indexPath.row == 1) {
    return 0;
  }

  else
    return 44;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  switch (indexPath.row) {
  case 0: {

  } break;

  case 1: {
    if (_model) {
      [self performSegueWithIdentifier:@"pushToLeDouDetail"
                                sender:_model.bbq_ld_num];
    }

  } break;

  case 2: {

  } break;
  case 3: {
      BBQTeacherInviteViewController *invitVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"TeacherInviteViewController"];
      [self.navigationController pushViewController:invitVC animated:YES];
      
  } break;
  case 4: {

  } break;

  /**
   * 设置
   */
  case 6: {

      [_UserDefault setBool:YES forKey:@"shezhi_dian"];
      [_label_dian removeFromSuperview];
      
    UIStoryboard *SB =
        [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    UIViewController *vc =
        [SB instantiateViewControllerWithIdentifier:@"settingup"];
    [self.navigationController pushViewController:vc animated:YES];
  } break;

  /**
   * 反馈
   */
  case 7: {

    UIStoryboard *SB =
        [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    UIViewController *vc =
        [SB instantiateViewControllerWithIdentifier:@"postUserProblem"];
    [self.navigationController pushViewController:vc animated:YES];
  } break;
      case 8: {
          
          BBQNewCardViewController *BBQNewCardVcl=[[BBQNewCardViewController alloc] init];
          BBQNewCardVcl.title = @"成长书";
          BBQNewCardVcl.hidesBottomBarWhenPushed=YES;
          [self.navigationController pushViewController:BBQNewCardVcl animated:YES];
      } break;
  default:
    break;
  }
}

- (void)getJiFenData {
  NSDictionary *params = @{ @"uid" : TheCurUser.member.uid };
  [BBQHTTPRequest
       queryWithType:BBQHTTPRequestTypeGetUserData
               param:params
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        dispatch_async_on_main_queue(^{
          _model = [UserDataModel modelWithJSON:responseObject[@"data"]];
          self.jiFenNumLabel.text = _model.bbq_jifen_num;
          self.leDouNumLabel.text = _model.bbq_ld_num;
        });

      } errorHandler:nil
      failureHandler:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"pushToLeDouDetail"]) {
    TeLeDouViewController *vc = segue.destinationViewController;
    vc.bbq_ld_num = _model.bbq_ld_num;
  }
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

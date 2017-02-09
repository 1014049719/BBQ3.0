//
//  setLimitTableViewController.m
//  BBQ
//
//  Created by slovelys on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "setLimitTableViewController.h"
#import "RelationshipViewController.h"
#import "LimitsViewController.h"
#import "NSString+Common.h"

@interface setLimitTableViewController ()
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *relationshipLabel;
@property(weak, nonatomic) IBOutlet UILabel *qxLabel;
@property(weak, nonatomic) IBOutlet UILabel *myInfoLabel;

@end

@implementation setLimitTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.tableFooterView = [UIView new];

  self.nameLabel.text = self.relativeModel.userName;
  if (![self.relativeModel.gxid isEqualToString:@"100"]) {
      self.relationshipLabel.text = [NSString relationshipWithID:self.relativeModel.gxid.numberValue gxname:self.relativeModel.gxName];
  } else {
    self.relationshipLabel.text = self.relativeModel.gxName;
  }
  self.qxLabel.text = [self vipLabelText:[self.relativeModel.qx intValue]];
}

/// 权限处理
- (NSString *)vipLabelText:(int)qx {
  NSString *string = @"";
  switch (qx) {
  case 1: {
    string = @"圈主";
  } break;
  case 2: {
    string = @"管理员";
  } break;
  case 3: {
    string = @"非管理员";
  } break;
  default:
    break;
  }
  return string;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"SetLimitRelationship"]) {
    RelationshipViewController *rsvc = segue.destinationViewController;

    rsvc.relationshipCallBack = ^(RelationshipModel *model) {
      self.relationshipLabel.text = model.relaName;
      self.relativeModel.gxName = model.relaName;
      self.relativeModel.gxid = [NSString
          stringWithFormat:@"%d", [model.relationshipTag intValue] - 200];

    };
  } else if ([segue.identifier isEqualToString:@"SetLimitQxSegue"]) {
    LimitsViewController *vc = segue.destinationViewController;
    vc.relativeModel = self.relativeModel;
    vc.block = ^(int gx) {
      self.relativeModel.qx = [NSString stringWithFormat:@"%d", gx];
      self.qxLabel.text = [self vipLabelText:gx];
    };
  }
}

@end

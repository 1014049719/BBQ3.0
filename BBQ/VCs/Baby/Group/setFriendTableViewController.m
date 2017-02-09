//
//  setFriendTableViewController.m
//  BBQ
//
//  Created by wth on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "setFriendTableViewController.h"
#import "RelationshipViewController.h"
#import "LimitsViewController.h"
#import "NSString+Common.h"

@interface setFriendTableViewController () <UIAlertViewDelegate>

@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *relationshipLabel;
@property(weak, nonatomic) IBOutlet UILabel *qxLabel;
/// 接收返回的与宝宝关系model
@property(strong, nonatomic) RelationshipModel *relationshipModel;

@property(assign, nonatomic) int qx;

@property(assign, nonatomic) int gxid;

@end

@implementation setFriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation
    // bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.nameLabel.text = self.model.nickName;
    NSString *gx =
    [NSString relationshipWithID:self.model.gxid.numberValue gxname:self.model.gxName];
    self.relationshipLabel.text = gx;
    NSString *qxString = @"";
    switch (self.model.qx.integerValue) {
        case 1: {
            qxString = @"圈主";
        } break;
        case 2: {
            qxString = @"管理员";
        } break;
        case 3: {
            qxString = @"非管理员";
        } break;
        default:
            break;
    }
    self.qxLabel.text = qxString;
    
    _qx = [self.model.qx intValue];
    _gxid = [self.model.gxid intValue];
}

//删除好友
- (IBAction)deleteFriendBtnClick:(id)sender {
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:@"确定删除该用户？"
                               message:nil
                              delegate:self
                     cancelButtonTitle:@"取消"
                     otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1: {
            [self deleteFriend];
        } break;
            
        default:
            break;
    }
}

//保存
- (IBAction)SaveBtnClick:(id)sender {
    
    [self updateFriendData];
}

/// 删除亲友
- (void)deleteFriend {
    NSDictionary *params = @{
                             @"baobaouid" : TheCurBaoBao.uid,
                             @"uid" : self.model.uid
                             };
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeDeleteFriend
                            param:params
                   successHandler:^(AFHTTPRequestOperation *operation,
                                    NSDictionary *responseObject, bool apiSuccess) {
                       NSString *message = @"删除成功";
                       [SVProgressHUD showSuccessWithStatus:message];
                       [[NSNotificationCenter defaultCenter]
                        postNotificationName:kSetNeedsRefreshEntireDataNotification
                        object:nil
                        userInfo:@{
                                   @"type" : @(BBQRefreshNotificationTypeAll)
                                   }];
                       dispatch_after(
                                      dispatch_time(DISPATCH_TIME_NOW,
                                                    (int64_t)(HUD_DURATION(message) * NSEC_PER_SEC)),
                                      dispatch_get_main_queue(), ^{
                                          
                                          [self.navigationController popViewControllerAnimated:YES];
                                      });
                   }
                     errorHandler:^(NSDictionary *responseObject) {
                         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                     }
                   failureHandler:nil];
}

/// 修改亲友信息
- (void)updateFriendData {
    NSDictionary *params = [NSDictionary dictionary];
    if ([self.relationshipModel.relationshipTag intValue] == 300) {
        params = @{
                   @"baobaouid" : TheCurBaoBao.uid,
                   @"uid" : self.model.uid,
                   @"gxid" : @100,
                   @"gxname" : self.relationshipModel.relaName,
                   @"nickname" : self.nameLabel.text,
                   @"qx" : @(_qx)
                   };
    } else {
        if (self.relationshipModel) {
            _gxid = [self.relationshipModel.relationshipTag intValue] - 200;
        }
        params = @{
                   @"baobaouid" : TheCurBaoBao.uid,
                   @"uid" : self.model.uid,
                   @"gxid" : @(_gxid),
                   @"gxname" : self.relationshipLabel.text,
                   @"nickname" : self.nameLabel.text,
                   @"qx" : @(_qx)
                   };
    }
    
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeUpdateFriendData
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         NSString *message = @"修改成功";
         [SVProgressHUD showSuccessWithStatus:message];
         dispatch_after(
                        dispatch_time(DISPATCH_TIME_NOW,
                                      (int64_t)(HUD_DURATION(message) * NSEC_PER_SEC)),
                        dispatch_get_main_queue(), ^{
                            [[NSNotificationCenter defaultCenter]
                             postNotificationName:kSetNeedsRefreshEntireDataNotification
                             object:nil
                             userInfo:@{
                                        @"type" : @(BBQRefreshNotificationTypeAll)
                                        }];
                            //回传更改过信息
                            if ([self.relationshipModel.relationshipTag intValue] == 300) {
                                self.model.gxid = @"100";
                                self.model.gxName = self.relationshipModel.relaName;
                            } else {
                                self.model.gxid = [NSString stringWithFormat:@"%d", _gxid];
                                self.model.gxName = self.relationshipLabel.text;
                            }
                            self.model.qx = [NSString stringWithFormat:@"%d", _qx];
                            
                            if (self.block) {
                                self.block(self.model.gxName);
                            }
                            
                            //通知亲友团更新
                            
                            [self.navigationController popViewControllerAnimated:YES];
                        });
     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
     } failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:[error description]];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView
//numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView
 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView
 dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#>
 forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath
 *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath]
 withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the
 array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath
 *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath
 *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setFriendToRelationship"]) {
        RelationshipViewController *vc = segue.destinationViewController;
        
        vc.relationshipCallBack = ^(RelationshipModel *model) {
            _relationshipLabel.text = model.relaName;
            _relationshipModel = model;
        };
        vc.model = _relationshipModel;
    } else if ([segue.identifier isEqualToString:@"setFriendToSetLimit"]) {
        LimitsViewController *vc = segue.destinationViewController;
        vc.block = ^(int qx) {
            _qx = qx;
            _qxLabel.text = [self dealQx:qx];
            
        };
    }
}

- (NSString *)dealQx:(int)qx {
    NSString *string = @"";
    switch (qx) {
        case 2:
            string = @"管理员";
            break;
            
        case 3:
            string = @"非管理员";
            break;
            
        default:
            break;
    }
    return string;
}

@end

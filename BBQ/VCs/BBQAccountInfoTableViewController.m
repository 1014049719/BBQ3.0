//
//  BBQAccountInfoTableViewController.m
//  BBQ
//
//  Created by slovelys on 15/11/25.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQAccountInfoTableViewController.h"
#import "BBQAccountInfoCell.h"
#import "BBQReleaseBindingApi.h"
#import <BlocksKit+UIKit.h>
#import "BBQBindingPhoneViewController.h"
#import "BBQAutoCreateAccountLoginApi.h"
#import "ResetPassKeyTableViewController.h"
#import "BBQLoginManager.h"
#import "UMSocial.h"

@interface BBQAccountInfoTableViewController ()

@property (strong, nonatomic) NSArray *leftnameAry;
@property (strong, nonatomic) BBQLoginManager *login;

@end

@implementation BBQAccountInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _login = [BBQLoginManager sharedManager];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
//    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self.tableView setTableFooterView:view];
    self.title = @"账号信息";
    _leftnameAry = @[ @[@"手机号", @"登陆密码"], @[@"微信", @"QQ"] ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _leftnameAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_leftnameAry objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBQAccountInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountInfoCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftLabel.text = _leftnameAry[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                if (TheCurUser.phone_bind) {
                    cell.rightLabel.text = [NSString stringWithFormat:@"已绑定%@", TheCurUser.member.username];
                } else {
                    cell.rightLabel.text = @"未绑定";
                }
                
                break;
                
            case 1:
                cell.rightLabel.text = @"******";
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                if (TheCurUser.wxbind && TheCurUser.isbind) {
                    cell.rightLabel.text = @"已绑定";
                } else {
                    cell.rightLabel.text = @"未绑定";
                }
                break;
                
            case 1:
                if (TheCurUser.qqbind && TheCurUser.isbind) {
                    cell.rightLabel.text = @"已绑定";
                } else {
                    cell.rightLabel.text = @"未绑定";
                }
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BBQAccountInfoCell *cell = (BBQAccountInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *rightTitle = cell.rightLabel.text;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
                // 手机号
            case 0:
                [self bindingMobileWithType:BBQBindingPhoneTypeModify];
//                if ([rightTitle isEqualToString:@"已绑定"]) {
//                    [self bindingMobileWithType:BBQBindingPhoneTypeModify];
//                } else {
//                    [self bindingMobileWithType:BBQBindingPhoneTypeNormal];
//                }
                break;
                // 登录密码
            case 1:
                if (!TheCurUser.phone_bind) {
                    [SVProgressHUD showInfoWithStatus:@"请先绑定手机"];
                } else {
                    [self setPassword];
                }
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                if ([rightTitle isEqualToString:@"已绑定"]) {
                    
                    [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"解除微信绑定后，你将不能用微信登录宝宝圈了" cancelButtonTitle:@"取消" otherButtonTitles:@[@"解除绑定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                        if (buttonIndex == 1) {
                            [self releaseBindingWithType:BBQLoginTypeWeChat];
                        }
                    }];
                } else {
                    [self bindingWX];
                }
                break;
                
            case 1:
                if ([rightTitle isEqualToString:@"已绑定"]) {
                    
                    [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"解除QQ绑定后，你将不能用QQ登录宝宝圈了" cancelButtonTitle:@"取消" otherButtonTitles:@[@"解除绑定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                        if (buttonIndex == 1) {
                            [self releaseBindingWithType:BBQLoginTypeQQ];;
                        }
                    }];
                } else {
//                    if (!TheCurUser.phone_bind) {
//                        [SVProgressHUD showInfoWithStatus:@"请先绑定手机"];
//                        return;
//                    }
                    [self bindingQQ];
                }
                break;
                
            default:
                break;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 50)];
    label.font = [UIFont systemFontOfSize:13];
    [view addSubview:label];
    if (section == 0) {
        label.text = @"绑定后可以使用手机号+密码登陆宝宝圈";
        
    } else if (section == 1) {
        label.text = @"绑定后可以使用第三方账号登录宝宝圈";
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

- (void)setPassword {
    UIStoryboard *storyBoard =
    [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    ResetPassKeyTableViewController *ResetPassVcl =
    [storyBoard instantiateViewControllerWithIdentifier:@"ResetPassVcl"];
    [self.navigationController pushViewController:ResetPassVcl animated:YES];
}

- (void)releaseBindingWithType:(int)type {
    [SVProgressHUD showWithStatus:@"请稍候"];
    BBQReleaseBindingApi *api = [[BBQReleaseBindingApi alloc] initWithAuthtype:type];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject[@"res"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"解除绑定成功"];
            if (type == BBQLoginTypeWeChat) {
                TheCurUser.wxbind = NO;
            } else if (type == BBQLoginTypeQQ) {
                TheCurUser.qqbind = NO;
            }
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"解除绑定失败"];
    }];
}

- (void)bindingMobileWithType:(BBQBindingPhoneType)type{
    BBQBindingPhoneViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"bindingVC"];
    vc.bdtype = type;
    vc.blcok = ^(void) {
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)bindingWX {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            [SVProgressHUD showWithStatus:@"请稍候"];
            [self setLoginManagerWithSocialAccountEntity:snsAccount];
            [BBQLoginManager loginWithUsername:nil password:nil loginType:BBQLoginTypeWeChat success:^(YTKBaseRequest *request) {
                NSDictionary *dataDic = request.responseJSONObject[@"data"];
                if ([dataDic[@"isbind"] boolValue]) {
                    [SVProgressHUD showSuccessWithStatus:@"微信登录绑定成功"];
                    [self.tableView reloadData];
                }
            } failure:^(YTKBaseRequest *request) {
                if (request.responseStatusCode == 200) {
                    [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
                } else {
                    [SVProgressHUD showErrorWithStatus:request.requestOperation.error.localizedDescription];
                }
            }];
        }
    });
}

- (void)bindingQQ {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){

        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            [SVProgressHUD showWithStatus:@"请稍候"];
            [self setLoginManagerWithSocialAccountEntity:snsAccount];
            [BBQLoginManager loginWithUsername:nil password:nil loginType:BBQLoginTypeQQ success:^(YTKBaseRequest *request) {
                [SVProgressHUD showSuccessWithStatus:@"QQ登录绑定成功"];
                [self.tableView reloadData];
            } failure:^(YTKBaseRequest *request) {
                if (request.responseStatusCode == 200) {
                    [SVProgressHUD showErrorWithStatus:request.responseJSONObject[@"msg"]];
                } else {
                    [SVProgressHUD showErrorWithStatus:request.requestOperation.error.localizedDescription];
                }
            }];
        }
    });
}

- (void)setLoginManagerWithSocialAccountEntity:(UMSocialAccountEntity *)entity {
    BBQLoginManager *manager = [BBQLoginManager sharedManager];
    manager.openid = entity.openId;
    manager.nickname = entity.userName;
    manager.avartarurl = entity.iconURL;
    manager.access_token = entity.accessToken;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

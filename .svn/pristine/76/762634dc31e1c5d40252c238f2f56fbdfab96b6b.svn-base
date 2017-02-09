////
////  SendToViewController.m
////  BBQ
////
////  Created by 朱琨 on 15/8/12.
////  Copyright © 2015年 bbq. All rights reserved.
////
//
//#import "SendToViewController.h"
//#import "LeftChooseCell.h"
//#import "RightChooseCell.h"
//#import "BBQDynamicEditViewController.h"
//#import "RightChooseModel.h"
//#import "BBQSchoolDataModel.h"
//#import "AppMacro.h"
//#import "BBQCalendarViewController.h"
//#import "MasterTabBarViewController.h"
//#import "BBQDynamicViewController.h"
//#import <UITableView+FDTemplateLayoutCell.h>
//
//@interface SendToViewController () <UITableViewDataSource, UITableViewDelegate>
//
//@property(weak, nonatomic) IBOutlet UITableView *leftTableView;
//@property(weak, nonatomic) IBOutlet UITableView *rightTableView;
//@property(strong, nonatomic) NSMutableArray *leftDataSource;
//@property(strong, nonatomic) NSMutableArray *rightDataSource;
//@property(strong, nonatomic) BBQClassDataModel *leftModel;
//@property(assign, nonatomic) BOOL isRequest;
//@property(strong, nonatomic) YYMemoryCache *memoryCache;
//@end
//
//@implementation SendToViewController {
//
//  RightChooseModel *_rightmodel;
//}
//#pragma mark - Life Cycle
//- (void)viewDidLoad {
//  [super viewDidLoad];
//  self.leftDataSource = [NSMutableArray array];
//  self.rightDataSource = [NSMutableArray array];
//
//  self.leftTableView.dataSource = self;
//  self.leftTableView.delegate = self;
//  self.rightTableView.dataSource = self;
//  self.rightTableView.delegate = self;
//
//  self.leftTableView.tableFooterView = [UIView new];
//  self.rightTableView.tableFooterView = [UIView new];
//
//  CGRect rectFrame = self.rightTableView.frame;
//  rectFrame.size.width = 0;
//  self.rightTableView.frame = rectFrame;
//
//  if (_memoryCache == nil) {
//    _memoryCache = [YYMemoryCache new];
//  }
//
//  _isRequest = NO;
//  [self getClassList];
//}
//
//#pragma mark - TableView DataSource
//- (NSInteger)tableView:(UITableView *)tableView
// numberOfRowsInSection:(NSInteger)section {
//  if (tableView == self.leftTableView) {
//
//    return self.leftDataSource.count;
//  } else {
//
//    return self.rightDataSource.count;
//  }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//  if (tableView == self.leftTableView) {
//
//    LeftChooseCell *cell =
//        [tableView dequeueReusableCellWithIdentifier:@"LeftCell"
//                                        forIndexPath:indexPath];
//    BBQClassDataModel *model = self.leftDataSource[indexPath.row];
//    cell.classLabel.text = model.classname;
//
//    //设置第二个选中
//    if (![_StyleString isEqualToString:@"成长报告"]) {
//      if (indexPath.row == 1) {
//
//        [tableView selectRowAtIndexPath:indexPath
//                               animated:YES
//                         scrollPosition:UITableViewScrollPositionNone];
//      }
//    } else if ([_StyleString isEqualToString:@"成长报告"]) {
//      if (indexPath.row == 0) {
//
//        [tableView selectRowAtIndexPath:indexPath
//                               animated:YES
//                         scrollPosition:UITableViewScrollPositionNone];
//      }
//    } else if (TheCurUser.member.groupkey.integerValue == 2) {
//      if (indexPath.row == 1) {
//        cell.selected = YES;
//        [tableView selectRowAtIndexPath:indexPath
//                               animated:YES
//                         scrollPosition:UITableViewScrollPositionNone];
//      }
//    }
//
//    return cell;
//  } else {
//
//    RightChooseCell *cell =
//        [tableView dequeueReusableCellWithIdentifier:@"RightCell"
//                                        forIndexPath:indexPath];
//    RightChooseModel *model = self.rightDataSource[indexPath.row];
//
//    if ([self.StyleString isEqualToString:@"成长报告"]) {
//        [cell.headImageView setImageWithURL:[NSURL URLWithString:model.avartar] placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionRefreshImageCache completion:nil];
//    } else {
//
//      if (indexPath.row == 0) {
//        cell.headImageView.image = [UIImage imageNamed:@"classItem"];
//      } else {
//          [cell.headImageView setImageWithURL:[NSURL URLWithString:model.avartar] placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionRefreshImageCache completion:nil];
//      }
//    }
//    cell.nameLabel.text = model.userName;
//    return cell;
//  }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView
//    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//  if (tableView == self.leftTableView) {
//    return [tableView fd_heightForCellWithIdentifier:@"LeftCell"
//                                    cacheByIndexPath:indexPath
//                                       configuration:^(LeftChooseCell *cell) {
//                                         BBQClassDataModel *model =
//                                             self.leftDataSource[indexPath.row];
//                                         cell.classLabel.text = model.classname;
//                                       }];
//  }
//  return 60;
//}
//
//#pragma mark - TableView Delegate
//
//- (void)tableView:(UITableView *)tableView
//    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//  if (tableView == self.leftTableView) {
//    LeftChooseCell *cell =
//        (LeftChooseCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor whiteColor];
//
//    self.leftModel = [self.leftDataSource objectAtIndex:indexPath.row];
//
//    [self.rightDataSource removeAllObjects];
//    BBQClassDataModel *model = self.leftDataSource[indexPath.row];
//    RightChooseModel *model2 = [[RightChooseModel alloc] init];
//    model2.userName = model.classname;
//    model2.uid = model.classid.stringValue;
//
//    if ([self.StyleString isEqualToString:@"成长报告"]) {
//      if ([_memoryCache objectForKey:model.classid]) {
//        [self.rightDataSource removeAllObjects];
//        [self.rightDataSource
//            addObjectsFromArray:(NSArray *)
//                                    [_memoryCache objectForKey:model.classid]];
//        [self.rightTableView reloadData];
//        return;
//      }
//      [self getBaoBaoListWithClassID:model.classid.stringValue];
//    } else {
//      if ([_memoryCache objectForKey:model.classid]) {
//        [self.rightDataSource removeAllObjects];
//        [self.rightDataSource addObject:model2];
//        [self.rightDataSource
//            addObjectsFromArray:(NSArray *)
//                                    [_memoryCache objectForKey:model.classid]];
//        [self.rightTableView reloadData];
//        return;
//      }
//      [self.rightDataSource addObject:model2];
//      if (indexPath.row != 0) { //取宝宝数据
//        [self getBaoBaoListWithClassID:model.classid.stringValue];
//      } else {
//        [self.rightTableView reloadData];
//      }
//    }
//  } else {
//
//    RightChooseCell *cell =
//        (RightChooseCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.chooseImageView.highlighted = YES;
//
//    RightChooseModel *model3 =
//        [self.rightDataSource objectAtIndex:indexPath.row];
//
//    if (self.nCallMode == 1) {
//      self.block(model3.dtype, self.leftModel.classid.stringValue, model3.uid,
//                 model3.userName);
//      return;
//    }
//
//#ifdef TARGET_TEACHER
//
//    //跳转到发表
//    UIStoryboard *storyBoard =
//        [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
//    DynamicCreateTableViewController *editdynaVcl =
//        [storyBoard instantiateViewControllerWithIdentifier:@"editdyna"];
//
//    editdynaVcl.nCallMode = 1;
//    editdynaVcl.itemType = self.itemType;
//    editdynaVcl.dtype = model3.dtype;
//    editdynaVcl.strName = model3.userName;
//
//    BBQSchoolDataModel *model = TheCurUser.schooldata.firstObject;
//    editdynaVcl.schooluid = model.schoolid.stringValue;
//
//    if (model3.dtype == DYNA_TYPE_PERSON) {
//      editdynaVcl.baobaouid = model3.uid;
//      editdynaVcl.classuid = self.leftModel.classid.stringValue;
//    } else if (model3.dtype == DYNA_TYPE_CLASS) {
//      editdynaVcl.classuid = model3.uid;
//    }
//    [self.navigationController pushViewController:editdynaVcl animated:NO];
//
//    return;
//
//#elif TARGET_MASTER
//
//    if ([self.StyleString isEqualToString:@"成长报告"]) {
//        BBQCalendarViewController *vc = [BBQCalendarViewController new];
//      vc.BaobaoId = model3.uid;
//      [self.navigationController pushViewController:vc animated:YES];
//
//    } else if ([self.StyleString isEqualToString:@"拍照"]) {
//
//      //跳转到发表
//      UIStoryboard *storyBoard =
//          [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
//      DynamicCreateTableViewController *editdynaVcl =
//          [storyBoard instantiateViewControllerWithIdentifier:@"editdyna"];
//
//      editdynaVcl.nCallMode = 1;
//      editdynaVcl.itemType = self.itemType;
//      editdynaVcl.dtype = model3.dtype;
//      editdynaVcl.strName = model3.userName;
//
//      editdynaVcl.schooluid = TheCurUser.curSchool.schoolid;
//
//      if (model3.dtype == DYNA_TYPE_PERSON) {
//        editdynaVcl.baobaouid = model3.uid;
//        editdynaVcl.classuid = self.leftModel.classid;
//      } else if (model3.dtype == DYNA_TYPE_CLASS) {
//        editdynaVcl.classuid = model3.uid;
//      }
//      [self.navigationController pushViewController:editdynaVcl animated:NO];
//
//    } else if ([self.StyleString isEqualToString:@"班级动态"]) {
//
//      NSString *baobaouid = @"0";
//      NSString *classuid = @"0";
//
//      if (model3.dtype == DYNA_TYPE_PERSON) {
//        baobaouid = model3.uid;
//        classuid = self.leftModel.classid;
//      } else if (model3.dtype == DYNA_TYPE_CLASS) {
//        classuid = model3.uid;
//      }
//
//      UIStoryboard *storyBoard =
//          [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
//
//      BBQDynamicViewController *masterDynamic =
//          [storyBoard instantiateViewControllerWithIdentifier:@"DynamicVC"];
//      masterDynamic.needsRefreshEntireData = YES;
//
//      masterDynamic.dynamicType = model3.dtype;
//      masterDynamic.baobaouid = baobaouid;
//      masterDynamic.classuid = classuid;
//      masterDynamic.schoolid = TheCurUser.curSchool.schoolid;
//      masterDynamic.realname = model3.userName;
//
//      [self.navigationController pushViewController:masterDynamic animated:YES];
//
//    } else if ([self.StyleString isEqualToString:@"选择动态"]) {
//
//      NSString *baobaouid = @"0";
//      NSString *classuid = @"0";
//
//      if (model3.dtype == DYNA_TYPE_PERSON) {
//        baobaouid = model3.uid;
//        classuid = self.leftModel.classid;
//      } else if (model3.dtype == DYNA_TYPE_CLASS) {
//        classuid = model3.uid;
//      }
//
//      NSDictionary *dic = @{
//        @"dtype" : [NSNumber numberWithInt:model3.dtype],
//        @"realname" : model3.userName,
//        @"baobaouid" : baobaouid,
//        @"classuid" : classuid,
//        @"schoolid" : TheCurUser.curSchool.schoolid
//      };
//      [[NSNotificationCenter defaultCenter]
//          postNotificationName:kMasterSwitchDynaNotificaton
//                        object:nil
//                      userInfo:dic];
//
//      [self.navigationController popViewControllerAnimated:YES];
//
//    }
//
//    else {
//
//      //返回动态
//      [self.navigationController popViewControllerAnimated:YES];
//    }
//#endif
//  }
//}
//
//- (void)tableView:(UITableView *)tableView
//    didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//  if (tableView == self.leftTableView) {
//    LeftChooseCell *cell =
//        (LeftChooseCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
//  } else {
//    RightChooseCell *cell =
//        (RightChooseCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.chooseImageView.highlighted = NO;
//  }
//}
//
//- (void)getClassList {
//
//  //第一个是学校
//  BBQClassDataModel *firstModel = [[BBQClassDataModel alloc] init];
//  BBQSchoolDataModel *schoolModel = TheCurUser.schooldata[0];
//  firstModel.classname = schoolModel.schoolname;
//  firstModel.classid = schoolModel.schoolid;
//
//  if (![self.StyleString isEqualToString:@"成长报告"]) {
//    [self.leftDataSource addObject:firstModel];
//  }
//
//  if (TheCurUser.member.groupkey.integerValue == 2) { //老师身份
//    BBQClassDataModel *teClassModel = TheCurUser.classdata[0];
//    [self.leftDataSource addObject:teClassModel];
//    [self.leftTableView reloadData];
//    RightChooseModel *rModel = [[RightChooseModel alloc] init];
//    rModel.uid = teClassModel.classid.stringValue;
//    rModel.dtype = DYNA_TYPE_CLASS;
//    rModel.userName = teClassModel.classname;
//    [self.rightDataSource addObject:rModel];
//    [self getBaoBaoListWithClassID:teClassModel.classid.stringValue];
//    return;
//  }
//  BBQSchoolDataModel *model = TheCurUser.schooldata[0];
//    NSDictionary *params = @{ @"schoolid" : model.schoolid ?:@"0" };
//  [BBQHTTPRequest
//       queryWithType:BBQHTTPRequestTypeGetClassList
//               param:params
//      successHandler:^(AFHTTPRequestOperation *operation,
//                       NSDictionary *responseObject, bool apiSuccess) {
//        dispatch_async(
//            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//              NSArray *tempAry = responseObject[@"data"][@"arr"];
//              int i = 0;
//              RightChooseModel *model2 = [[RightChooseModel alloc] init];
//
//              for (NSDictionary *tempDic in tempAry) {
//                BBQClassDataModel *model = [BBQClassDataModel modelWithDictionary:tempDic];
//                self.leftModel = model;
//                if (i == 0) {
//                  model2.userName = model.classname;
//                  model2.uid = model.classid.stringValue;
//                }
//                if (TheCurUser.member.groupkey.integerValue == 3) { //园长身份
//                  [self.leftDataSource addObject:model];
//                }
//
//                if ([_StyleString isEqualToString:@"成长报告"]) {
//                  if (i == 0) {
//                    [self getBaoBaoListWithClassID:model.classid.stringValue];
//                  }
//                } else {
//                  if (i == 0) {
//                    [_rightDataSource addObject:model2];
//                    [self getBaoBaoListWithClassID:model.classid.stringValue];
//                  }
//                }
//                i++;
//              }
//
//                          if (TheCurUser.member.groupkey.integerValue == 2) {
//                              BBQClassDataModel *teClassModel =
//                              TheCurUser.classdata[0];
////                              teClassModel.dtype = DYNA_TYPE_CLASS;
//                              [self.leftDataSource addObject:teClassModel];
//              
//              
//                          }
//              dispatch_async(dispatch_get_main_queue(), ^{
//                [self.leftTableView reloadData];
//              });
//            });
//      } errorHandler:nil
//      failureHandler:nil];
//}
//
//- (void)getBaoBaoListWithClassID:(NSString *)classid {
//  if (_isRequest == YES) {
//    return;
//  }
//  NSDictionary *params = @{ @"classid" : classid };
//  _isRequest = YES;
//  [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGetBaoBaoList
//      param:params
//      successHandler:^(AFHTTPRequestOperation *operation,
//                       NSDictionary *responseObject, bool apiSuccess) {
//
//        _isRequest = NO;
//        [SVProgressHUD dismiss];
//        dispatch_async(
//            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//              NSArray *tempAry = responseObject[@"data"][@"arr"];
//              NSMutableArray *muAry = [NSMutableArray arrayWithCapacity:0];
//              for (NSDictionary *tempDic in tempAry) {
//                RightChooseModel *model =
//                    [[RightChooseModel alloc] initWithDic:tempDic];
//                model.dtype = DYNA_TYPE_PERSON;
//                [self.rightDataSource addObject:model];
//                [muAry addObject:model];
//              }
//              [_memoryCache setObject:muAry forKey:classid];
//              dispatch_async(dispatch_get_main_queue(), ^{
//                [self.rightTableView reloadData];
//              });
//            });
//      }
//      errorHandler:^(NSDictionary *responseObject) {
//
//        _isRequest = NO;
//        [SVProgressHUD dismiss];
//        [self.rightTableView reloadData];
//      }
//      failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//        _isRequest = NO;
//      }];
//}
//
//#pragma mark - Action
//- (void)goToEditDynamic:(Dynamic *)dynamic {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Dynamic" bundle:nil];
//    BBQDynamicEditViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DynamicEditVC"];
//    vc.dynamic = dynamic;
//    [self.navigationController
//     pushViewController:vc
//     animated:YES];
//}
//
//
//@end

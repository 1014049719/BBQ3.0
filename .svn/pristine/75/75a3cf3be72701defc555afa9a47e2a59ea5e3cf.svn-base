//
//  BBQDualListViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/12/28.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDualListViewController.h"
#import "BBQGetClassListApi.h"
#import "BBQDualListPrimaryCell.h"
#import "BBQDualListSecondaryCell.h"
#import "BBQGetBaoBaoListApi.h"
#import "BBQCalendarViewController.h"
#import "QBImagePickerController.h"
#import "BBQDynamicEditViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface BBQDualListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *primaryTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondaryTableView;
@property (nonatomic, strong) NSMutableArray * primaryDataSource;
@property (nonatomic, strong) NSMutableArray * secondaryDataSource;
@property (assign, nonatomic) NSInteger primarySelectedIndex;
@property (assign, nonatomic) NSInteger secondarySelectedIndex;

@end

@implementation BBQDualListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _primaryTableView.tableFooterView = [UIView new];
    _secondaryTableView.tableFooterView = [UIView new];
    switch (self.dualListType) {
        case BBQDualListTypeDailyReport: {
            [self.primaryDataSource addObjectsFromArray:TheCurUser.classdata];
            self.navigationItem.title = @"选择宝宝";
            if ([self validateDatasource:self.primaryDataSource]) {
                [self downloadBaoBaoDataWtihClass:self.primaryDataSource[0]];
            }
            break;
        }
        case BBQDualListTypePublishDynamic:
        case BBQDualListTypeCheckDynamic: {
            if (self.dualListType == BBQDualListTypePublishDynamic) {
                self.navigationItem.title = @"发表到";
            } else {
                self.navigationItem.title = @"选择动态";
            }
            [self.primaryDataSource addObjectsFromArray:TheCurUser.schooldata];
            [self.primaryDataSource addObjectsFromArray:TheCurUser.classdata];
            if ([self validateDatasource:self.primaryDataSource]) {
                self.primarySelectedIndex = 1;
                if (self.dynamic) {
                    switch ((BBQDynamicGroupType)self.dynamic.dtype.integerValue) {
                        case BBQDynamicGroupTypeBaby:
                        case BBQDynamicGroupTypeClass: {
                            if (self.dynamic.dtype.integerValue == BBQDynamicGroupTypeClass) {
                                self.secondarySelectedIndex = 0;
                            }
                            [self.primaryDataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                if ([obj isKindOfClass:[BBQClassDataModel class]]) {
                                    BBQClassDataModel *model = obj;
                                    if ([self.dynamic.classuid isEqualToNumber:model.classid]) {
                                        *stop = YES;
                                        self.primarySelectedIndex = idx;
                                    }
                                }
                            }];
                            break;
                        }
                        case BBQDynamicGroupTypeSchool: {
                            self.primarySelectedIndex = 0;
                            self.secondarySelectedIndex = -1;
                            break;
                        }
                    }
                } else {
                    self.secondarySelectedIndex = -1;
                }
                if (self.primarySelectedIndex != 0) {
                    [self downloadBaoBaoDataWtihClass:self.primaryDataSource[self.primarySelectedIndex]];
                }
            }
            break;
        }
    }
    
    [self.primaryTableView reloadData];
}

#pragma mark - UITabelView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView == _primaryTableView ? _primaryDataSource.count : _secondaryDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == _primaryTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:kDualListPrimaryCellIdentifier forIndexPath:indexPath];
        ((BBQDualListPrimaryCell *)cell).model = self.primaryDataSource[indexPath.row];
        if (indexPath.row == self.primarySelectedIndex) {
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    } else if (tableView == _secondaryTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:kDualListSecondaryCellIdentifier forIndexPath:indexPath];
        ((BBQDualListSecondaryCell *)cell).model = self.secondaryDataSource[indexPath.row];
        if (indexPath.row == self.secondarySelectedIndex) {
            self.secondarySelectedIndex = -1;
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (tableView == self.primaryTableView) {
        height = [tableView fd_heightForCellWithIdentifier:kDualListPrimaryCellIdentifier cacheByIndexPath:indexPath configuration:^(BBQDualListPrimaryCell *cell) {
            cell.model = self.primaryDataSource[indexPath.row];
        }];
    } else {
        height = [tableView fd_heightForCellWithIdentifier:kDualListSecondaryCellIdentifier cacheByIndexPath:indexPath configuration:^(BBQDualListSecondaryCell *cell) {
            cell.model = self.secondaryDataSource[indexPath.row];
        }];
    }
    return MAX(50, height);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    id model = [cell valueForKey:@"model"];
    switch (self.dualListType) {
        case BBQDualListTypeDailyReport: {
            if (tableView == self.primaryTableView) {
                [self downloadBaoBaoDataWtihClass:model];
            } else {
                BBQCalendarViewController *vc = [[BBQCalendarViewController alloc] initWithBaby:model];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
        case BBQDualListTypePublishDynamic:
        case BBQDualListTypeCheckDynamic: {
            if (tableView == self.primaryTableView && [model isKindOfClass:[BBQClassDataModel class]]) {
                [self downloadBaoBaoDataWtihClass:model];
            } else {
                if (tableView == self.primaryTableView) {
                    [self.secondaryDataSource removeAllObjects];
                    [self.secondaryTableView reloadData];
                }
                TheCurUser.curSelection = model;
                if (self.dualListType == BBQDualListTypePublishDynamic) {
                    [self createNewDynamicWithObject:model];
                } else {
                    self.tabBarController.selectedIndex = 0;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
            break;
        }
    }
}

#pragma mark - Private Method
- (void)createNewDynamicWithObject:(id)object {
    Dynamic *dynamic;
    if (self.dynamic) {
        Dynamic *temp = [Dynamic dynamicWithMediaType:self.dynamic.mediaType object:object];
        self.dynamic.dtype = temp.dtype;
        self.dynamic.baobaouid = temp.baobaouid;
        self.dynamic.classuid = temp.classuid;
        self.dynamic.schoolid = temp.schoolid;
        self.dynamic.baobaoname = temp.baobaoname;
        self.dynamic.classname = temp.classname;
        self.dynamic.schoolname = temp.schoolname;
        
        dynamic = self.dynamic;
    } else {
        dynamic = [Dynamic dynamicWithMediaType:self.mediaType object:object];
    }
    if (_mediaType == BBQDynamicMediaTypeNone) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Dynamic" bundle:nil];
        BBQDynamicEditViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DynamicEditVC"];
        vc.dynamic = dynamic;
        [self.navigationController setViewControllers:@[self.navigationController.viewControllers.firstObject, vc] animated:YES];
    } else {
        QBImagePickerController *imagePicker = [[QBImagePickerController alloc] initWithDynamic:dynamic];
        [self.navigationController pushViewController:imagePicker animated:YES];
    }
}

- (BOOL)validateDatasource:(NSArray *)datasource {
    if (datasource.count) {
        return YES;
    }
    NSString *error = @"班级或学校数据有误";
    [SVProgressHUD showErrorWithStatus:error];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HUD_DURATION(error) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    return NO;
}

#pragma mark - 网络请求
- (void)downloadBaoBaoDataWtihClass:(BBQClassDataModel *)model {
    BBQGetBaoBaoListApi *api = [[BBQGetBaoBaoListApi alloc] initWithClassid:model.classid];
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        @strongify(self)
        dispatch_async(
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                           NSArray *babyArray = [NSArray modelArrayWithClass:[BBQBabyModel class] json:request.responseJSONObject[@"data"][@"arr"]];
                           [babyArray bk_each:^(BBQBabyModel *obj) {
                               @strongify(self)
                               obj.curClass = model;
                               obj.curSchool = self.primaryDataSource[0];
                           }];
                           dispatch_async_on_main_queue(^{
                               @strongify(self)
                               [self.secondaryDataSource removeAllObjects];
                               if (self.dualListType != BBQDualListTypeDailyReport) {
                                   [self.secondaryDataSource addObject:model];
                               }
                               [self.secondaryDataSource addObjectsFromArray:babyArray];
                               
                               if (self.dynamic && (self.dynamic.dtype.integerValue == BBQDynamicGroupTypeBaby) && [self.dynamic.classuid isEqualToNumber:model.classid] && self.secondarySelectedIndex != -1) {
                                   [self.secondaryDataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                       if ([obj isKindOfClass:[BBQBabyModel class]]) {
                                           BBQBabyModel *baby = obj;
                                           if ([baby.uid isEqualToNumber:self.dynamic.baobaouid]) {
                                               *stop = YES;
                                               self.secondarySelectedIndex = idx;
                                           }
                                       }
                                   }];
                               }
                               [self.secondaryTableView reloadData];
                           });
                       });
    } failure:^(YTKBaseRequest *request) {
        ShowApiError;
    }];
}

#pragma mark - Getter & Setter
- (NSMutableArray *)primaryDataSource {
    if (!_primaryDataSource) {
        _primaryDataSource = [NSMutableArray array];
    }
    return _primaryDataSource;
}

- (NSMutableArray *)secondaryDataSource {
    if (!_secondaryDataSource) {
        _secondaryDataSource = [NSMutableArray array];
    }
    return _secondaryDataSource;
}

@end

//
//  BBQDynamicViewModel.m
//  BBQ
//
//  Created by 朱琨 on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicViewModel.h"
#import "BBQDynamicCell.h"
#import "BBQFetchDynamicApi.h"
#import "BBQDeleteDynamicApi.h"
#import "BBQAddCommentApi.h"
#import "BBQDeleteCommentApi.h"
#import "BBQDynamicTableViewController.h"
#import <DateTools.h>
#import <BlocksKit.h>
#import "BBQPublishManager.h"

@interface BBQDynamicViewModel ()

@property (assign, readwrite, nonatomic) BBQDynamicGroupType groupType;
@property (strong, nonatomic) YYThreadSafeArray *dataSource;
@property (strong, nonatomic) YYThreadSafeArray *layouts;
@property (copy, readwrite, nonatomic) NSNumber *baobaouid;
@property (copy, readwrite, nonatomic) NSNumber *classuid;
@property (copy, readwrite, nonatomic) NSNumber *schoolid;
@property (copy, readwrite, nonatomic) NSString *navTitle;
@property (strong, nonatomic) BBQFetchDynamicApi *loadLatestApi;
@property (strong, nonatomic) BBQFetchDynamicApi *loadMoreApi;
@property (assign, nonatomic) BOOL showWelcome;

@end

@implementation BBQDynamicViewModel

#pragma mark - Init
+ (instancetype)viewModelWithObject:(id)object {
    BBQDynamicViewModel *viewModel;
    if ([object isKindOfClass:[BBQBabyModel class]]) {
        viewModel = [BBQDynamicViewModel viewModelForBaby:((BBQBabyModel *)object).uid];
        viewModel.navTitle = ((BBQBabyModel *)object).realname;
    } else if ([object isKindOfClass:[BBQClassDataModel class]]) {
        viewModel = [BBQDynamicViewModel viewModelForClass:((BBQClassDataModel *)object).classid inSchool:TheCurUser.curSchool.schoolid];
        viewModel.navTitle = ((BBQClassDataModel *)object).classname;
    } else {
        viewModel = [BBQDynamicViewModel viewModelForSchool:((BBQSchoolDataModel *)object).schoolid];
        viewModel.navTitle = ((BBQSchoolDataModel *)object).schoolname;
    }
    return viewModel;
}

+ (instancetype)viewModelForBaby:(NSNumber *)baobaouid {
    return [[BBQDynamicViewModel alloc] initWithGroupType:BBQDynamicGroupTypeBaby baobaouid:baobaouid classuid:nil schoolid:nil];
}

+ (instancetype)viewModelForBabiesInClass:(NSNumber *)classuid {
    return [[BBQDynamicViewModel alloc] initWithGroupType:BBQDynamicGroupTypeBaby baobaouid:nil classuid:classuid schoolid:TheCurUser.curSchool.schoolid];
}

+ (instancetype)viewModelForBabiesInSchool:(NSNumber *)schoolid {
    return [[BBQDynamicViewModel alloc] initWithGroupType:BBQDynamicGroupTypeBaby baobaouid:nil classuid:nil schoolid:schoolid];
}

+ (instancetype)viewModelForClass:(NSNumber *)classuid inSchool:(NSNumber *)schoolid {
    return [[BBQDynamicViewModel alloc] initWithGroupType:BBQDynamicGroupTypeClass baobaouid:nil classuid:classuid schoolid:schoolid];
}

+ (instancetype)viewmodelForClassesInSchool:(NSNumber *)schoolid {
    return [[BBQDynamicViewModel alloc] initWithGroupType:BBQDynamicGroupTypeClass baobaouid:nil classuid:nil schoolid:schoolid];
}

+ (instancetype)viewModelForSchool:(NSNumber *)schoolid {
    return [[BBQDynamicViewModel alloc] initWithGroupType:BBQDynamicGroupTypeSchool baobaouid:nil classuid:nil schoolid:schoolid];
}

- (instancetype)initWithGroupType:(BBQDynamicGroupType)groupType baobaouid:(NSNumber *)baobaouid classuid:(NSNumber *)classuid schoolid:(NSNumber *)schoolid {
    if (self = [super init]) {
        _groupType = groupType;
        _baobaouid = baobaouid ?: @0;
        _classuid = classuid ?: TheCurBaoBao.curClass.classid;
        _schoolid = schoolid ?: TheCurBaoBao.curSchool.schoolid;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePublishDynamicNotification:) name:kPublishDynamicNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCancelPublishDynamicNotification:) name:kCancelPublishDynamicNotification object:nil];
    }
    return self;
}

#pragma mark - Stateful Delegate
- (void)tableViewControllerWillBeginInitialLoad:(BBQTableViewController *)tvc completion:(void (^)(BOOL, BOOL))completion {
    @weakify(self)
    void (^finishBlock)(NSArray *) = ^(NSArray *dynamics) {
        @strongify(self)
        self.showWelcome = dynamics.count ? NO : YES;
        BBQDynamicStyle style = BBQDynamicStyleTimeline;
        if (self.showWelcome) {
            dynamics = @[[Dynamic dynamicForWelcome]];
            style = BBQDynamicStyleWelcome;
        }
        NSArray *layouts = [dynamics bk_map:^id(Dynamic *dynamic) {
            return [[BBQDynamicLayout alloc] initWithDynamic:dynamic style:style];
        }];
        dispatch_async_on_main_queue(^{
            [self.layouts removeAllObjects];
            [self.layouts addObjectsFromArray:layouts];
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:dynamics];
            [self.viewController.tableView reloadData];
            completion(self.dataSource.count == 0, NO);
            [[BBQPublishManager sharedManager] startWorking];
        });
    };
    
    NSDictionary *params = [self requestParamsWithRefreshType:BBQRefreshTypePullDown];
    [self loadDynamicFromLocalWithParams:params completion:^(NSArray *array) {
        @strongify(self)
        if (array.count) {
            finishBlock(array);
        }
        self.loadLatestApi.params = params;
        [self.loadLatestApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray *dynamics = [NSArray modelArrayWithClass:[Dynamic class] json:request.responseJSONObject[@"data"][@"dynaarr"]];
                self.viewController.canLoadMore = dynamics.count >= 10;
#ifndef TARGET_PARENT
                [Dynamic clearTableSync:nil];
#endif
                [dynamics bk_each:^(Dynamic *obj) {
                    [obj insertUpdateSyncToDB:nil];
                }];
                finishBlock(dynamics);
            });
        } failure:^(YTKBaseRequest *request) {
            @strongify(self)
            completion(self.dataSource.count == 0, request.requestOperation.error && !self.dataSource.count ? YES : NO);
        }];
    }];
}

- (void)tableViewControllerWillBeginLoadingFromPullToRefresh:(BBQTableViewController *)tvc completion:(void (^)(BOOL, BOOL))completion {
    NSDictionary *params = [self requestParamsWithRefreshType:BBQRefreshTypePullDown];
    @weakify(self)
    void (^finishBlock)(NSArray *) = ^(NSArray *dynamics) {
        @strongify(self)
        BBQDynamicStyle style = BBQDynamicStyleTimeline;
        if (!dynamics.count && self.showWelcome) {
            dynamics = @[[Dynamic dynamicForWelcome]];
            style = BBQDynamicStyleWelcome;
        }
        NSArray *layouts = [dynamics bk_map:^id(Dynamic *dynamic) {
            return [[BBQDynamicLayout alloc] initWithDynamic:dynamic style:style];
        }];
        dispatch_async_on_main_queue(^{
            [self.layouts removeAllObjects];
            [self.layouts addObjectsFromArray:layouts];
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:dynamics];
            [self.viewController.tableView reloadData];
            completion(self.dataSource.count == 0, NO);
        });
    };
    
    if (kNetworkNotReachability) {
        [self loadDynamicFromLocalWithParams:params completion:finishBlock];
    } else {
        self.loadLatestApi.params = params;
        [self.loadLatestApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray *dynamics = [NSArray modelArrayWithClass:[Dynamic class] json:request.responseJSONObject[@"data"][@"dynaarr"]];
                self.viewController.canLoadMore = dynamics.count >= 10;
#ifndef TARGET_PARENT
                [Dynamic clearTableSync:nil];
#endif
                [dynamics bk_each:^(Dynamic *obj) {
                    [obj insertUpdateSyncToDB:nil];
                }];
                finishBlock(dynamics);
            });
        } failure:^(YTKBaseRequest *request) {
            @strongify(self)
            completion(self.dataSource.count == 0, request.requestOperation.error ? YES : NO);
        }];
    }
}

- (void)tableViewControllerWillBeginLoadingMore:(BBQTableViewController *)tvc completion:(void (^)(BOOL, BOOL, BOOL))completion {
    NSDictionary *params = [self requestParamsWithRefreshType:BBQRefreshTypePullUp];
    @weakify(self)
    void (^finishBlock)(NSArray *) = ^(NSArray *dynamics) {
        @strongify(self)
        NSArray *layouts = [dynamics bk_map:^id(Dynamic *dynamic) {
            return [[BBQDynamicLayout alloc] initWithDynamic:dynamic style:BBQDynamicStyleTimeline];
        }];
        NSMutableArray *tempDynamics = [NSMutableArray arrayWithArray:self.dataSource];
        [tempDynamics addObjectsFromArray:dynamics];
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (Dynamic *dynamic in dynamics) {
            NSInteger idx = [tempDynamics indexOfObject:dynamic];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [indexPaths addObject:indexPath];
        }
        dispatch_async_on_main_queue(^{
            [self.layouts addObjectsFromArray:layouts];
            [self.dataSource addObjectsFromArray:dynamics];
            [self.viewController.tableView beginUpdates];
            [self.viewController.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [self.viewController.tableView endUpdates];
            completion(YES, NO, NO);
        });
    };
    
    if (kNetworkNotReachability) {
        [self loadDynamicFromLocalWithParams:params completion:finishBlock];
    } else {
        self.loadMoreApi.params = params;
        [self.loadMoreApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray *dynamics = [NSArray modelArrayWithClass:[Dynamic class] json:request.responseJSONObject[@"data"][@"dynaarr"]];
#ifdef TARGET_PARENT
                [dynamics bk_each:^(Dynamic *obj) {
                    [obj insertUpdateSyncToDB:nil];
                }];
#endif
                finishBlock(dynamics);
            });
        } failure:^(YTKBaseRequest *request) {
            completion(YES, request.requestOperation.error ? YES : NO, YES);
        }];
    }
}

- (void)loadDynamicFromLocalWithParams:(NSDictionary *)params completion:(void (^)(NSArray *array))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [Dynamic dynamicsWithParams:params completion:^(NSArray *dynamics) {
            if (completion) completion(dynamics);
        }];
    });
}

#pragma mark - Public Method
- (NSInteger)indexOfDynamic:(Dynamic *)dynamic {
    if ([self.dataSource containsObject:dynamic]) {
        return [self.dataSource indexOfObject:dynamic];
    }
    
    __block NSInteger index = NSNotFound;
    [self.dataSource enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(Dynamic *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.localid isEqualToString:dynamic.localid] || [obj.guid isEqualToString:dynamic.guid]) {
            *stop = YES;
            index = idx;
        }
    }];
    
    return index;
}

- (void)handleDateViewForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    BBQDynamicCell *dynamicCell = (BBQDynamicCell *)cell;
    if (indexPath.row == 0) {
        [dynamicCell.dynamicView showDateView:YES];
    } else {
        NSDate *curDate = [NSDate dateWithTimeIntervalSince1970:
                           [self.dataSource[indexPath.row] graphtime].integerValue];
        NSDate *preDate = [NSDate dateWithTimeIntervalSince1970:
                           [self.dataSource[indexPath.row - 1] graphtime].integerValue];
        [dynamicCell.dynamicView showDateView:![curDate isSameDay:preDate]];
    }
}

- (void)deleteDynamic:(Dynamic *)dynamic {
    self.curDynamic = dynamic;
    [Dynamic deleteDynamic:dynamic];
}

- (void)addComment:(Comment *)comment withDynamic:(Dynamic *)dynamic {
    self.curDynamic = dynamic;
    [dynamic addComment:comment];
}

- (void)deleteComment:(Comment *)comment withDynamic:(Dynamic *)dynamic {
    self.curDynamic = dynamic;
    [dynamic deleteComment:comment];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((BBQDynamicLayout *)self.layouts[indexPath.row]).height;
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBQDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:kDynamicCellIdentifier forIndexPath:indexPath];
    cell.delegate = self.viewController;
    cell.layout = self.layouts[indexPath.row];
    return cell;
}

#pragma mark - Private Method
- (BOOL)shouldHandlePublishDynamic:(Dynamic *)dynamic {
    BOOL should = NO;
    if ([dynamic.dtype isEqualToNumber:@(self.groupType)]) {
        switch (self.groupType) {
            case BBQDynamicGroupTypeBaby: {
#ifdef TARGET_PARENT
                if ([dynamic.baobaouid isEqualToNumber:self.baobaouid]) {
                    should = YES;
                }
#else
                if ([dynamic.baobaouid isEqualToNumber:self.baobaouid] || [dynamic.classuid isEqualToNumber:self.classuid]) {
                    should = YES;
                }
#endif
                break;
            }
            case BBQDynamicGroupTypeClass: {
                if ([dynamic.classuid isEqualToNumber:self.classuid]) {
                    should = YES;
                }
                break;
            }
            case BBQDynamicGroupTypeSchool: {
                if ([dynamic.schoolid isEqualToNumber:self.schoolid]) {
                    should = YES;
                }
                break;
            }
        }
    }
    
    return should;
}

- (void)handlePublishDynamicNotification:(NSNotification *)notification {
    Dynamic *dynamic = notification.object;
    if ([self shouldHandlePublishDynamic:dynamic]) {
        //等待上传时添加动态
        if (dynamic.uploadState == BBQDynamicUploadStateWaiting) {
            BBQDynamicLayout *layout = [[BBQDynamicLayout alloc] initWithDynamic:dynamic style:BBQDynamicStyleTimeline];
            dispatch_async_on_main_queue(^{
                NSInteger index = [self indexOfDynamic:dynamic];
                if (index != NSNotFound) {
                    [self.layouts replaceObjectAtIndex:index withObject:layout];
                    [self.dataSource replaceObjectAtIndex:index withObject:dynamic];
                    [self.viewController.tableView reloadRow:[self.dataSource indexOfObject:dynamic] inSection:0 withRowAnimation:UITableViewRowAnimationNone];
                } else {
                    if (self.showWelcome) {
                        [self.layouts replaceObjectAtIndex:0 withObject:layout];
                        [self.dataSource replaceObjectAtIndex:0 withObject:dynamic];
                        [self.viewController.tableView reloadRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
                        self.showWelcome = NO;
                    }  else {
                        [self.layouts insertObject:layout atIndex:0];
                        [self.dataSource insertObject:dynamic atIndex:0];
                        [self.viewController.tableView beginUpdates];
                        [self.viewController.tableView insertRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
                        [self.viewController.tableView endUpdates];
                        [self resetDateView];
                    }
                }
            });
        } else {
            [self reloadDynamic:dynamic];
        }
    }
}

- (void)handleCancelPublishDynamicNotification:(NSNotification *)notification {
    Dynamic *dynamic = notification.object;
    if ([self shouldHandlePublishDynamic:dynamic]) {
        NSInteger index = [self indexOfDynamic:dynamic];
        if (index != NSNotFound) {
            dispatch_async_on_main_queue(^{
                [self.layouts removeObjectAtIndex:index];
                [self.dataSource removeObjectAtIndex:index];
                [self.viewController.tableView beginUpdates];
                [self.viewController.tableView deleteRow:index inSection:0 withRowAnimation:UITableViewRowAnimationNone];
                [self.viewController.tableView endUpdates];
            });
        }
    }
}

- (void)reloadDynamic:(Dynamic *)dynamic {
    if ([self.dataSource containsObject:dynamic]) {
        if (dynamic.uploadState == BBQDynamicUploadStateUploading) {
            return;
        }
        NSInteger idx = [self.dataSource indexOfObject:dynamic];
        BBQDynamicLayout *layout = [[BBQDynamicLayout alloc] initWithDynamic:dynamic style:BBQDynamicStyleTimeline];
        dispatch_async_on_main_queue(^{
            [self.layouts replaceObjectAtIndex:idx withObject:layout];
            [self.viewController.tableView reloadRow:idx inSection:0 withRowAnimation:UITableViewRowAnimationNone];
        });
    } else {
        BBQDynamicLayout *layout = [[BBQDynamicLayout alloc] initWithDynamic:dynamic style:BBQDynamicStyleTimeline];
        dispatch_async_on_main_queue(^{
            [self.layouts insertObject:layout atIndex:0];
            [self.dataSource insertObject:dynamic atIndex:0];
            [self.viewController.tableView beginUpdates];
            [self.viewController.tableView insertRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
            [self.viewController.tableView endUpdates];
        });
    }
}

- (void)resetDateView {
    dispatch_async_on_main_queue(^{
        [self.viewController.tableView.indexPathsForVisibleRows enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
            BBQDynamicCell *cell = [self.viewController.tableView cellForRowAtIndexPath:indexPath];
            [self handleDateViewForCell:cell atIndexPath:indexPath];
            [self.viewController.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        }];
    });
}

- (NSDictionary *)requestParamsWithRefreshType:(BBQRefreshType)type {
    NSNumber *lastDateLine = type == BBQRefreshTypePullDown ? @(0) : (((Dynamic *)self.dataSource.lastObject).graphtime ?: @(0));
    return @{
             @"baobaouid" : self.baobaouid ?: @"",
             @"classuid" : self.classuid ?: @"",
             @"schoolid" : self.schoolid ?: @"",
             @"dtype" : @(self.groupType),
             @"type" : @(type),
             @"dateline" : lastDateLine,
             @"guid" : ((Dynamic *)self.dataSource.lastObject).guid ?: @"0",
             };
}

#pragma mark - Getter & Setter
- (YYThreadSafeArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [YYThreadSafeArray array];
    }
    return _dataSource;
}

- (YYThreadSafeArray *)layouts {
    if (!_layouts) {
        _layouts = [YYThreadSafeArray array];
    }
    return _layouts;
}

- (BBQFetchDynamicApi *)loadLatestApi {
    if (!_loadLatestApi) {
        _loadLatestApi = [[BBQFetchDynamicApi alloc] initWithParams:[self requestParamsWithRefreshType:BBQRefreshTypePullDown]];
    }
    return _loadLatestApi;
}

- (BBQFetchDynamicApi *)loadMoreApi {
    if (!_loadMoreApi) {
        _loadMoreApi = [[BBQFetchDynamicApi alloc] initWithParams:[self requestParamsWithRefreshType:BBQRefreshTypePullUp]];
    }
    return _loadMoreApi;
}

- (void)setCurDynamic:(Dynamic *)curDynamic {
    if (_curDynamic != curDynamic) {
        [_curDynamic bk_removeAllBlockObservers];
        _curDynamic = curDynamic;
        @weakify(self)
        [curDynamic bk_addObserverForKeyPaths:@[@"content", @"attachinfo", @"giftdata", @"reply", @"flag"] options:NSKeyValueObservingOptionNew task:^(Dynamic *dynamic, NSString *keyPath, NSDictionary *change) {
            @strongify(self)
            if ([keyPath isEqualToString:@"flag"]) {
                NSInteger index = [self.dataSource indexOfObject:dynamic];
                if (index != NSNotFound) {
                    dispatch_async_on_main_queue(^{
                        [self.dataSource removeObjectAtIndex:index];
                        [self.layouts removeObjectAtIndex:index];
                        [self.viewController.tableView beginUpdates];
                        [self.viewController.tableView deleteRow:index inSection:0 withRowAnimation:UITableViewRowAnimationFade];
                        [self.viewController.tableView endUpdates];
                        if (!self.dataSource.count) {
                            Dynamic *dynamic = [Dynamic dynamicForWelcome];
                            BBQDynamicLayout *layout = [[BBQDynamicLayout alloc] initWithDynamic:dynamic style:BBQDynamicStyleWelcome];
                            [self.dataSource addObject:dynamic];
                            [self.layouts addObject:layout];
                            [self.viewController.tableView reloadData];
                            self.showWelcome = YES;
                        }
                        [self resetDateView];
                    });
                }
            } else {
                [self reloadDynamic:dynamic];
            }
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

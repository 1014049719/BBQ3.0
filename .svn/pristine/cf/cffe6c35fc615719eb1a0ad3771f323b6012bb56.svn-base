//
//  UploadRecordViewController.m
//
//
//  Created by 朱琨 on 15/9/15.
//
//

#import "UploadRecordViewController.h"
#import "UploadRecordCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "DetailViewController.h"
#import <BlocksKit+UIKit.h>
#import "BBQPublishManager.h"

@interface UploadRecordViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) YYThreadSafeArray *dataSource;

@end

@implementation UploadRecordViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"上传记录";
    self.tableView.tableFooterView = [UIView new];
    @weakify(self)
    [Dynamic dynamicsNeedUploadWithCompletion:^(NSArray *dynamics) {
        @strongify(self)
        [self.dataSource addObjectsFromArray:dynamics];
        [self.tableView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCancelPublishDynamicNotification:) name:kPublishDynamicNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UploadRecordCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UploadRecordCell"
                                    forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"UploadRecordCell"
                                    cacheByIndexPath:indexPath
                                       configuration:^(UploadRecordCell *cell) {
                                           cell.model =
                                           self.dataSource[indexPath.row];
                                       }];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UploadRecordCell *cell =
    (UploadRecordCell *)[tableView cellForRowAtIndexPath:indexPath];
    Dynamic *dynamic = cell.model;
    UIActionSheet *sheet = [UIActionSheet bk_actionSheetWithTitle:@"操作"];
    @weakify(self)
    [sheet bk_addButtonWithTitle:@"查看" handler:^{
        @strongify(self)
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
        DetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DetailViewVC"];
        vc.dynamic = dynamic;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [sheet bk_setCancelButtonWithTitle:@"取消" handler:nil];
    switch (dynamic.uploadState) {
        case BBQDynamicUploadStateSuccess: {
            break;
        }
        case BBQDynamicUploadStateWaiting: {
            [sheet bk_setDestructiveButtonWithTitle:@"取消上传" handler:^{
                @strongify(self)
                [self cancelUploadDynamic:dynamic];
            }];
            break;
        }
        case BBQDynamicUploadStateUploading: {
            break;
        }
        case BBQDynamicUploadStateFail: {
            [sheet bk_addButtonWithTitle:@"重新上传" handler:^{
                [[BBQPublishManager sharedManager] addDynamic:dynamic];
            }];
            [sheet bk_setDestructiveButtonWithTitle:@"取消上传" handler:^{
                @strongify(self)
                [self cancelUploadDynamic:dynamic];
            }];
            break;
        }
    }
    [sheet showInView:self.view];
}

- (void)cancelUploadDynamic:(Dynamic *)dynamic {
    NSInteger idx = [self.dataSource indexOfObject:dynamic];
    [Dynamic deleteDynamic:dynamic];
    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:kCancelPublishDynamicNotification object:dynamic];
    [self.dataSource removeObject:dynamic];
    [self.tableView beginUpdates];
    [self.tableView deleteRow:idx inSection:0 withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)handleCancelPublishDynamicNotification:(NSNotification *)notification {
    Dynamic *dynamic = notification.object;
    NSInteger index = [self indexOfDynamic:dynamic];
    if (index != NSNotFound) {
        [self.dataSource replaceObjectAtIndex:index withObject:dynamic];
        [self.tableView reloadRow:index inSection:0 withRowAnimation:UITableViewRowAnimationNone];
    }
}

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

#pragma mark - Getter & Setter
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [YYThreadSafeArray array];
    }
    return _dataSource;
}

@end

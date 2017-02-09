//
//  BBQDynamicVC.m
//  BBQ
//
//  Created by 朱琨 on 15/10/29.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicVC.h"
#import "BBQBaseTableView.h"
#import "BBQDynamicCell.h"
#import "ODRefreshControl.h"
#import "SVPullToRefresh.h"
#import "UIMessageInputView.h"
#import "BBQBabyHeaderView.h"
#import <UIScrollView+APParallaxHeader.h>
#import <Masonry.h>

@interface BBQDynamicVC () <UITableViewDelegate, BBQDynamicCellDelegate, UIMessageInputViewDelegate>

@property (strong, nonatomic) NSNumber *groupType;
@property (strong, nonatomic) BBQBabyHeaderView *headerView;
@property (strong, nonatomic) UIMessageInputView *inputView;
@property (strong, nonatomic) BBQBaseTableView *tableView;
@property (strong, nonatomic) BBQDynamicViewModel *viewModel;
@property (strong, nonatomic) ODRefreshControl *refreshController;

@end

@implementation BBQDynamicVC

#pragma mark - Life Cycle
- (instancetype)initWithViewModel:(BBQDynamicViewModel *)viewModel {
    if (self = [super init]) {
        _viewModel = viewModel;
        _viewModel.viewController = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    if (self.viewModel.baobaouid && ![self.viewModel.baobaouid isEqualToString:@""] && self.viewModel.groupType == BBQDynamicGroupTypeBaby) {
        [self.tableView addParallaxWithView:self.headerView andHeight:CGRectGetHeight(self.headerView.frame)];
    }
    
    self.inputView.delegate = self;
//    [self.viewModel loadLatest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.inputView) {
        [self.inputView prepareToShow];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_inputView) {
        [_inputView prepareToDismiss];
    }
}

#pragma mark - Tabel View Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [self.viewModel heightForRowAtIndexPath:indexPath];
    return 50;
}

#pragma mark - Scroll View Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - View Model Delegate

#pragma mark - Dynamic Cell Delegate

#pragma mark - UIMessageInputView Delegate
- (void)messageInputView:(UIMessageInputView *)inputView sendText:(NSString *)text {
    
}

- (void)messageInputView:(UIMessageInputView *)inputView
   heightToBottomChenged:(CGFloat)heightToBottom {
    
}

#pragma mark - Event Response
- (void)didTapBabyAvatarView {
    
}
/**
 *  HeaderView 右上角按钮
 */
- (void)didClickInfoButton {
    
}

#pragma mark - Setter & Getter
- (BBQDynamicViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BBQDynamicViewModel alloc] initWithGroupType:(BBQDynamicGroupType)self.groupType.unsignedIntegerValue];
//        _viewModel.delegate = self;
    }
    return _viewModel;
}

- (BBQBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            BBQBaseTableView *tableView = [[BBQBaseTableView alloc] initWithFrame:self.view.bounds];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tableView registerClass:[BBQDynamicCell class] forCellReuseIdentifier:kDynamicCellIdentifier];
            
//            @weakify(self)
//            [tableView addInfiniteScrollingWithActionHandler:^{
//                @strongify(self)
//                [self.viewModel loadMoreWithHandler:^(NSDictionary *responseObject, NSError *error) {
//                    
//                }];
//            }];
            tableView;
        });
        _tableView.delegate = self;
        _tableView.dataSource = self.viewModel;
    }
    return _tableView;
}

- (ODRefreshControl *)refreshController {
    if (!_refreshController) {
        _refreshController = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    }
    return _refreshController;
}

- (UIMessageInputView *)inputView {
    if (!_inputView) {
        _inputView = [UIMessageInputView
                      messageInputViewWithType:UIMessageInputViewContentTypeTweet];
    }
    return _inputView;
}

- (BBQBabyHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BBQBabyHeaderView alloc] initWithBaby:nil];
        @weakify(self)
        _headerView.avatarViewClicked = ^{
            @strongify(self)
            [self didTapBabyAvatarView];
        };
        _headerView.infoButtonClicked = ^{
            @strongify(self)
            [self didClickInfoButton];
        };
    }
    return _headerView;
}
@end

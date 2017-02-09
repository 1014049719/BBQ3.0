//
//  BBQTableViewController.h
//  BBQ
//
//  Created by 朱琨 on 15/11/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "ODRefreshControl.h"
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BBQTableViewControllerState) {
    BBQTableViewControllerStateIdle,
    BBQTableViewControllerStateInitialLoading,
    BBQTableViewControllerStateEmpty,
    BBQTableViewControllerStateInitialLoadError,
    BBQTableViewControllerStateLoadingFromPullToRefresh,
    BBQTableViewControllerStateLoadingMore
};

@class BBQTableViewController;
@protocol BBQTableViewControllerDelegate <NSObject>

@optional
- (void)tableViewControllerWillBeginInitialLoad:(BBQTableViewController *)tvc
                                     completion:
(void (^)(BOOL tableIsEmpty,
          BOOL hasError))completion;
- (void)
tableViewControllerWillBeginLoadingFromPullToRefresh:
(BBQTableViewController *)tvc
completion:
(void (^)(BOOL tableIsEmpty,
          BOOL hasError))
completion;
- (void)tableViewControllerWillBeginLoadingMore:(BBQTableViewController *)tvc
                                     completion:(void (^)(BOOL canLoadMore,
                                                          BOOL hasError,
                                                          BOOL showErrorView))
completion;

- (UIView *)tableViewControllerViewForInitialLoad:(BBQTableViewController *)tvc;

@end

@interface BBQTableViewController : UIViewController <UITableViewDelegate>

@property(weak, nonatomic) id<BBQTableViewControllerDelegate> statefulDelegate;
@property(assign, nonatomic) BBQTableViewControllerState statefulState;
@property(strong, nonatomic) UITableView *tableView;
@property(assign, nonatomic) BOOL canPullToRefresh;
@property (assign, nonatomic) BOOL needPullToRefresh;
@property(assign, nonatomic) BOOL canLoadMore;
@property (assign, nonatomic) BOOL needLoadMore;

- (void)onInit;
- (BOOL)triggerInitialLoad;
- (void)setHasFinishedInitialLoad:(BOOL)tableIsEmpty hasError:(BOOL)hasError;
- (BOOL)triggerPullToRefresh;
- (void)setHasFinishedLoadingFromPullToRefresh:(BOOL)tableIsEmpty
                                      hasError:(BOOL)hasError;
- (void)triggerLoadMore;
- (void)setHasFinishedLoadingMore:(BOOL)canLoadMore
                         hasError:(BOOL)hasError
                    showErrorView:(BOOL)showErrorView;
- (BOOL)stateIsLoading;

@end
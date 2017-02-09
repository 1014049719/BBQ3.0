//
//  BBQTableViewController.h
//  BBQ
//
//  Created by 朱琨 on 15/11/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BBQTableViewControllerState) {
    BBQTableViewControllerStateIdle,
    BBQTableViewControllerStateInitialLoading,
    BBQTableViewControllerStateInitialLoadingTableView,
    BBQTableViewControllerStateEmptyOrInitialLoadError,
    BBQTableViewControllerStateLoadingFromPullToRefresh,
    BBQTableViewControllerStateLoadingMore
};
@class BBQTableViewController;

@protocol BBQTableViewControllerDelegate <NSObject>

@optional
- (void)statefulTableViewControllerWillBeginInitialLoad:(BBQTableViewController *)tvc
                                             completion:
(void (^)(BOOL tableIsEmpty, NSError *errorOrNil))completion;
- (void)statefulTableViewControllerWillBeginLoadingFromPullToRefresh:(BBQTableViewController *)tvc
                                                          completion:(void (^)(BOOL tableIsEmpty,
                                                                               NSError *errorOrNil))completion;
- (void)statefulTableViewControllerWillBeginLoadingMore:(BBQTableViewController *)tvc
                                             completion:(void (^)(BOOL canLoadMore, NSError *errorOrNil,
                                                                  BOOL showErrorView))completion;

- (UIView *)statefulTableViewControllerViewForInitialLoad:(BBQTableViewController *)tvc;
// TODO rename since this is reused for pull to refresh as well
- (UIView *)statefulTableViewController:(BBQTableViewController *)tvc
       viewForEmptyInitialLoadWithError:(NSError *)errorOrNil;
- (UIView *)statefulTableViewController:(BBQTableViewController *)tvc
               viewForLoadMoreWithError:(NSError *)errorOrNil;

@end

@interface BBQTableViewController
: UITableViewController <BBQTableViewControllerDelegate>

@property (weak, nonatomic) id<BBQTableViewControllerDelegate> statefulDelegate;

@property (readonly, strong, nonatomic) UIView *staticContainerView;

@property (nonatomic) BBQTableViewControllerState statefulState;

// Enable/disable pull-to-refresh. This will only work if this is set before -viewDidLoad gets
// launched.
@property (nonatomic) BOOL canPullToRefresh;

@property (nonatomic) CGFloat loadMoreTriggerThreshold;
@property (nonatomic) BOOL canLoadMore;
@property (strong, nonatomic) NSError *lastLoadMoreError;

- (void)onInit;

- (void)setStatefulState:(BBQTableViewControllerState)state withError:(NSError *)error;

- (BOOL)triggerInitialLoad;
- (BOOL)triggerInitialLoadShowingTableView:(BOOL)showTableView;
- (void)setHasFinishedInitialLoad:(BOOL)tableIsEmpty withError:(NSError *)errorOrNil;
- (BOOL)triggerPullToRefresh;
- (void)setHasFinishedLoadingFromPullToRefresh:(BOOL)tableIsEmpty withError:(NSError *)errorOrNil;
- (void)triggerLoadMore;
- (void)setHasFinishedLoadingMore:(BOOL)canLoadMore
                        withError:(NSError *)errorOrNil
                    showErrorView:(BOOL)showErrorView;

/**
 A convenience method for resetting the statefulState if self is currently in
 StatefulTableViewControllerIdle or BBQTableViewControllerStateEmptyOrInitialLoadError
 and the table data source has changed without going through pull-to-refresh or initial-load.
 */
- (void)updateIdleOrEmptyOrInitialLoadState:(BOOL)tableIsEmpty withError:(NSError *)errorOrNil;

- (BOOL)stateIsLoading;
- (BOOL)stateIsInitialLoading;

@end
////
////  DynamicTableViewController.m
////  BBQ
////
////  Created by 朱琨 on 15/8/2.
////  Copyright © 2015年 bbq. All rights reserved.
////
//
//#import "AttachModel.h"
//#import "BabyDynamicCell.h"
//#import "CommentModel.h"
//#import "CommentView.h"
//#import "DetailViewController.h"
//#import "BBQDynamicViewController.h"
//#import "GiftViewController.h"
//#import "ReceivedGiftViewController.h"
//#import "ShareView.h"
//#import <Masonry.h>
//#import <QBPopupMenu.h>
//#import "NSString+Common.h"
//#import <UITableView+FDTemplateLayoutCell.h>
//#import "SVPullToRefresh.h"
//#import <SSPullToRefresh.h>
//#import "DynaModel.h"
//
//
//#import "UserDataShowViewController.h"
//
//#import "NoDataCell.h"
//#import "AppMacro.h"
//#import "DynamicCreateTableViewController.h"
//#import "UIMessageInputView.h"
//#import "DynaMgr.h"
//#import <BlocksKit.h>
//#import <BlocksKit+UIKit.h>
//#import "MJPhotoBrowser.h"
//#import "BBQMoviePlayerViewController.h"
//
//@interface BBQDynamicViewController () <
//DynamicCellDelegate, UITableViewDelegate,
//UITableViewDataSource, SSPullToRefreshViewDelegate,
//UIMessageInputViewDelegate>
//
//@property(strong, nonatomic) NSMutableArray *dataSource;
//@property(assign, nonatomic) NSInteger indexOfTargetComment;
//@property(strong, nonatomic) SSPullToRefreshView *pullToRefreshView;
//@property(strong, nonatomic) DynaModel *currentModel;
//@property(strong, nonatomic) QBPopupMenu *popupMenu;
//@property(weak, nonatomic) IBOutlet UITableView *tableView;
//@property(assign, nonatomic) BOOL isRefreshing;
//@property(copy, nonatomic) NSString *guidToRefreshComment;
//@property(strong, nonatomic) UIImageView *imgView;
//@property(assign, nonatomic) BOOL firstLoad;
//@property(strong, nonatomic) NSIndexPath *deleteIndexPath;
//@property(strong, nonatomic) UIMessageInputView *inputView;
//@property(strong, nonatomic) DynaModel *commentDynamic;
//@property(strong, nonatomic) UIView *commentSender;
//@property(assign, nonatomic) BOOL commentIsReply;
//@property(assign, nonatomic) CGFloat oldPanOffsetY;
//
//@end
//
//@implementation BBQDynamicViewController
//
//#pragma mark - Life Cycle
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view beginLoading];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(addDynamic:)
//                                                 name:kAddedDynamicNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(handleUpdateDynamicStatusNotification:)
//     name:kUpdateDynamicStatusNotification
//     object:nil];
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(handleDeleteDynamicNotification:)
//     name:kDeleteDynamicNotification
//     object:nil];
//    
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(refreshSpecifyData:)
//     name:kSetNeedsRefreshSpecifiedDataNotification
//     object:nil];
//    
//#ifdef TARGET_TEACHER
//    if (TheCurUser.curSchool)
//        self.schoolid = TheCurUser.curSchool.schoolid;
//    else
//        self.schoolid = @"0";
//    if (TheCurUser.curClass)
//        self.classuid = TheCurUser.curClass.classuid;
//    else
//        self.classuid = @"0";
//    
//    //    if (!self.baobaouid) {
//    //        if ( TheGlobal.curBaobao )
//    //            self.baobaouid = TheGlobal.curbaobao.uid;
//    //        else
//    //            self.baobaouid = @"0";
//    //    }
//#elif TARGET_MASTER
//    //园长端，切换动态通知
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(masterSwitchDynamic:)
//     name:kMasterSwitchDynaNotificaton
//     object:nil];
//    
//    if (!self.schoolid) {
//        if (TheCurUser.curSchool)
//            self.schoolid = TheCurUser.curSchool.schoolid;
//        else
//            self.schoolid = @"0";
//        self.classuid = @"0";
//        self.baobaouid = @"0";
//    }
//    
//    if (self.realname) {
//        self.navigationItem.title = self.realname;
//    }
//    
//#endif
//    
//    QBPopupMenuItem *deleteItem =
//    [QBPopupMenuItem itemWithTitle:@"删除"
//                            target:self
//                            action:@selector(deleteComment)];
//    
//    self.popupMenu = [[QBPopupMenu alloc] initWithItems:@[ deleteItem ]];
//    self.popupMenu.highlightedColor = [UIColor colorWithHexString:@"ff6440"];
//    self.tableView.estimatedRowHeight = 550;
//    self.dataSource = [NSMutableArray array];
//    
//    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        [self refreshDataWithType:BBQRefreshTypePullUp];
//    }];
//    
//    self.inputView = [UIMessageInputView
//                      messageInputViewWithType:UIMessageInputViewContentTypeTweet];
//    self.inputView.delegate = self;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    if (self.inputView) {
//        [self.inputView prepareToDismiss];
//    }
//    [self hidePopmenu];
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    if (self.inputView) {
//        [self.inputView prepareToShow];
//    }
//    if (!self.firstLoad) {
//        [self refreshFirst];
//    }
//}
//
//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    if (!self.pullToRefreshView) {
//        self.pullToRefreshView =
//        [[SSPullToRefreshView alloc] initWithScrollView:self.tableView
//                                               delegate:self];
//    }
//}
//
//- (void)viewDidUnload {
//    [super viewDidUnload];
//    self.pullToRefreshView = nil;
//}
//
//#pragma mark - Refresh
//- (void)refreshFirst {
//    NSDictionary *params =
//    [self requestParamsWithRefreshType:BBQRefreshTypePullDown];
//    self.dataSource = [[BizLogic getDyna:params[@"baobaouid"]
//                                classuid:params[@"classuid"]
//                                schoolid:params[@"schoolid"]
//                                   dtype:(int)self.dynamicType
//                                dateline:0] mutableCopy];
//    [self.tableView reloadData];
//    [self.view endLoading];
//    self.firstLoad = YES;
//    [self refreshDataWithType:BBQRefreshTypePullDown];
//}
//
//- (void)addPhotoRemind:(NSNotification *)notification {
//    _imgView = [[UIImageView alloc]
//                initWithFrame:CGRectMake(-(171 / 2), self.view.frame.size.height - 138,
//                                         171 / 2, 216 / 2)];
//    _imgView.userInteractionEnabled = YES;
//    [_imgView becomeFirstResponder];
//    _imgView.animationImages =
//    [NSArray arrayWithObjects:[UIImage imageNamed:@"exploreAni1"],
//     [UIImage imageNamed:@"exploreAni2"], nil];
//    _imgView.animationDuration = 0.5;
//    _imgView.animationRepeatCount = 0;
//    [_imgView startAnimating];
//    [UIView animateWithDuration:1
//                     animations:^{
//                         _imgView.frame =
//                         CGRectMake(0, self.view.frame.size.height - 138,
//                                    171 / 2, 216 / 2);
//                     }];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(jumpToCreateDyna)];
//    [_imgView addGestureRecognizer:tap];
//    //    [NSTimer scheduledTimerWithTimeInterval:15.0 target:self
//    //    selector:@selector(stopAnimation) userInfo:nil repeats:NO];
//    [self.view addSubview:_imgView];
//}
//
//- (void)jumpToCreateDyna {
//    [_imgView stopAnimating];
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
//    DynamicCreateTableViewController *vc =
//    [sb instantiateViewControllerWithIdentifier:@"editdyna"];
//    vc.itemType = UploadItemTypePhoto;
//    // vc.navTitle = self.uploadTitle;
//    [(UINavigationController *)self.navigationController pushViewController:vc
//                                                                   animated:NO];
//}
//
//- (void)stopAnimation {
//    [_imgView stopAnimating];
//}
//
//- (void)dealloc {
//}
//
//#pragma mark - Pull To Refresh
//- (BOOL)pullToRefreshViewShouldStartLoading:(SSPullToRefreshView *)view {
//    
//    return !self.isRefreshing;
//}
//
//- (void)pullToRefreshView:(SSPullToRefreshView *)view
//     didTransitionToState:(SSPullToRefreshViewState)toState
//                fromState:(SSPullToRefreshViewState)fromState
//                 animated:(BOOL)animated {
//    if (fromState == SSPullToRefreshViewStateReady &&
//        toState == SSPullToRefreshViewStateLoading) {
//        self.isRefreshing = YES;
//    } else if (fromState == SSPullToRefreshViewStateLoading &&
//               toState == SSPullToRefreshViewStateClosing) {
//        self.isRefreshing = NO;
//    }
//}
//
//- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
//    [self refreshDataWithType:BBQRefreshTypePullDown];
//}
//
//#pragma mark - Table View data source
//- (NSInteger)tableView:(UITableView *)tableView
// numberOfRowsInSection:(NSInteger)section {
//    return self.dataSource.count ?: 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.dataSource.count) {
//        BabyDynamicCell *cell =
//        [tableView dequeueReusableCellWithIdentifier:@"BabyDynamicCell"
//                                        forIndexPath:indexPath];
//        cell.model = self.dataSource[indexPath.row];
//        cell.indexPath = indexPath;
//        cell.delegate = self;
//        if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
//            [cell loadImages];
//        }
//        return cell;
//    }
//    
//    NoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoDataCell"
//                                                       forIndexPath:indexPath];
//    if (TheCurUser.member.groupkey.integerValue == BBQGroupkeyTypeParent) {
//        NSString *strRelation =
//        [NSString rela];
//        cell.contentLabel.text = [NSString
//                                  stringWithFormat:@"Hi~ 亲爱的%@%@， "
//                                  @"欢迎来到宝宝圈的大家庭。这里不仅可以记录宝宝的成长"
//                                  @"瞬间，也可以知道宝宝在幼儿园的最新表现哦~",
//                                  TheCurBaoBao.realname, strRelation];
//    } else if (TheCurUser.member.groupkey.integerValue == BBQGroupkeyTypeTeacher) {
//        cell.contentLabel.text = [NSString
//                                  stringWithFormat:@"Hi~ 亲爱的%@， "
//                                  @"欢迎来到宝宝圈的大家庭。这里不仅可以记录宝宝的成长"
//                                  @"瞬间，也可以知道宝宝在幼儿园的最新表现哦~",
//                                  TheCurUser.member.realname];
//    } else if (TheCurUser.member.groupkey.integerValue == BBQGroupkeyTypeMaster) {
//        cell.contentLabel.text = [NSString
//                                  stringWithFormat:@"Hi~ 亲爱的%@， "
//                                  @"欢迎来到宝宝圈的大家庭。这里不仅可以记录宝宝的成长"
//                                  @"瞬间，也可以知道宝宝在幼儿园的最新表现哦~",
//                                  TheCurUser.member.realname];
//    }
//    //    cell.contentLabel.text = [NSString stringWithFormat:@"Hi~ 亲爱的%@%@，
//    //    欢迎来到宝宝圈的大家庭。这里不仅可以记录宝宝的成长瞬间，也可以知道宝宝在幼儿园的最新表现哦~",
//    //    TheCurBaoBao.realname, TheCurBaoBao.gxname];
//    
//    return cell;
//}
//
//- (CGFloat)tableView:(nonnull UITableView *)tableView
//heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    if (self.dataSource.count) {
//        //                return [tableView
//        //                fd_heightForCellWithIdentifier:@"BabyDynamicCell"
//        //                cacheByKey:model.identifier
//        //                configuration:^(BabyDynamicCell *cell) {
//        //                    cell.model = self.dataSource[indexPath.row];
//        //                }];
//        return [tableView fd_heightForCellWithIdentifier:@"BabyDynamicCell"
//                                           configuration:^(BabyDynamicCell *cell) {
//                                               cell.model =
//                                               self.dataSource[indexPath.row];
//                                           }];
//        //        return [tableView
//        //        fd_heightForCellWithIdentifier:@"BabyDynamicCell"
//        //        cacheByIndexPath:indexPath configuration:^(BabyDynamicCell *cell)
//        //        {
//        //            cell.model = self.dataSource[indexPath.row];
//        //        }];
//    }
//    return [tableView
//            fd_heightForCellWithIdentifier:@"NoDataCell"
//            configuration:^(NoDataCell *cell) {
//                //        cell.contentLabel.text = [NSString
//                //        stringWithFormat:@"Hi~ 亲爱的%@%@，
//                //        欢迎来到宝宝圈的大家庭。这里不仅可以记录宝宝的成长瞬间，也可以知道宝宝在幼儿园的最新表现哦~",
//                //        TheCurBaoBao.realname, TheCurBaoBao.gxname];
//                if (TheCurUser.member.groupkey.integerValue == BBQGroupkeyTypeParent) {
//                    NSString *strRelation = [TJYEXLoginUserInfo
//                                             relationshipLabelText:TheCurBaoBao.gxid.intValue
//                                             gxname:TheCurBaoBao.gxname];
//                    cell.contentLabel.text = [NSString
//                                              stringWithFormat:@"Hi~ 亲爱的%@%@， "
//                                              @"欢迎来到宝宝圈的大家庭。这里"
//                                              @"不仅可以记录宝宝的成长瞬间，"
//                                              @"也可以知道宝宝在幼儿园的最新"
//                                              @"表现哦~",
//                                              TheCurBaoBao.realname,
//                                              strRelation];
//                } else if (TheCurUser.member.groupkey.integerValue ==
//                           BBQGroupkeyTypeTeacher) {
//                    
//                    cell.contentLabel.text = [NSString
//                                              stringWithFormat:@"Hi~ 亲爱的%@， "
//                                              @"欢迎来到宝宝圈的大家庭。这里"
//                                              @"不仅可以记录宝宝的成长瞬间，"
//                                              @"也可以知道宝宝在幼儿园的最新"
//                                              @"表现哦~",
//                                              TheCurUser.member.realname];
//                } else if (TheCurUser.member.groupkey.integerValue ==
//                           BBQGroupkeyTypeMaster) {
//                    cell.contentLabel.text = [NSString
//                                              stringWithFormat:@"Hi~ 亲爱的%@， "
//                                              @"欢迎来到宝宝圈的大家庭。这里"
//                                              @"不仅可以记录宝宝的成长瞬间，"
//                                              @"也可以知道宝宝在幼儿园的最新"
//                                              @"表现哦~",
//                                              TheCurUser.member.realname];
//                }
//            }];
//}
//
//- (void)loadImagesForOnscreenRows {
//    if (self.dataSource.count > 0) {
//        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
//        for (NSIndexPath *indexPath in visiblePaths) {
//            BabyDynamicCell *cell =
//            (BabyDynamicCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//            [cell loadImages];
//        }
//    }
//}
//
//#pragma mark - TableView Delegate
//
//- (void)tableView:(nonnull UITableView *)tableView
//  willDisplayCell:(nonnull UITableViewCell *)cell
//forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    if (self.dataSource.count && [cell isKindOfClass:[BabyDynamicCell class]]) {
//        [(BabyDynamicCell *)cell loadImages];
//        [(BabyDynamicCell *)cell hidePopmenu];
//    }
//}
//
//- (void)tableView:(nonnull UITableView *)tableView
//didEndDisplayingCell:(nonnull UITableViewCell *)cell
//forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    if (self.dataSource.count && [cell isKindOfClass:[BabyDynamicCell class]]) {
//        [(BabyDynamicCell *)cell cancelAllOperations];
//    }
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView) {
//        [self.inputView isAndResignFirstResponder];
//        _oldPanOffsetY =
//        [scrollView.panGestureRecognizer translationInView:scrollView.superview]
//        .y;
//    }
//}
//- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView {
//    [self dismissPopupMenu];
//    if (scrollView.panGestureRecognizer.state ==
//        UIGestureRecognizerStateChanged) {
//        CGFloat nowPanOffsetY =
//        [scrollView.panGestureRecognizer translationInView:scrollView.superview]
//        .y;
//        //        CGFloat diffPanOffsetY = nowPanOffsetY - _oldPanOffsetY;
//        //        CGFloat contentOffsetY = scrollView.contentOffset.y;
//        _oldPanOffsetY = nowPanOffsetY;
//    }
//    
//    [self hidePopmenu];
//}
//// -------------------------------------------------------------------------------
////	scrollViewDidEndDragging:willDecelerate:
////  Load images for all onscreen rows when scrolling is finished.
//// -------------------------------------------------------------------------------
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
//                  willDecelerate:(BOOL)decelerate {
//    _oldPanOffsetY = 0;
//    if (!decelerate) {
//        [self loadImagesForOnscreenRows];
//    }
//}
//
//// -------------------------------------------------------------------------------
////	scrollViewDidEndDecelerating:scrollView
////  When scrolling stops, proceed to load the app icons that are on screen.
//// -------------------------------------------------------------------------------
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self loadImagesForOnscreenRows];
//}
//
//- (void)scrollViewWillBeginDecelerating:(nonnull UIScrollView *)scrollView {
//    [self loadImagesForOnscreenRows];
//}
//
//#pragma mark - DynamicCell Delegate
//- (void)didClickBottomCommentButtonAtIndexPath:(NSIndexPath *)indexPath {
//    self.currentModel = self.dataSource[indexPath.row];
//    [self performSegueWithIdentifier:@"DynamicToDetailSegue" sender:nil];
//}
//
//- (void)didClickShareButtonAtIndexPath:(NSIndexPath *)indexPath {
//    self.currentModel = self.dataSource[indexPath.row];
//    ShareView *shareView = [ShareView sharedInstance];
//    shareView.guid = self.currentModel.guid;
//    shareView.model = self.currentModel;
//    shareView.shareType = BBQShareTypeDynamic;
////    [shareView showShareViewInViewController:self];
//}
//
//- (void)didClickGiftButtonAtIndexPath:(NSIndexPath *)indexPath {
//    self.currentModel = self.dataSource[indexPath.row];
//    [self performSegueWithIdentifier:@"DynamicToGiftSegue"
//                              sender:self.currentModel.guid];
//}
//
//- (void)didClickPhoto:(UIImageView *)photo
//          atIndexPath:(NSIndexPath *)indexPath
//              atIndex:(NSInteger)index {
//    self.currentModel = self.dataSource[indexPath.row];
//    [self dismissPopupMenu];
//    NSMutableArray *photos = [NSMutableArray array];
//    NSMutableString *movieURL = [NSMutableString string];
//    for (AttachModel *model in self.currentModel.attachinfo) {
//        if ([model.itype isEqualToNumber:@ATTACH_TYPE_VIDEO]) {
//            movieURL = [NSMutableString stringWithString:model.filepath];
//            continue;
//        }
//        MJPhoto *photo = [[MJPhoto alloc] init];
//        photo.url = [NSURL URLWithString:model.filepath];
//        [photos addObject:photo];
//    }
//    if (movieURL.length >0) {
//        BBQMoviePlayerViewController *moviePlayer = [[BBQMoviePlayerViewController alloc] init];
//        //设置视频播放URL
//        moviePlayer.movieURL = [NSURL URLWithString:movieURL];;
//        //然后播放就OK了
//        [moviePlayer readyPlayer];
//        
//        [self presentViewController: moviePlayer animated:YES completion:nil];
//    }else{
//        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//        browser.currentPhotoIndex = index;
//        browser.photos = photos;
//        [browser show];
//    }
//}
//
//- (void)didLongPressCommentLabelAtIndexPath:(NSIndexPath *)indexPath
//                                    atIndex:(NSInteger)index {
//    self.commentDynamic = self.dataSource[indexPath.row];
//    CommentModel *commentModel =
//    ((DynaModel *)self.dataSource[indexPath.row]).reply[index];
//    if ([CheckTools
//         checkAuthorityWithDynamicModel:self.dataSource[indexPath.row]] ||
//        [commentModel.uid isEqualToString:TheCurUser.member.uid]) {
//        self.commentDynamic = self.dataSource[indexPath.row];
//        self.indexOfTargetComment = index;
//        
//        [self showPopupMenuAtIndexPath:indexPath atIndex:index];
//    }
//}
//
//- (void)didTapCommentLabelAtIndexPath:(NSIndexPath *)indexPath
//                              atIndex:(NSInteger)index {
//    self.indexOfTargetComment = index;
//    [self dismissPopupMenu];
//    
//    BabyDynamicCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    self.commentIsReply = YES;
//    self.commentSender = cell;
//    self.commentDynamic = self.dataSource[indexPath.row];
//    CommentModel *commentModel = self.commentDynamic.reply[index];
//    NSString *str1 = @"";
//    if (commentModel.groupkey.integerValue == BBQGroupkeyTypeParent) {
//        NSString *relation =
//        [TJYEXLoginUserInfo relationshipLabelText:commentModel.gxid.intValue
//                                           gxname:commentModel.gxname];
//        str1 = [commentModel.baobaoname stringByAppendingString:relation];
//    } else {
//        str1 = commentModel.nickname;
//    }
//    
//    self.inputView.placeHolder = [NSString stringWithFormat:@"回复：%@", str1];
//    [self.inputView notAndBecomeFirstResponder];
//    //#ifdef TARGET_PARENT
//    //    NSString *relation = [TJYEXLoginUserInfo
//    //    relationshipLabelText:commentModel.gxid.intValue
//    //    gxname:commentModel.gxname];
//    //    NSString *str1 = [commentModel.baobaoname
//    //    stringByAppendingString:relation];
//    //#else
//    //    NSString *str1 = commentModel.nickname;
//    //#endif
//}
//
//- (void)didClickUserWithID:(NSString *)ID {
//    [self performSegueWithIdentifier:@"DynamicToUserSegue" sender:ID];
//}
//
//- (void)didClickGiftViewAtIndexPath:(NSIndexPath *)indexPath {
//    self.currentModel = self.dataSource[indexPath.row];
//    [self performSegueWithIdentifier:@"DynamicToReceivedGiftSegue"
//                              sender:@{
//                                       @"crenickname" : self.currentModel.crenickname,
//                                       @"dataSource" : self.currentModel.giftdata,
//                                       @"fbztx" : self.currentModel.fbztx
//                                       }];
//}
//
//- (void)didClickBgViewAtIndexPath:(NSIndexPath *)indexPath {
//    self.currentModel = self.dataSource[indexPath.row];
//    [self performSegueWithIdentifier:@"DynamicToDetailSegue" sender:nil];
//}
//
//- (void)didClickDeleteButtonAtIndexPath:(NSIndexPath *)indexPath {
//    DynaModel *model = self.dataSource[indexPath.row];
//    if (![CheckTools checkAuthorityWithDynamicModel:model]) {
//        [SVProgressHUD showErrorWithStatus:@"没有权限删除本条动态！"];
//    } else {
//        if (kNetworkNotReachability) {
//            [SVProgressHUD showErrorWithStatus:@"网络不给力"];
//        } else {
//            UIAlertView *alert = [UIAlertView
//                                  bk_showAlertViewWithTitle:@"警告"
//                                  message:@"确定删除本条动态？"
//                                  cancelButtonTitle:@"取消"
//                                  otherButtonTitles:@[ @"确定" ]
//                                  handler:^(UIAlertView *alertView,
//                                            NSInteger buttonIndex) {
//                                      if (buttonIndex == 1) {
//                                          if (kNetworkNotReachability) {
//                                              [SVProgressHUD
//                                               showErrorWithStatus:@"网络不给力"];
//                                          } else {
//                                              [self deleteDynamicAtIndexPath:indexPath];
//                                          }
//                                      }
//                                  }];
//            [alert show];
//        }
//    }
//}
//
//- (void)didClickCommentButtonAtIndexPath:(NSIndexPath *)indexPath {
//    if (kNetworkNotReachability) {
//        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
//        return;
//    }
//    if ([self.inputView isAndResignFirstResponder]) {
//        return;
//    }
//    
//    DynaModel *dynamic = self.dataSource[indexPath.row];
//    self.commentDynamic = dynamic;
//    self.commentIsReply = NO;
//    self.commentSender = [self.tableView cellForRowAtIndexPath:indexPath];
//    
//    self.inputView.commentGuid = dynamic.guid;
//    self.inputView.toUser = nil;
//    
//    [self.inputView notAndBecomeFirstResponder];
//}
//
//#pragma mark - PopupMenu
//- (void)dismissPopupMenu {
//    if (self.popupMenu.isVisible) {
//        [self.popupMenu dismissAnimated:YES];
//    }
//}
//
//- (void)showPopupMenuAtIndexPath:(NSIndexPath *)indexPath
//                         atIndex:(NSInteger)index {
//    BabyDynamicCell *cell =
//    (BabyDynamicCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//    CommentView *commentView = cell.commentView.subviews[index];
//    CGRect popoverRect = [self.tableView
//                          convertRect:[cell convertRect:[cell.commentView
//                                                         convertRect:commentView.frame
//                                                         toView:cell]
//                                                 toView:self.tableView]
//                          toView:[self.tableView superview]];
//    [self.popupMenu showInView:self.view targetRect:popoverRect animated:YES];
//}
//
//#pragma mark - Add Dynamic
//- (void)addDynamic:(NSNotification *)notification {
//    Dynamic *model = notification.userInfo[@"model"];
//    if ([model.dtype integerValue] == self.dynamicType) {
//        [self.dataSource insertObject:model atIndex:0];
//        [self.tableView reloadData];
//        [self.tableView
//         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//         atScrollPosition:UITableViewScrollPositionTop
//         animated:YES];
//    }
//}
//
//- (void)updateDynamic:(NSNotification *)notification {
//    DynaModel *aModel = notification.userInfo[@"model"];
//    NSString *guid = notification.userInfo[@"guid"];
//    if ([aModel.dtype integerValue] == self.dynamicType) {
//        [self.dataSource enumerateObjectsUsingBlock:^(DynaModel *model,
//                                                      NSUInteger idx, BOOL *stop) {
//            if ([model.localid isEqualToString:aModel.localid]) {
//                model.guid = guid;
//                [self.tableView reloadData];
//                *stop = YES;
//            }
//        }];
//    }
//}
//
//- (void)handleUpdateDynamicStatusNotification:(NSNotification *)notification {
//    NSDictionary *userInfo = notification.userInfo;
//    [self.dataSource enumerateObjectsUsingBlock:^(DynaModel *model,
//                                                  NSUInteger idx, BOOL *stop) {
//        if ([model.localid isEqualToString:userInfo[@"localid"]]) {
//            DynaModel *model = [AstroDBMng getDynaByLocalId:userInfo[@"localid"]];
//            if (model) {
//                [self.dataSource replaceObjectAtIndex:idx withObject:model];
//            }
//            //            switch ([userInfo[@"status"] integerValue]) {
//            //                case DYNA_UPLOADING: {
//            //                    model.upflag = @(DYNA_UPLOADING);
//            //                    model.status = DynaModelStatusUploading;
//            //                } break;
//            //                case DYNA_UPLOAD_FINISH: {
//            //                    model.status = DynaModelStatusLocal;
//            //                    model.guid = userInfo[@"guid"];
//            //                    model.upflag = @(DYNA_NONEED_UPLOAD);
//            //                } break;
//            //                case DYNA_UPLOAD_FAILURE: {
//            //                    model.status = DynaModelStatusError;
//            //                } break;
//            //                default:
//            //                    break;
//            //            }
//            [self.tableView reloadData];
//            *stop = YES;
//        }
//    }];
//}
//
//- (void)handleDeleteDynamicNotification:(NSNotification *)notification {
//    NSDictionary *userInfo = notification.userInfo;
//    [self.dataSource enumerateObjectsUsingBlock:^(DynaModel *model,
//                                                  NSUInteger idx, BOOL *stop) {
//        if ([model.guid isEqualToString:userInfo[@"guid"]]) {
//            [self.dataSource removeObjectAtIndex:idx];
//            [self.tableView deleteRowsAtIndexPaths:@[
//                                                     [NSIndexPath indexPathForRow:idx inSection:0]
//                                                     ] withRowAnimation:UITableViewRowAnimationNone];
//            *stop = YES;
//        }
//    }];
//}
//
//- (void)handleUploadFailedNotification:(NSNotification *)notification {
//    DynaModel *aModel = notification.userInfo[@"model"];
//    if ([aModel.dtype integerValue] == self.dynamicType) {
//        [self.dataSource enumerateObjectsUsingBlock:^(DynaModel *model,
//                                                      NSUInteger idx, BOOL *stop) {
//            if ([model.localid isEqualToString:aModel.localid]) {
//                [self.tableView reloadData];
//                *stop = YES;
//            }
//        }];
//    }
//}
//
////园长端切换动态
//- (void)masterSwitchDynamic:(NSNotification *)notification {
//    NSDictionary *dicData = notification.userInfo;
//    
//    self.dynamicType = [dicData[@"dtype"] intValue];
//    self.baobaouid = dicData[@"baobaouid"];
//    self.classuid = dicData[@"classuid"];
//    self.schoolid = dicData[@"schoolid"];
//    // NSString *realname = dicData[@"realname"];
//    //设置切换
//    //    self.needsRefreshEntireData = YES;
//    [self refreshEntireData];
//}
//
//#pragma mark - HTTP Request
//- (void)getDynamicWithGuid:(NSString *)guid {
//    [BBQHTTPRequest
//     queryWithType:BBQHTTPRequestTypeGetSpecifyDynamic
//     param:@{
//             @"guid" : guid
//             }
//     successHandler:^(AFHTTPRequestOperation *operation,
//                      NSDictionary *responseObject, bool apiSuccess) {
//         DynaModel *newModel =
//         [[DynaModel alloc] initWithDic:responseObject[@"data"]];
//         [self.dataSource
//          enumerateObjectsUsingBlock:^(DynaModel *_Nonnull model,
//                                       NSUInteger idx, BOOL *_Nonnull stop) {
//              if ([model.guid isEqualToString:newModel.guid]) {
//                  [self.dataSource replaceObjectAtIndex:idx withObject:newModel];
//                  [BizLogic InsertSingleDyna:newModel];
//                  [self.tableView reloadData];
//                  *stop = YES;
//              }
//          }];
//     } errorHandler:nil
//     failureHandler:nil];
//}
//
//- (void)deleteDynamicAtIndexPath:(NSIndexPath *)indexPath {
//    if (!indexPath) {
//        return;
//    }
//    [SVProgressHUD showWithStatus:@"请稍候..."];
//    DynaModel *model = self.dataSource[indexPath.row];
//    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeDeleteDynamic
//                            param:@{
//                                    @"guid" : model.guid
//                                    }
//                   successHandler:^(AFHTTPRequestOperation *operation,
//                                    NSDictionary *responseObject, bool apiSuccess) {
//                       [BizLogic deleteDyna:model];
//                       [self.dataSource removeObjectAtIndex:indexPath.row];
//                       [self.tableView reloadData];
//                       [SVProgressHUD showSuccessWithStatus:@"删除成功"];
//                   }
//                     errorHandler:^(NSDictionary *responseObject) {
//                         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
//                     }
//                   failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
//                       [SVProgressHUD showErrorWithStatus:error.localizedDescription];
//                   }];
//}
//
//- (void)deleteComment {
//    if (kNetworkNotReachability) {
//        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
//        return;
//    }
//    if ([self.inputView isAndResignFirstResponder]) {
//        return;
//    }
//    NSArray *commentArray = self.commentDynamic.reply;
//    NSString *guid = self.commentDynamic.guid;
//    CommentModel *model = commentArray[self.indexOfTargetComment];
//    NSDictionary *param = @{ @"cguid" : model.cguid };
//    [self.commentDynamic.reply removeObjectAtIndex:self.indexOfTargetComment];
//    [self.tableView reloadData];
//    
//    [BBQHTTPRequest
//     queryWithType:BBQHTTPRequestTypeDeleteComment
//     param:param
//     successHandler:^(AFHTTPRequestOperation *operation,
//                      NSDictionary *responseObject, bool apiSuccess) {
//         [self getDynamicWithGuid:guid];
//     } errorHandler:nil
//     failureHandler:nil];
//}
//
//- (void)addComment:(NSDictionary *)param {
//    if (kNetworkNotReachability) {
//        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
//        return;
//    }
//    
//    if (![BBQLoginManager isLogin]) {
//        [SVProgressHUD showErrorWithStatus:@"未登录"];
//        return;
//    }
//    
//    NSMutableDictionary *dic = [param mutableCopy];
//    dic[@"fbztx"] = TheCurUser.member.avartar;
//    dic[@"flag"] = @"0";
//    dic[@"uid"] = TheCurUser.member.uid;
//    dic[@"nickname"] = TheCurUser.member.nickname;
//    CommentModel *newComment = [[CommentModel alloc] initWithDic:dic];
//    
//    [self.commentDynamic.reply insertObject:newComment atIndex:0];
//    [self.tableView reloadData];
//    
//    [BBQHTTPRequest
//     queryWithType:BBQHTTPRequestTypeAddComment
//     param:param
//     successHandler:^(AFHTTPRequestOperation *operation,
//                      NSDictionary *responseObject, bool apiSuccess) {
//         [self getDynamicWithGuid:param[@"guid"]];
//     } errorHandler:nil
//     failureHandler:nil];
//}
//
//- (void)refreshSpecifyData:(NSNotification *)sender {
//    NSDictionary *userInfo = sender.userInfo;
//    
//    DynaModel *newModel = [BizLogic getDynaByGuid:userInfo[@"guid"]];
//    [self.dataSource
//     enumerateObjectsUsingBlock:^(DynaModel *_Nonnull model, NSUInteger idx,
//                                  BOOL *_Nonnull stop) {
//         if ([newModel.guid isEqualToString:model.guid]) {
//             [self.dataSource replaceObjectAtIndex:idx withObject:newModel];
//             [self.tableView reloadData];
//             *stop = YES;
//         }
//     }];
//}
//
//- (void)refreshEntireData {
//    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
//    [self refreshFirst];
//}
//
//- (void)refreshDataWithType:(BBQRefreshType)type {
//    if (self.isRefreshing) {
//        return;
//    }
//
//    
//    NSDictionary *params = [self requestParamsWithRefreshType:type];
//    if (!params) {
//        return;
//    }
//    self.needsRefreshEntireData = NO;
//    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGetDynamic
//                            param:params
//                   successHandler:^(AFHTTPRequestOperation *operation,
//                                    NSDictionary *responseObject, bool apiSuccess) {
//                       NSMutableArray *tempModelArray = [NSMutableArray array];
//                       for (NSDictionary *dic in responseObject[@"data"][@"dynaarr"]) {
//                           DynaModel *model = [[DynaModel alloc] initWithDic:dic];
//                           [tempModelArray addObject:model];
//                       }
//#ifdef TARGET_TEACHER
//                       //老师身份先删除原来的
//                       if (type != BBQRefreshTypePullUp) {
//                           [BizLogic delDyna:@"0"
//                                    classuid:self.classuid
//                                    schoolid:self.schoolid
//                                       dtype:(int)self.dynamicType];
//                       }
//                       
//#elif TARGET_MASTER
//                       //园长身份先删除原来的
//                       if (type != BBQRefreshTypePullUp) {
//                           [BizLogic delDyna:@"0"
//                                    classuid:@"0"
//                                    schoolid:self.schoolid
//                                       dtype:(int)self.dynamicType];
//                       }
//#endif
//                       if (tempModelArray.count) {
//                           //插入数据库
//                           [BizLogic InsertDyna:tempModelArray];
//                           if (type == BBQRefreshTypePullUp) {
//                               [self.dataSource addObjectsFromArray:tempModelArray];
//                           } else {
//                               [self.dataSource removeAllObjects];
//                               [self.dataSource addObjectsFromArray:tempModelArray];
//                           }
//                       } else {
//                           if (type != BBQRefreshTypePullUp) {
//                               [self.dataSource removeAllObjects];
//                           }
//                       }
//                       
//                       dispatch_async(dispatch_get_main_queue(), ^{
//                           [self.tableView reloadData];
//                           if (type == BBQRefreshTypePullUp) {
//                               [self.tableView.infiniteScrollingView stopAnimating];
//                           } else {
//                               [self.pullToRefreshView finishLoading];
//                           }
//                           [self.view endLoading];
//                       });
//                   }
//                     errorHandler:^(NSDictionary *responseObject) {
//                         dispatch_async(dispatch_get_main_queue(), ^{
//                             [self.tableView reloadData];
//                             if (type == BBQRefreshTypePullUp) {
//                                 [self.tableView.infiniteScrollingView stopAnimating];
//                             } else {
//                                 [self.pullToRefreshView finishLoading];
//                             }
//                             [self.view endLoading];
//                         });
//                     }
//                   failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
//                       dispatch_async_on_main_queue(^{
//                           if (type == BBQRefreshTypePullUp) {
//                               //            [self.tableView finishInfiniteScroll];
//                               [self.tableView.infiniteScrollingView stopAnimating];
//                           } else {
//                               [self.pullToRefreshView finishLoading];
//                           }
//                           [self.view endLoading];
//                       });
//                   }];
//}
//
//- (void)clearData {
//    [self.dataSource removeAllObjects];
//    [self.tableView reloadData];
//}
//
//- (void)refreshDataWithTypeOffline:(BBQRefreshType)type {
//    if (self.isRefreshing) {
//        return;
//    }
//    
//    NSString *lastDateLine = @"0";
//    if (type == BBQRefreshTypePullUp) {
//        lastDateLine =
//        [((DynaModel *)self.dataSource.lastObject).graphtime stringValue];
//        if (!lastDateLine || [lastDateLine isEqualToString:@"0"]) {
//            [self.tableView.infiniteScrollingView stopAnimating];
//            return;
//        }
//    }
//    
//    if (self.dataSource.count && type == BBQRefreshTypePullDown) {
//        [self.pullToRefreshView finishLoading];
//        return;
//    }
//    
//    NSArray *tempModelArray;
//#ifdef TARGET_PARENT
//    tempModelArray = [BizLogic getDyna:TheCurBaoBao.uid
//                              classuid:TheCurBaoBao.curClass.classid
//                              schoolid:TheCurBaoBao.curSchool.schoolid
//                                 dtype:(int)self.dynamicType
//                              dateline:[lastDateLine intValue]];
//    
//#elif TARGET_TEACHER
//    
//    tempModelArray = [BizLogic getDyna:@"0"
//                              classuid:self.classuid
//                              schoolid:self.schoolid
//                                 dtype:(int)self.dynamicType
//                              dateline:[lastDateLine intValue]];
//#else
//    if (!TheCurUser.curSchool) {
//        [self.tableView.infiniteScrollingView stopAnimating];
//        [SVProgressHUD showErrorWithStatus:@"没有学校的数据"];
//        return;
//    }
//    
//    tempModelArray = [BizLogic getDyna:self.baobaouid
//                              classuid:self.classuid
//                              schoolid:self.schoolid
//                                 dtype:(int)self.dynamicType
//                              dateline:[lastDateLine intValue]];
//    
//#endif
//    
//    self.needsRefreshEntireData = NO;
//    
//    if (tempModelArray.count) {
//        if (type == BBQRefreshTypePullUp) {
//            [self.dataSource addObjectsFromArray:tempModelArray];
//        } else {
//            [self.dataSource removeAllObjects];
//            [self.dataSource addObjectsFromArray:tempModelArray];
//        }
//    }
//    
//    [self.tableView reloadData];
//    [self.view endLoading];
//    if (type == BBQRefreshTypePullUp) {
//        [self.tableView.infiniteScrollingView stopAnimating];
//    } else {
//        [self.pullToRefreshView finishLoading];
//    }
//}
//
//- (void)stopPullRefreshLoading {
//}
//
//#pragma mark - Navigation
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"DynamicToGiftSegue"]) {
//        GiftViewController *gvc = segue.destinationViewController;
//        gvc.guid = sender;
//    } else if ([segue.identifier isEqualToString:@"DynamicToReceivedGiftSegue"]) {
//        ReceivedGiftViewController *rgvc = segue.destinationViewController;
//        rgvc.guid = self.currentModel.guid;
//        rgvc.dataSource = ((NSDictionary *)sender)[@"dataSource"];
//        rgvc.crenickname = ((NSDictionary *)sender)[@"crenickname"];
//        rgvc.fbztx = ((NSDictionary *)sender)[@"fbztx"];
//    } else if ([segue.identifier isEqualToString:@"DynamicToDetailSegue"]) {
//        DetailViewController *dtvc = segue.destinationViewController;
//        dtvc.dynamicModel = self.currentModel;
//        dtvc.deleteBlock = ^(NSString *guid) {
//            [self.dataSource
//             enumerateObjectsUsingBlock:^(DynaModel *model, NSUInteger idx,
//                                          BOOL *stop) {
//                 if ([model.guid isEqualToString:guid]) {
//                     [self.dataSource removeObject:model];
//                     *stop = YES;
//                 }
//             }];
//            [self.tableView reloadData];
//        };
//    } else if ([segue.identifier isEqualToString:@"DynamicToUserSegue"]) {
//        UserDataShowViewController *vc = segue.destinationViewController;
//        vc.uid = sender;
//    }
//}
//
//- (NSDictionary *)requestParamsWithRefreshType:(BBQRefreshType)type {
//    NSDictionary *params;
//    NSString *lastDateLine = @"0";
//    if (type == BBQRefreshTypePullUp) {
//        lastDateLine =
//        [((DynaModel *)self.dataSource.lastObject).graphtime stringValue];
//        if (!lastDateLine || [lastDateLine isEqualToString:@"0"] ||
//            !self.tableView.infiniteScrollingView.enabled) {
//            //            [self.tableView finishInfiniteScroll];
//            [self.tableView.infiniteScrollingView stopAnimating];
//            return nil;
//        }
//    }
//    
//#ifdef TARGET_PARENT
//    if (!TheCurBaoBao) {
//        return nil;
//    }
//    params = @{
//               @"baobaouid" : TheCurBaoBao.uid,
//               @"classuid" : TheCurBaoBao.curClass.classid,
//               @"schoolid" : TheCurBaoBao.curSchool.schoolid,
//               @"dtype" : @(self.dynamicType),
//               @"type" : @(type),
//               @"dateline" : lastDateLine,
//               @"guid" : ((DynaModel *)self.dataSource.lastObject).guid ?: @"0",
//               };
//#elif TARGET_TEACHER
//    params = @{
//               @"baobaouid" : self.baobaouid ?: @"0",
//               @"classuid" : self.classuid,
//               @"schoolid" : self.schoolid ?: @"0",
//               @"dtype" : @(self.dynamicType),
//               @"type" : @(type),
//               @"dateline" : lastDateLine,
//               @"guid" : ((DynaModel *)self.dataSource.lastObject).guid ?: @"0",
//               };
//    
//#else
//    if (!TheCurUser.curSchool) {
//        [SVProgressHUD showErrorWithStatus:@"没有学校的数据"];
//        [self.tableView.infiniteScrollingView stopAnimating];
//        return nil;
//    }
//    
//    params = @{
//               @"baobaouid" : self.baobaouid ?: @"0",
//               @"classuid" : self.classuid,
//               @"schoolid" : self.schoolid ?: @"0",
//               @"dtype" : @(self.dynamicType),
//               @"type" : @(type),
//               @"dateline" : lastDateLine,
//               @"guid" : ((DynaModel *)self.dataSource.lastObject).guid ?: @"0",
//               };
//    
//#endif
//    return params;
//}
//
//#pragma mark - InputView Delegate
//- (void)messageInputView:(UIMessageInputView *)inputView
//   heightToBottomChanged:(CGFloat)heightToBottom {
//    [UIView animateWithDuration:0.25
//                          delay:0.0f
//                        options:UIViewAnimationOptionTransitionFlipFromBottom
//                     animations:^{
//                         UIEdgeInsets contentInsets =
//                         UIEdgeInsetsMake(0.0, 0.0, heightToBottom, 0.0);
//                         ;
//                         CGFloat msgInputY =
//                         kScreen_Height - heightToBottom - 64 - 20;
//                         
//                         self.tableView.contentInset = contentInsets;
//                         
//                         if ([_commentSender isKindOfClass:[UIView class]] &&
//                             !self.tableView.isDragging && heightToBottom > 60) {
//                             UIView *senderView = _commentSender;
//                             CGFloat senderViewBottom =
//                             [self.tableView convertPoint:CGPointZero
//                                                 fromView:senderView]
//                             .y +
//                             CGRectGetMaxY(senderView.bounds);
//                             CGFloat contentOffsetY =
//                             MAX(0, senderViewBottom - msgInputY);
//                             //            [self hideToolBar:YES];
//                             [self.tableView
//                              setContentOffset:CGPointMake(0, contentOffsetY)
//                              animated:YES];
//                         }
//                     }
//                     completion:nil];
//}
//
//- (void)messageInputView:(UIMessageInputView *)inputView
//                sendText:(NSString *)text {
//    [self sendCommentMessage:text];
//}
//
//#pragma mark - Comment
//- (void)sendCommentMessage:(NSString *)text {
//    NSString *regxname = @"";
//    if (_commentIsReply) {
//        CommentModel *model =
//        (CommentModel *)self.commentDynamic.reply[self.indexOfTargetComment];
//        
//        if (model.groupkey.integerValue == BBQGroupkeyTypeParent) { //家长
//            regxname = [model.baobaoname
//                        stringByAppendingString:[TJYEXLoginUserInfo
//                                                 relationshipLabelText:model.gxid.intValue
//                                                 gxname:model.gxname]];
//        } else {
//            regxname = model.nickname;
//        }
//    }
//#ifdef TARGET_PARENT
//    NSString *gxname =
//    [TJYEXLoginUserInfo relationshipLabelText:TheCurBaoBao.gxid
//                                       gxname:TheCurBaoBao.gxname];
//    NSDictionary *params = @{
//                             @"cguid" : _commentIsReply
//                             ? (((CommentModel *)
//                                 self.commentDynamic.reply[self.indexOfTargetComment])
//                                .cguid)
//                             : @"",
//                             @"guid" : self.commentDynamic.guid,
//                             @"isreplay" : @(_commentIsReply ? 1 : 0),
//                             @"reuid" : @(_commentIsReply ? [((CommentModel *)self.commentDynamic
//                                                              .reply[self.indexOfTargetComment])
//                                                             .uid integerValue]
//                                 : [self.commentDynamic.creuid integerValue]),
//                             @"content" : text,
//                             @"schoolname" : TheCurBaoBao.curSchool.schoolname,
//                             @"classname" : TheCurBaoBao.curClass.className,
//                             @"groupkey" : TheCurUser.member.groupkey,
//                             @"gxid" : TheCurBaoBao.gxid,
//                             @"gxname" : gxname,
//                             @"baobaoname" : TheCurBaoBao.realname,
//                             @"regxname" : regxname
//                             };
//#elif TARGET_TEACHER
//    NSDictionary *params = @{
//                             @"cguid" : _commentIsReply
//                             ? (((CommentModel *)
//                                 self.commentDynamic.reply[self.indexOfTargetComment])
//                                .cguid)
//                             : @"",
//                             @"guid" : self.commentDynamic.guid,
//                             @"isreplay" : @(_commentIsReply ? 1 : 0),
//                             @"reuid" : @(_commentIsReply ? [((CommentModel *)self.commentDynamic
//                                                              .reply[self.indexOfTargetComment])
//                                                             .uid integerValue]
//                                 : [self.commentDynamic.creuid integerValue]),
//                             @"content" : text,
//                             @"schoolname" : TheCurUser.curSchool.schoolname,
//                             @"classname" : TheCurUser.curClass.classname,
//                             @"groupkey" : [NSNumber numberWithInt:TheCurUser.member.groupkey],
//                             @"gxid" : [NSNumber numberWithInt:0],
//                             @"gxname" : @"",
//                             @"baobaoname" : @"",
//                             @"regxname" : regxname
//                             };
//    
//#else
//    NSDictionary *params = @{
//                             @"cguid" : _commentIsReply
//                             ? (((CommentModel *)
//                                 self.commentDynamic.reply[self.indexOfTargetComment])
//                                .cguid)
//                             : @"",
//                             @"guid" : self.commentDynamic.guid,
//                             @"isreplay" : @(_commentIsReply ? 1 : 0),
//                             @"reuid" : @(_commentIsReply ? [((CommentModel *)self.commentDynamic
//                                                              .reply[self.indexOfTargetComment])
//                                                             .uid integerValue]
//                                 : [self.commentDynamic.creuid integerValue]),
//                             @"content" : text,
//                             @"schoolname" : TheCurUser.curSchool.schoolname,
//                             @"classname" : @"",
//                             @"groupkey" : [NSNumber numberWithInt:TheCurUser.member.groupkey],
//                             @"gxid" : [NSNumber numberWithInt:0],
//                             @"gxname" : @"",
//                             @"baobaoname" : @"",
//                             @"regxname" : regxname
//                             };
//    
//#endif
//    [self addComment:params];
//    
//    _commentDynamic = nil;
//    _commentIsReply = NO;
//    _commentSender = nil;
//    //    _commentToUser = nil;
//    self.inputView.toUser = nil;
//    [self.inputView isAndResignFirstResponder];
//}
//
//- (void)hidePopmenu {
//    for (UITableView *cell in self.tableView.visibleCells) {
//        if ([cell isKindOfClass:[BabyDynamicCell class]]) {
//            [(BabyDynamicCell *)cell hidePopmenu];
//        }
//    }
//}
//
//- (void)didReceiveMemoryWarning {
//}
//@end

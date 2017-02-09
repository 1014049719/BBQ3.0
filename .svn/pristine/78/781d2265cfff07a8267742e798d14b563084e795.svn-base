//
//  BBQDynamicTableViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicTableViewController.h"
#import "DetailViewController.h"
#import "BBQBabyHeaderView.h"
#import "BBQBabyMaterialViewController.h"
#import "BBQDynamicCell.h"
#import "BBQDynamicEditViewController.h"
#import "ReceivedGiftViewController.h"
#import "BBQMoviePlayerViewController.h"
#import "CheckTools.h"
#import "GiftViewController.h"
#import "MJPhotoBrowser.h"
#import "NSString+Common.h"
#import "ShareView.h"
#import "UIMessageInputView.h"
#import "UserDataShowViewController.h"
#import <Masonry.h>
#import <QBPopupMenu.h>
#import "CEGuideArrow.h"
#import <UIScrollView+APParallaxHeader.h>
#import <PopMenu.h>
#import "AuthorizationHelper.h"
#import "BBQDualListViewController.h"
#import "WebViewController.h"
#import "BBQPublishStatusBar.h"
#import "BBQPublishManager.h"
#import "MHBlurTutorialsViewController.h"

@interface BBQDynamicTableViewController () <BBQDynamicCellDelegate,
UIMessageInputViewDelegate, YYTextKeyboardObserver>

@property(copy, nonatomic) NSNumber *groupType;
@property(strong, nonatomic) BBQBabyHeaderView *headerView;
@property(strong, nonatomic) UIMessageInputView *inputView;
@property(strong, nonatomic) BBQDynamicViewModel *viewModel;
@property(strong, nonatomic) QBPopupMenu *funcMenu;
@property(strong, nonatomic) QBPopupMenu *deleteMenu;
@property(strong, nonatomic) BBQDynamicCell *commentSender;
@property(strong, nonatomic) Comment *curComment;
@property(strong, nonatomic) Comment *deleteComment;
@property (strong, nonatomic) PopMenu *popMenu;
#ifdef TARGET_MASTER
@property (strong, nonatomic) BBQPublishStatusBar *statusBar;
@property (strong, nonatomic) UIButton *cameraButton;
#endif

//@property (strong, nonatomic) YYTextKeyboardManager *keyboardManager;

@end

@implementation BBQDynamicTableViewController

#pragma mark - Life Cycle
#ifdef TARGET_MASTER
+ (instancetype)viewControllerForMasterTab {
    BBQDynamicTableViewController *vc = [[BBQDynamicTableViewController alloc] initWithViewModel:[BBQDynamicViewModel viewModelWithObject:TheCurUser.curSchool]];
    return vc;
}
#endif

- (instancetype)initWithViewModel:(BBQDynamicViewModel *)viewModel {
    if (self = [super init]) {
        _viewModel = viewModel;
        _viewModel.viewController = self;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    if (self.viewModel.baobaouid && ![self.viewModel.baobaouid isEqualToNumber:@0] && self.viewModel.groupType == BBQDynamicGroupTypeBaby) {
        [self.tableView addParallaxWithView:self.headerView
                                  andHeight:CGRectGetHeight(self.headerView.frame)];
        [self.tableView.parallaxView.shadowView removeFromSuperview];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //    _keyboardManager = [YYTextKeyboardManager defaultManager];
    //    [_keyboardManager addObserver:self];
    self.view.backgroundColor = UIColorHex(f5f5f5);
    self.tableView.dataSource = self.viewModel;
    self.tableView.delegate = self;
    self.viewModel.viewController = self;
    self.tableView.backgroundColor = UIColorHex(f5f5f5);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.statefulDelegate = self.viewModel;
    self.inputView.delegate = self;
    self.canLoadMore = NO;
    [self.tableView registerClass:[BBQDynamicCell class]
           forCellReuseIdentifier:kDynamicCellIdentifier];
    if (_headerView) {
        [_headerView updateView];
    }
#ifdef TARGET_MASTER
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_baby_list"] style:UIBarButtonItemStylePlain target:self action:@selector(selectDynamic)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cameraButton];
    @weakify(self)
    [[BBQLoginManager sharedManager] bk_addObserverForKeyPath:@"curUser.curSelection" options:NSKeyValueObservingOptionNew task:^(id obj, NSDictionary *change) {
        @strongify(self)
        if (change[@"new"] && ![change[@"new"] isEqual:[NSNull null]]) {
            BBQDynamicViewModel *viewModel = [BBQDynamicViewModel viewModelWithObject:change[@"new"]];
            self.viewModel = viewModel;
        }
    }];
    
    [self bk_addObserverForKeyPath:@"viewModel" options:NSKeyValueObservingOptionNew task:^(id obj, NSDictionary *change) {
        @strongify(self)
        self.tableView.dataSource = self.viewModel;
        [self.tableView reloadData];
        self.viewModel.viewController = self;
        self.statefulDelegate = self.viewModel;
        [self triggerInitialLoad];
    }];
    
    [self.view addSubview:self.statusBar];
#endif
    [self triggerInitialLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#ifdef TARGET_MASTER
    self.navigationItem.title = self.viewModel.navTitle;
#endif
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tableView.showsVerticalScrollIndicator = YES;
    if (self.inputView) {
        [self.inputView prepareToShow];
    }
#ifdef TARGET_MASTER
    if (TheCurUser.didFinishAD && [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showTutorial];
    }
#endif
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[ShareView sharedInstance] dismiss];
    if ([CEGuideArrow sharedGuideArrow].isDisplayed) {
        [[CEGuideArrow sharedGuideArrow] removeAnimated:YES];
    }
    self.tableView.showsVerticalScrollIndicator = NO;
    if (_inputView) {
        [_inputView prepareToDismiss];
    }
    [_funcMenu dismissAnimated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Tabel View Delegate
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel handleDateViewForCell:cell atIndexPath:indexPath];
}

#pragma mark - Scroll view delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        [_inputView isAndResignFirstResponder];
        [_funcMenu dismissAnimated:YES];
    }
}
//
//- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
////    CGRect aRect = [kKeyWindow convertRect:_commentSender.frame
////                          fromViewOrWindow:_commentSender.superview];
//    CGRect aRect = self.tableView.frame;
//
//    if (transition.fromVisible) {
//        self.tableView.contentInset = UIEdgeInsetsMake(225, 0, 60, 0);;
//    } else if (transition.toVisible) {
//        self.tableView.contentInset = UIEdgeInsetsMake(225, 0, transition.toFrame.size.height + 50, 0);
//        aRect.size.height -= (transition.toFrame.size.height + 50);
//        if (!CGRectContainsPoint(aRect, CGPointMake(0, _commentSender.bottom))) {
//            [self.tableView scrollRectToVisible:_commentSender.frame animated:YES];
//        }
//    }
//}

#pragma mark - Dynamic Cell Delegate
- (void)didClickUserWithID:(NSNumber *)uid {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    UserDataShowViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"UserInfo"];
    vc.uid = uid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cell:(BBQDynamicCell *)cell didClickMediaAtIndex:(NSInteger)index {
    Dynamic *dynamic = cell.dynamic;
    if (index == 0 &&
        ((Attachment *)dynamic.attachinfo.firstObject).itype.integerValue ==
        BBQAttachmentTypeVideo) {
        Attachment *attachment = dynamic.attachinfo.firstObject;
        
        if ([[UIApplication sharedApplication] canOpenURL:attachment.filepathURL]) {
            BBQMoviePlayerViewController *vc = [BBQMoviePlayerViewController new];
            vc.movieURL = attachment.filepathURL;
            [vc readyPlayer];
            [self.navigationController presentViewController:vc
                                                    animated:YES
                                                  completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:@"视频数据错误"];
        }
    } else {
        NSMutableArray *photos = [NSMutableArray array];
        for (Attachment *model in dynamic.attachinfo) {
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [model filepathURL];
            [photos addObject:photo];
        }
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = index;
        browser.photos = photos;
        [browser show];
    }
}

- (void)didClickShareButtonWithCell:(BBQDynamicCell *)cell {
    Dynamic *dynamic = cell.dynamic;
    if (!dynamic || !dynamic.guid)
        return;
    ShareView *shareView = [ShareView sharedInstance];
    shareView.model = cell.dynamic;
    shareView.guid = cell.dynamic.guid;
    shareView.shareType = BBQShareTypeDynamic;
    [shareView showShareView];
}

- (void)didClickFuncButton:(UIButton *)button withCell:(BBQDynamicCell *)cell {
    Dynamic *dynamic = cell.dynamic;
    switch (dynamic.uploadState) {
        case BBQDynamicUploadStateSuccess: {
            if (![TheCurUser checkAuthorityWithDynamicModel:cell.dynamic]) {
                CheckNetwork
                self.viewModel.curDynamic = dynamic;
                Comment *newComment =
                [Comment commentWithDynamic:dynamic comment:nil];
                _curComment = newComment;
                _commentSender = cell;
                self.inputView.placeHolder = @"添加评论";
                [_inputView notAndBecomeFirstResponder];
            } else {
                _commentSender = cell;
                Dynamic *dynamic = cell.dynamic;
                self.viewModel.curDynamic = dynamic;
                Comment *newComment =
                [Comment commentWithDynamic:dynamic comment:nil];
                _curComment = newComment;
                self.inputView.placeHolder = @"添加评论";
                CGRect rect = [self.parentViewController.view convertRect:button.frame
                                                         fromViewOrWindow:button.superview];
                NSMutableArray *items = [NSMutableArray array];
                QBPopupMenuItem *deleteItem = [QBPopupMenuItem
                                               itemWithTitle:@"删除"
                                               image:[UIImage imageNamed:@"detail_menu_delete"]
                                               target:self
                                               action:@selector(deleteDynamic)];
                QBPopupMenuItem *editItem =
                [QBPopupMenuItem itemWithTitle:@"编辑"
                                         image:[UIImage imageNamed:@"dynamic_edit"]
                                        target:self
                                        action:@selector(editDynamic)];
                QBPopupMenuItem *commentItem =
                [QBPopupMenuItem itemWithTitle:@"评论"
                                         image:[UIImage imageNamed:@"pop_reply"]
                                        target:_inputView
                                        action:@selector(notAndBecomeFirstResponder)];
                [items addObjectsFromArray:@[ deleteItem, editItem, commentItem ]];
                if (cell.dynamic.ispajs.integerValue != 0) {
                    [items removeObjectAtIndex:1];
                }
                _funcMenu = [[QBPopupMenu alloc] initWithItems:items];
                _funcMenu.arrowSize = 0;
                _funcMenu.cornerRadius = 5;
                _funcMenu.height = 34;
                _funcMenu.arrowDirection = QBPopupMenuArrowDirectionRight;
                [_funcMenu showInView:self.parentViewController.view targetRect:rect animated:YES];
            }
            break;
        }
        case BBQDynamicUploadStateWaiting:
        case BBQDynamicUploadStateFail: {
            _commentSender = cell;
            self.viewModel.curDynamic = dynamic;
            CGRect rect = [self.parentViewController.view convertRect:button.frame
                                                     fromViewOrWindow:button.superview];
            QBPopupMenuItem *deleteItem = [QBPopupMenuItem
                                           itemWithTitle:@"删除"
                                           image:[UIImage imageNamed:@"detail_menu_delete"]
                                           target:self
                                           action:@selector(deleteDynamic)];
            _funcMenu = [[QBPopupMenu alloc] initWithItems:@[deleteItem]];
            _funcMenu.arrowSize = 0;
            _funcMenu.cornerRadius = 5;
            _funcMenu.height = 34;
            _funcMenu.arrowDirection = QBPopupMenuArrowDirectionRight;
            [_funcMenu showInView:self.parentViewController.view targetRect:rect animated:YES];
            break;
        }
        case BBQDynamicUploadStateUploading: {
            [SVProgressHUD showInfoWithStatus:@"动态正在上传中，请稍候..."];
            break;
        }
    }
}

- (void)cell:(BBQDynamicCell *)cell
didClickCommentCell:(BBQDynamicCommentCell *)commentCell {
    CheckNetwork
    if (![commentCell.layout.comment.cguid isNotBlank]) return;
    _commentSender = cell;
    Dynamic *dynamic = cell.dynamic;
    Comment *comment = commentCell.layout.comment;
    Comment *newComment =
    [Comment commentWithDynamic:dynamic comment:comment];
    self.curComment = newComment;
    NSString *regxname = @"";
    if (comment.groupkey.integerValue == BBQGroupkeyTypeParent) { //家长
        regxname = [comment.baobaoname
                    stringByAppendingString:[NSString relationshipWithID:comment.gxid gxname:comment.gxname]];
    } else {
        regxname = comment.regxname;
    }
    self.inputView.placeHolder = [NSString stringWithFormat:@"回复 %@", regxname];
    [self.inputView notAndBecomeFirstResponder];
}

- (void)cell:(BBQDynamicCell *)cell
didLongPressCommentCell:(BBQDynamicCommentCell *)commentCell {
    if (![TheCurUser checkAuthorityWithDynamicModel:cell.dynamic] ||
        ![commentCell.layout.comment.cguid isNotBlank])
        return;
    _commentSender = cell;
    CGRect rect = [self.parentViewController.view convertRect:commentCell.frame
                                             fromViewOrWindow:commentCell.superview];
    _deleteComment = commentCell.layout.comment;
    QBPopupMenuItem *deleteItem =
    [QBPopupMenuItem itemWithTitle:@"删除"
                            target:self
                            action:@selector(deleteComment:)];
    _funcMenu = [[QBPopupMenu alloc] initWithItems:@[ deleteItem ]];
    [_funcMenu showInView:self.parentViewController.view targetRect:rect animated:YES];
}

- (void)didClickGiftButtonWithCell:(BBQDynamicCell *)cell {
    self.viewModel.curDynamic = cell.dynamic;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    GiftViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"GiftViewController"];
    vc.dynamic = cell.dynamic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickWhiteSpaceWithCell:(BBQDynamicCell *)cell {
    self.viewModel.curDynamic = cell.dynamic;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    DetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DetailViewVC"];
    vc.dynamic = cell.dynamic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickGiftViewWithCell:(BBQDynamicCell *)cell {
    self.viewModel.curDynamic = cell.dynamic;
    ReceivedGiftViewController *vc = [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil] instantiateViewControllerWithIdentifier:@"ReceivedGiftVC"];
    vc.dynamic = cell.dynamic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickCommentButtonWithCell:(BBQDynamicCell *)cell {
    self.viewModel.curDynamic = cell.dynamic;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    DetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DetailViewVC"];
    vc.dynamic = cell.dynamic;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIMessageInputView Delegate
- (void)messageInputView:(UIMessageInputView *)inputView
                sendText:(NSString *)text {
    _curComment.content = text;
    [self.viewModel addComment:_curComment withDynamic:_commentSender.dynamic];
    [self.inputView isAndResignFirstResponder];
}

- (void)messageInputView:(UIMessageInputView *)inputView
   heightToBottomChanged:(CGFloat)heightToBottom {
    if (heightToBottom) {
        CGFloat originalOffsetY = self.tableView.contentOffset.y;
        CGFloat viewBottom =
        CGRectGetMaxY([kKeyWindow convertRect:_commentSender.frame
                             fromViewOrWindow:_commentSender.superview]);
        CGFloat difference = kScreenHeight - heightToBottom - viewBottom;
        CGFloat newOffsetY = MAX(originalOffsetY - difference,
                                 _headerView ? -_headerView.height : 0);
        [self.tableView setContentOffset:CGPointMake(0, newOffsetY) animated:YES];
    }
}

#pragma mark - Tutorial
#ifdef TARGET_MASTER
- (void)showTutorial {
    MHBlurTutorialsViewController *tutorialsVC =
    [[MHBlurTutorialsViewController alloc] init];
    tutorialsVC.tutorialsType = BBQTutorialsTypeDynamic;
    @weakify(self)
    tutorialsVC.block = ^{
        @strongify(self)
        [self goToDualListWithMediaType:BBQDynamicMediaTypePhoto];
    };
    
    if (kiOS8Later) {
        tutorialsVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        tutorialsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self
         presentViewController:tutorialsVC
         animated:YES
         completion:^{
             [tutorialsVC setAnimations:@[
                                          @{
                                              @"holeRadius" : @(
                                                  self.cameraButton.width / 2.0 + 5),
                                              @"holeCenter" : [NSValue
                                                               valueWithCGPoint:
                                                               CGPointMake(
                                                                           self.cameraButton.centerX,
                                                                           self.cameraButton.centerY +
                                                                           20)]
                                              },
                                          @{
                                              @"holeRadius" : @0,
                                              @"holeCenter" : [NSValue valueWithCGPoint:CGPointZero]
                                              }
                                          ]];
             [tutorialsVC
              setBackgroundColor:[UIColor colorWithWhite:0
                                                   alpha:0.7]];
             [tutorialsVC displayTutorial];
         }];
    } else {
        [self presentViewController:tutorialsVC
                           animated:NO
                         completion:^{
                             [tutorialsVC dismissViewControllerAnimated:
                              NO completion:^{
                                  kKeyWindow.rootViewController
                                  .modalPresentationStyle =
                                  UIModalPresentationCurrentContext;
                                  [self
                                   presentViewController:tutorialsVC
                                   animated:NO
                                   completion:^{
                                       [tutorialsVC setAnimations:@[
                                                                    @{
                                                                        @"holeRadius" : @(
                                                                            self.cameraButton.width /
                                                                            2.0 +
                                                                            5),
                                                                        @"holeCenter" : [NSValue
                                                                                         valueWithCGPoint:
                                                                                         CGPointMake(
                                                                                                     self.cameraButton.centerX,
                                                                                                     self.cameraButton.centerY +
                                                                                                     20)]
                                                                        },
                                                                    @{
                                                                        @"holeRadius" : @(0),
                                                                        @"holeCenter" : [NSValue
                                                                                         valueWithCGPoint:CGPointZero]
                                                                        }
                                                                    ]];
                                       [tutorialsVC
                                        setBackgroundColor:
                                        [UIColor colorWithWhite:0
                                                          alpha:0.7]];
                                       [tutorialsVC displayTutorial];
                                   }];
                                  kKeyWindow.rootViewController
                                  .modalPresentationStyle =
                                  UIModalPresentationFullScreen;
                              }];
                         }];
    }
}
#endif


#pragma mark - Action
-(void)didTapadvertisementImageView{
    WebViewController *WebVcl =
    [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil]
     instantiateViewControllerWithIdentifier:@"WebViewController"];
    WebVcl.url = _headerView.advUrlStr;
    [self.navigationController pushViewController:WebVcl animated:YES];
    
}

- (void)didTapBabyAvatarView {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    BBQBabyMaterialViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"babyMaterialVC"];
    @weakify(self)
    vc.returnCoverImageBlock=^(NSString *urlstr){
        @strongify(self)
        [self.headerView setImageWithURL:[NSURL URLWithString:urlstr] placeholder:[UIImage
                                                                                   imageNamed:@"coverImage.jpg"] options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)showPopMenu {
    NSArray *menuItems = @[
                           [MenuItem itemWithTitle:@"照片" iconName:@"popmenu_photo" index:0],
                           [MenuItem itemWithTitle:@"视频" iconName:@"popmenu_video" index:1],
                           [MenuItem itemWithTitle:@"文字" iconName:@"popmenu_text" index:2],
                           [MenuItem itemWithTitle:@"批量导入照片" iconName:@"popmenu_batch" index:3],
                           //                           [MenuItem itemWithTitle:@"安全求助" iconName:@"popmenu_help" index:4]
                           ];
    if (_popMenu.isShowed) {
        [_popMenu dismissMenu];
        return;
    }
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:kScreen_Bounds items:menuItems];
        _popMenu.perRowItemCount = 3;
        _popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
    }
    
    @weakify(self)
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem){
        @strongify(self)
        switch (selectedItem.index) {
            case 0: {
                //照片
                if (![AuthorizationHelper checkPhotoLibraryAuthorizationStatus]) {
                    return;
                }
                [self goToDualListWithMediaType:BBQDynamicMediaTypePhoto];
            } break;
            case 1: {
                //视频
                if (![AuthorizationHelper checkPhotoLibraryAuthorizationStatus]) {
                    return;
                }
                [self goToDualListWithMediaType:BBQDynamicMediaTypeVideo];
            } break;
            case 2: {
                //文字
                [self goToDualListWithMediaType:BBQDynamicMediaTypeNone];
            } break;
            case 3: {
                //批量
                if (![AuthorizationHelper checkPhotoLibraryAuthorizationStatus]) {
                    return;
                }
                [self goToDualListWithMediaType:BBQDynamicMediaTypeBatch];
            } break;
            case 4: {
                //TODO:安全求助
            } break;
            default:
                break;
        }
    };
    [_popMenu showMenuAtView:kKeyWindow.rootViewController.view];
}

- (void)goToDualListWithMediaType:(BBQDynamicMediaType)type {
    BBQDualListViewController *vc = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"DualListVC"];
    vc.dualListType = BBQDualListTypePublishDynamic;
    vc.mediaType = type;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectDynamic {
    BBQDualListViewController *vc = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"DualListVC"];
    vc.dualListType = BBQDualListTypeCheckDynamic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editDynamic {
    CheckNetwork
    self.viewModel.curDynamic = _commentSender.dynamic;
    UIStoryboard *sb =
    [UIStoryboard storyboardWithName:@"Dynamic" bundle:nil];
    BBQDynamicEditViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"DynamicEditVC"];
    vc.dynamic = _commentSender.dynamic;
    vc.dynamic.reedit = YES;
    vc.dynamic.setDate = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deleteDynamic {
    CheckNetwork
    @weakify(self)
    UIAlertView *alert =
    [UIAlertView bk_showAlertViewWithTitle:@"警告"
                                   message:@"确定删除本条动态？"
                         cancelButtonTitle:@"取消"
                         otherButtonTitles:@[@"确定"]
                                   handler:^(UIAlertView *alertView,
                                             NSInteger buttonIndex) {
                                       @strongify(self)
                                       if (buttonIndex == 1) {
                                           [self.viewModel deleteDynamic:_commentSender.dynamic];
                                       }
                                   }];
    [alert show];
}

- (void)deleteComment:(Comment *)comment {
    CheckNetwork [self.viewModel deleteComment:_deleteComment
                                   withDynamic:_commentSender.dynamic];
}

#pragma mark - Getter & Setter
- (UIMessageInputView *)inputView {
    if (!_inputView) {
        _inputView = [UIMessageInputView
                      messageInputViewWithType:UIMessageInputViewContentTypeTweet];
    }
    return _inputView;
}

- (BBQBabyHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BBQBabyHeaderView alloc] initWithBaby:TheCurBaoBao];
        [_headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBabyAvatarView)]];
        @weakify(self) _headerView.avatarViewClicked = ^{
            @strongify(self)[self didTapBabyAvatarView];
        };
        
        _headerView.advertisementImageViewClick = ^{
            @strongify(self)[self didTapadvertisementImageView];
        };
        
    }
    return _headerView;
}

#ifdef TARGET_MASTER
- (BBQPublishStatusBar *)statusBar {
    if (!_statusBar) {
        _statusBar = [[BBQPublishStatusBar alloc] initWithFrame:CGRectZero];
        _statusBar.width = kScreenWidth;
        _statusBar.height = 34;
        _statusBar.vc = self;
    }
    return _statusBar;
}

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cameraButton.size = CGSizeMake(29, 29);
        [_cameraButton setImage:[UIImage imageNamed:@"nav_take_photo"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(showPopMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}
#endif

@end

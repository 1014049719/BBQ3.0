//
//  BabyPageViewController.m
//  JYEX
//
//  Created by 朱琨 on 15/7/5.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import "BabyPageViewController.h"
#import "BabyRootViewController.h"
#import "RootTabBarController.h"
#import "CardTableViewController.h"
#import "GroupViewController.h"
#import "BBQDynamicViewController.h"
#import "BBQCalendarViewController.h"
#import "BussMng.h"
#import "DynamicCreateTableViewController.h"
#import "AppMacro.h"
#import "CardPreviewController.h"

@interface BabyPageViewController () <UIPageViewControllerDataSource,
                                      UIPageViewControllerDelegate,
                                      UIScrollViewDelegate>

@property(assign, nonatomic) NSInteger currentVCIndex;
@property(strong, nonatomic) BBQDynamicViewController *babyDynamicVC;
@property(strong, nonatomic) BBQDynamicViewController *classDynamicVC;
@property(strong, nonatomic) GroupViewController *groupVC;
@property(strong, nonatomic) BussMng *bussMng;
@property(strong, nonatomic) CardTableViewController *cardVC;
@property(strong, nonatomic) NSArray *managedVCs;
@property(strong, nonatomic) BBQDynamicViewController *schoolDynamicVC;
@property(strong, nonatomic) BBQCalendarViewController *calendarVC;
@property(strong, nonatomic) UIImageView *imgView;
@property(strong, nonatomic) UIImageView *CZSPreview;
@property(strong, nonatomic) UIViewController *displayingViewController;

@end

@implementation BabyPageViewController

// 动画播放时间
static float uploadPhotoRemindTime = 60;

#pragma mark - Life Circel
- (void)viewDidLoad {
  [super viewDidLoad];
  self.delegate = self;
  self.dataSource = self;

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(willLogoutNotification:)
             name:kWillLogoutNotification
           object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(addPhotoRemind:)
                                               name:kNewPhotoRemind
                                             object:nil];

  [self prepareVCs];

  _CZSPreview = [[UIImageView alloc]
      initWithFrame:CGRectMake(3, ViewHeight - 229, ViewWidth / 9,
                               (ViewWidth / 9) * 53 / 50)];
  _CZSPreview.layer.cornerRadius =
      ((ViewWidth / 9) * 53 / 50) / (ViewWidth / 9) / 2;
  _CZSPreview.image = [UIImage imageNamed:@"czspreview"];
  _CZSPreview.userInteractionEnabled = YES;
  UITapGestureRecognizer *tapPreview =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(previewClick)];
  [_CZSPreview addGestureRecognizer:tapPreview];
  [self.view addSubview:_CZSPreview];
}

- (void)previewClick {
  //进入成长书预览
  CardPreviewController *CardPreviewVcl =
      [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil]
          instantiateViewControllerWithIdentifier:@"CardPreviewVcl"];
  CardPreviewVcl.title = @"成长书";
  CardPreviewVcl.accessType = @"从动态进入";
  [self.navigationController pushViewController:CardPreviewVcl animated:YES];
}

- (void)addPhotoRemind:(NSNotification *)notification {

  _CZSPreview.hidden = YES;

  _imgView = [[UIImageView alloc]
      initWithFrame:CGRectMake(-(171 / 2), self.view.frame.size.height - 138,
                               171 / 2, 216 / 2)];
  _imgView.userInteractionEnabled = YES;
  [_imgView becomeFirstResponder];
  _imgView.animationImages =
      [NSArray arrayWithObjects:[UIImage imageNamed:@"exploreAni1"],
                                [UIImage imageNamed:@"exploreAni2"], nil];
  _imgView.animationDuration = 0.5;
  _imgView.animationRepeatCount = 0;
  [_imgView startAnimating];
  [UIView animateWithDuration:1
                   animations:^{
                     _imgView.frame =
                         CGRectMake(0, self.view.frame.size.height - 138,
                                    171 / 2, 216 / 2);
                   }];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(jumpToCreateDyna)];
  [_imgView addGestureRecognizer:tap];
  [NSTimer scheduledTimerWithTimeInterval:uploadPhotoRemindTime
                                   target:self
                                 selector:@selector(stopAnimation)
                                 userInfo:nil
                                  repeats:NO];
  [self.view addSubview:_imgView];
}

- (void)jumpToCreateDyna {
  [self stopAnimation];
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
  DynamicCreateTableViewController *vc =
      [sb instantiateViewControllerWithIdentifier:@"editdyna"];
  vc.itemType = UploadItemTypePhoto;
  // vc.navTitle = self.uploadTitle;
  [(UINavigationController *)self.navigationController pushViewController:vc
                                                                 animated:NO];
}

- (void)stopAnimation {
  [_imgView stopAnimating];
  [_imgView removeFromSuperview];
  _imgView = nil;
  _CZSPreview.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)willLogoutNotification:(NSNotification *)notification {
  [self moveToPageOfIndex:0];
}

#pragma mark - 准备VC
- (void)prepareVCs {
  self.currentVCIndex = 0;

  self.babyDynamicVC =
      [self.storyboard instantiateViewControllerWithIdentifier:@"DynamicVC"];
  self.babyDynamicVC.dynamicType = BBQDynamicTypeBaby;

  self.classDynamicVC =
      [self.storyboard instantiateViewControllerWithIdentifier:@"DynamicVC"];
  self.classDynamicVC.needsRefreshEntireData = YES;
  self.classDynamicVC.dynamicType = BBQDynamicTypeClass;

  self.schoolDynamicVC =
      [self.storyboard instantiateViewControllerWithIdentifier:@"DynamicVC"];
  self.schoolDynamicVC.needsRefreshEntireData = YES;
  self.schoolDynamicVC.dynamicType = BBQDynamicTypeSchool;

  self.cardVC =
      [self.storyboard instantiateViewControllerWithIdentifier:@"CardWebVcl"];

  self.groupVC =
      [self.storyboard instantiateViewControllerWithIdentifier:@"GroupVC"];
  self.groupVC.needsRefreshEntireData = YES;

  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
  self.calendarVC = [sb instantiateViewControllerWithIdentifier:@"CalendarVC"];
  self.calendarVC.needsRefreshEntireData = YES;

  [self setViewControllers:@[ self.babyDynamicVC ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:YES
                completion:nil];
  self.managedVCs = @[
    self.babyDynamicVC,
    self.classDynamicVC,
    self.schoolDynamicVC,
    self.cardVC,
    self.groupVC,
    self.calendarVC
  ];
}

#pragma mark - PageViewControllerDataSource
- (nullable UIViewController *)
               pageViewController:
                   (nonnull UIPageViewController *)pageViewController
viewControllerAfterViewController:(nonnull UIViewController *)viewController {

  _displayingViewController = viewController;
  NSInteger index = [self indexOfController:viewController];

  if (index == NSNotFound) {
    return nil;
  }
  index++;

  if (index == [self.managedVCs count]) {
    return nil;
  }
  return [self.managedVCs objectAtIndex:index];
}

- (nullable UIViewController *)
                pageViewController:
                    (nonnull UIPageViewController *)pageViewController
viewControllerBeforeViewController:(nonnull UIViewController *)viewController {

  _displayingViewController = viewController;
  NSInteger index = [self indexOfController:viewController];

  if ((index == NSNotFound) || (index == 0)) {
    return nil;
  }

  index--;
  return [self.managedVCs objectAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
  if (index == NSNotFound || index < 0 || index > self.managedVCs.count - 1) {
    return nil;
  }
  return self.managedVCs[index];
}

#pragma mark - PageViewControllerDelegate
- (void)pageViewController:(nonnull UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(nonnull NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {

  _displayingViewController = nil;
  if (completed) {
    self.currentVCIndex = [self
        indexOfController:[pageViewController.viewControllers lastObject]];
    if (self.currentVCIndex > 2) {
      _imgView.hidden = YES;
      _CZSPreview.hidden = YES;
    } else {
      _imgView.hidden = NO;
      _CZSPreview.hidden = NO;
    }
    if (self.block) {
      self.block(self.currentVCIndex, 0);
    }
  }
  //
  //    if (completed) {
  //        pageViewController.view.userInteractionEnabled = YES;
  //        self.currentVCIndex = [self.managedVCs
  //        indexOfObject:self.viewControllers[0]];
  //        if (self.block) {
  //            self.block(self.currentVCIndex, 0);
  //        }
  //    }
}

- (void)moveToPageOfIndex:(NSInteger)idx {
  [self setViewControllers:@[ self.managedVCs[idx] ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:NO
                completion:nil];
  self.currentVCIndex = idx;
  if (idx > 2) {
    _CZSPreview.hidden = YES;
    _imgView.hidden = YES;
  } else {
    _CZSPreview.hidden = NO;
    _imgView.hidden = NO;
  }
}

- (NSInteger)indexOfController:(UIViewController *)viewController {
  for (int i = 0; i < self.managedVCs.count; i++) {
    if (viewController == [self.managedVCs objectAtIndex:i]) {
      return i;
    }
  }
  return NSNotFound;
}

#pragma mark - Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat percentX =
      scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);

  NSInteger currentPageIndex = self.currentVCIndex;
  if (_displayingViewController) {
    currentPageIndex = [self indexOfController:_displayingViewController];
  }
  percentX += currentPageIndex - 1;

  //    [self updateNavigationViewWithPercentX:percentX];
}
@end

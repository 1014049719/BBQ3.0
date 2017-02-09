//
//  DynamicPageViewController.m
//  BBQ
//
//  Created by wth on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "DynamicPageViewController.h"
#import "BBQDynamicViewController.h"

@interface DynamicPageViewController () <UIPageViewControllerDelegate,
                                         UIPageViewControllerDataSource>

@property(strong, nonatomic) BBQDynamicViewController *classDynamicVcl;
@property(strong, nonatomic) BBQDynamicViewController *baobaoDynamicVcl;
@property(strong, nonatomic) BBQDynamicViewController *schoolDynamicVcl;

@property(strong, nonatomic) UITableViewController *firstTbcVcl;
@property(strong, nonatomic) UITableViewController *secondTbcVcl;
@property(strong, nonatomic) UITableViewController *thirdTbcVcl;

@property(strong, nonatomic) NSArray *managedVclsArr;
@property(assign, nonatomic) NSInteger currentVclIndex;

@end

@implementation DynamicPageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  self.delegate = self;
  self.dataSource = self;
  self.currentVclIndex = 0;

  UIStoryboard *storyBoard =
      [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];

  self.classDynamicVcl =
      [storyBoard instantiateViewControllerWithIdentifier:@"DynamicVC"];
  self.classDynamicVcl.needsRefreshEntireData = YES;
  self.classDynamicVcl.dynamicType = BBQDynamicTypeClass;

  self.baobaoDynamicVcl =
      [storyBoard instantiateViewControllerWithIdentifier:@"DynamicVC"];
  self.baobaoDynamicVcl.needsRefreshEntireData = YES;
  self.baobaoDynamicVcl.dynamicType = BBQDynamicTypeBaby;

  self.schoolDynamicVcl =
      [storyBoard instantiateViewControllerWithIdentifier:@"DynamicVC"];
  self.schoolDynamicVcl.needsRefreshEntireData = YES;
  self.schoolDynamicVcl.dynamicType = BBQDynamicTypeSchool;

  self.managedVclsArr =
      @[ self.classDynamicVcl, self.baobaoDynamicVcl, self.schoolDynamicVcl ];

  [self setViewControllers:@[ self.classDynamicVcl ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:YES
                completion:nil];

  //    _firstTbcVcl=[storyBoard
  //    instantiateViewControllerWithIdentifier:@"firstContentTabVcl"];
  //    _secondTbcVcl=[storyBoard
  //    instantiateViewControllerWithIdentifier:@"secondContentTabVcl"];
  //    _thirdTbcVcl=[storyBoard
  //    instantiateViewControllerWithIdentifier:@"thirdContentTabVcl"];
  //
  //    self.managedVclsArr=@[_firstTbcVcl,_secondTbcVcl,_thirdTbcVcl];
  //
  //    [self setViewControllers:@[self.firstTbcVcl]
  //    direction:UIPageViewControllerNavigationDirectionForward animated:YES
  //    completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {

  if (index == NSNotFound || index < 0 || index > 2) {
    return nil;
  }
  return self.managedVclsArr[index];
}

- (UIViewController *)pageViewController:
                          (UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {

  return [self viewControllerAtIndex:_currentVclIndex - 1];
}
- (UIViewController *)pageViewController:
                          (UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {

  return [self viewControllerAtIndex:_currentVclIndex + 1];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {

  if (finished && completed) {

    self.currentVclIndex =
        [self.managedVclsArr indexOfObject:self.viewControllers[0]];

    if (self.block) {
      self.block(self.currentVclIndex);
    }
  }
}
//-(void)pageViewController:(UIPageViewController *)pageViewController
//willTransitionToViewControllers:(NSArray *)pendingViewControllers{
//
//
//        self.currentVclIndex = [self.managedVclsArr
//        indexOfObject:self.viewControllers[0]];
//
//        if (self.block) {
//            self.block(self.currentVclIndex);
//        }
//
//}

//传值翻页
- (void)MovetoPageOfIndex:(NSInteger)idx {

  [self setViewControllers:@[ self.managedVclsArr[idx] ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:NO
                completion:nil];
  self.currentVclIndex = idx;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

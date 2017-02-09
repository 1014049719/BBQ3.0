//
//  helpPageViewController.m
//  BBQ
//
//  Created by wth on 15/8/4.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "helpPageViewController.h"
#import "HelpViewController.h"
#import "HelpTableViewController.h"
#import "HelpModel.h"

@interface helpPageViewController () <UIPageViewControllerDelegate,
                                      UIPageViewControllerDataSource>

@property(strong, nonatomic) UITableViewController *firstTbcVcl;
@property(strong, nonatomic) UITableViewController *secondTbcVcl;
@property(strong, nonatomic) UITableViewController *thirdTbcVcl;
@property(strong, nonatomic) UITableViewController *fourTbcVcl;

@property(strong, nonatomic) NSMutableArray *managedVclsArr;

@property(assign, nonatomic) NSInteger currentVclIndex;

// Vcl个数
@property(assign, nonatomic) NSArray *arrHelpData;

//返回上方栏目总数
@property(strong, nonatomic) NSNumber *typenum;

//栏目标题数组
@property(strong, nonatomic) NSArray *LanmuTitleArr;
//详细内容数组
@property(strong, nonatomic) NSArray *detailArr;
//数据源
@property(strong, nonatomic) NSMutableArray *DataMutableArr;

@property(strong, nonatomic) NSMutableArray *dataAry1;
@end

@implementation helpPageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  self.managedVclsArr = [NSMutableArray array];
  self.delegate = self;
  self.dataSource = self;
  self.currentVclIndex = 0;

  _dataAry1 = [NSMutableArray array];
  _DataMutableArr = [NSMutableArray array];

  [self getHelpData];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)getHelpData {

  NSDictionary *params = @{ @"type" : @1 };
  [BBQHTTPRequest
       queryWithType:BBQHTTPRequestTypeGetHelpList
               param:params
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        //上方栏目个数
        self.typenum = responseObject[@"data"][@"num"];

        //内容数组
        NSArray *tempAry = responseObject[@"data"][@"typearr"];
        for (NSDictionary *tempDic in tempAry) {
          NSArray *array = tempDic[@"arrdata"];
          NSMutableArray *dataAry = [NSMutableArray array];
          for (NSDictionary *dicc in array) {
            [dataAry addObject:dicc];
          }
          [_DataMutableArr addObject:dataAry];
        }

        // cell标题数组
        NSMutableArray *titlaArr =
            [NSMutableArray arrayWithCapacity:[self.typenum intValue]];
        NSMutableArray *xiangxiMuArr = [NSMutableArray array];
        if (tempAry && [tempAry isKindOfClass:[NSArray class]] &&
            [tempAry count] > 0) {

          for (NSDictionary *dicSection in tempAry) {
            NSString *typeStr = dicSection[@"type"];
            [titlaArr addObject:typeStr];

            NSArray *xiangxiArr = dicSection[@"arrdata"];
            [xiangxiMuArr addObjectsFromArray:xiangxiArr];
          }

          self.detailArr = xiangxiMuArr;
          self.LanmuTitleArr = titlaArr;

          if (self.LanmuTitleArr > 0) {
            //上方栏目
            self.getTopArrblock(_LanmuTitleArr);
            // pageVcl设置个数
            [self displayHelpData];
          }
        }
        // 刷新tableView
        if (tempAry && [tempAry isKindOfClass:[NSArray class]] &&
            [tempAry count] > 0) {
          dispatch_async(dispatch_get_main_queue(), ^{
                             //                    [self.tableView reloadData];

                         });
        }
      } errorHandler:nil
      failureHandler:nil];
}

// pageVcl设置个数
- (void)displayHelpData {

  [self setDataArr:[self.typenum intValue]];
}

- (void)setDataArr:(int)count {

  for (int i = 0; i < count; i++) {
    HelpTableViewController *vc =
        [self.storyboard instantiateViewControllerWithIdentifier:@"HelpTbVcl"];

    NSArray *ary = _DataMutableArr[i];
    vc.dataSourceArr = [NSMutableArray arrayWithArray:ary];

    [self.managedVclsArr addObject:vc];
  }

  [self setViewControllers:@[ self.managedVclsArr.firstObject ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:YES
                completion:nil];
}

- (UIViewController *)pageViewController:
                          (UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {

  return [self viewControllerAtIndex:self.currentVclIndex - 1];
}
- (UIViewController *)pageViewController:
                          (UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {

  return [self viewControllerAtIndex:self.currentVclIndex + 1];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {

  if (index == NSNotFound || index < 0 || index > [self.typenum intValue] - 1) {
    return nil;
  }
  return self.managedVclsArr[index];
}

#pragma mark - PageViewControllerDelegate

- (void)pageViewController:(nonnull UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(nonnull NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {

  if (finished && completed) {

    self.currentVclIndex =
        [self.managedVclsArr indexOfObject:self.viewControllers[0]];

    if (self.block) {
      self.block(self.currentVclIndex, 0);
    }
  }
}

- (void)moveToPageOfIndex:(NSInteger)idx {

  [self setViewControllers:@[ self.managedVclsArr[idx] ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:NO
                completion:nil];
  self.currentVclIndex = idx;
  NSLog(@".....滑动到。%ld页", (long)idx);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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

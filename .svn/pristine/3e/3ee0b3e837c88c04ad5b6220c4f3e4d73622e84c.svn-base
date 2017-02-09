//
//  WelcomePageViewController.m
//  BBQ
//
//  Created by wth on 15/10/8.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "WelcomePageViewController.h"

#import "WelcomeVcl1.h"
#import "WelcomeVcl2.h"
#import "WelcomeVcl3.h"
#import "WelcomeVcl4.h"

@interface WelcomePageViewController () <UIPageViewControllerDelegate,
                                         UIPageViewControllerDataSource>

@property(strong, nonatomic) NSArray *managedVCs;
@property(assign, nonatomic) NSInteger currentVclIndex;

@property(strong, nonatomic) WelcomeVcl1 *Vcl1;
@property(strong, nonatomic) WelcomeVcl2 *Vcl2;
@property(strong, nonatomic) WelcomeVcl3 *Vcl3;
@property(strong, nonatomic) WelcomeVcl4 *Vcl4;

@end

@implementation WelcomePageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  self.view.backgroundColor = [UIColor grayColor];

  self.delegate = self;
  self.dataSource = self;
  self.currentVclIndex = 0;

  _Vcl1 = [[WelcomeVcl1 alloc] init];
  _Vcl2 = [[WelcomeVcl2 alloc] init];
  _Vcl3 = [[WelcomeVcl3 alloc] init];
  _Vcl4 = [[WelcomeVcl4 alloc] init];

  [self setViewControllers:@[ _Vcl1 ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:YES
                completion:nil];
  self.managedVCs = @[ self.Vcl1, self.Vcl2, self.Vcl3, self.Vcl4 ];
}

#pragma mark - PageViewControllerDataSource
- (nullable UIViewController *)
               pageViewController:
                   (nonnull UIPageViewController *)pageViewController
viewControllerAfterViewController:(nonnull UIViewController *)viewController {

  return [self viewControllerAtIndex:self.currentVclIndex + 1];
}

- (nullable UIViewController *)
                pageViewController:
                    (nonnull UIPageViewController *)pageViewController
viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
  return [self viewControllerAtIndex:self.currentVclIndex - 1];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {

  if (index == NSNotFound || index < 0) {

    return nil;
  }
  if (index > self.managedVCs.count - 1) {

    [self dismissViewControllerAnimated:NO completion:nil];
    return nil;
  }

  return self.managedVCs[index];
}

#pragma mark - PageViewControllerDelegate
- (void)pageViewController:(nonnull UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(nonnull NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {

  if (completed) {
    pageViewController.view.userInteractionEnabled = YES;
    self.currentVclIndex =
        [self.managedVCs indexOfObject:self.viewControllers[0]];

    NSLog(@"。。。。第%ld页。。。", (long)self.currentVclIndex);
  }
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

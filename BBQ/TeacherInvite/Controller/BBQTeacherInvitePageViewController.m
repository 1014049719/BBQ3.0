//
//  BBQTeacherInvitePageViewController.m
//  BBQ
//
//  Created by anymuse on 15/11/27.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQTeacherInvitePageViewController.h"
#import "BBQInviteAuditViewController.h"

@interface BBQTeacherInvitePageViewController ()<UIPageViewControllerDelegate,
UIPageViewControllerDataSource>

@property(strong, nonatomic) BBQInviteAuditViewController *firstTbcVcl;
@property(strong, nonatomic) BBQInviteAuditViewController *secondTbcVcl;
@property(strong, nonatomic) BBQInviteAuditViewController *thirdTbcVcl;

@property(strong, nonatomic) NSArray *managedVclsArr;
@property(assign, nonatomic) NSInteger currentVclIndex;
@end

@implementation BBQTeacherInvitePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    self.currentVclIndex = 0;
    
    self.firstTbcVcl =
    [self.storyboard instantiateViewControllerWithIdentifier:@"InviteAuditViewController"];
    self.firstTbcVcl.inviteType = BBQInviteTypeAudit;
    
    self.secondTbcVcl =
    [self.storyboard instantiateViewControllerWithIdentifier:@"InviteAuditViewController"];
    self.secondTbcVcl.inviteType = BBQInviteTypeAgree;
    
    self.thirdTbcVcl =
    [self.storyboard instantiateViewControllerWithIdentifier:@"InviteAuditViewController"];
    self.thirdTbcVcl.inviteType = BBQInviteTypeRefuse;
    
    self.managedVclsArr =
    @[ self.firstTbcVcl, self.secondTbcVcl, self.thirdTbcVcl ];
    
    [self setViewControllers:@[ self.firstTbcVcl ]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];

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

//传值翻页
- (void)MovetoPageOfIndex:(NSInteger)idx {
    
    [self setViewControllers:@[ self.managedVclsArr[idx] ]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    self.currentVclIndex = idx;
}

@end

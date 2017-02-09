//
//  TeaherMsgViewController.m
//  BBQ
//
//  Created by mwt on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "TeaherMsgViewController.h"
#import "MessageViewController.h"

@interface TeaherMsgViewController ()

@end

@implementation TeaherMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout=UIRectEdgeNone;

    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    MessageViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"MessageTbc"];
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
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

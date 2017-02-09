//
//  aboutViewController.m
//  BBQ
//
//  Created by wth on 15/7/24.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "aboutViewController.h"
#import <UINavigationBar+Awesome.h>
#import <IMYThemeConfig.h>

@interface aboutViewController ()<UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

//导航
@property (strong, nonatomic) UINavigationBar *navBar;

@end

@implementation aboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.bgImgView imy_setImageForKey:@"login_bg"];
    
    //设置导航
    _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    [_navBar lt_setBackgroundColor:[UIColor clearColor]];
    _navBar.translucent = YES;
    _navBar.delegate = self;
    UINavigationItem *backItem = [[UINavigationItem alloc] initWithTitle:@""];
    backItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    UINavigationItem *rightItem = [[UINavigationItem alloc] initWithTitle:@""];
    [_navBar pushNavigationItem:backItem animated:NO];
    [_navBar pushNavigationItem:rightItem animated:NO];
    
    [self.view addSubview:_navBar];

}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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

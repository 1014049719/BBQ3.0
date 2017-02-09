//
//  helpDetailViewController.m
//  BBQ
//
//  Created by wth on 15/8/18.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "helpDetailViewController.h"

@interface helpDetailViewController ()

@property(weak, nonatomic) IBOutlet UIWebView *helpDetailWebView;

@end

@implementation helpDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  NSURLRequest *request = [NSURLRequest
      requestWithURL:
          [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CS_URL_BASE,
                                                          self.urlStr]]];

  [_helpDetailWebView loadRequest:request];
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

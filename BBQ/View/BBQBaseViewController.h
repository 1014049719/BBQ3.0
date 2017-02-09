//
//  BBQBaseViewController.h
//  BBQ
//
//  Created by anymuse on 15/8/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBQBaseViewController : UIViewController

@property (assign, nonatomic) BBQRefreshType refreshType;
@property (assign, nonatomic) BOOL needsRefreshEntireData;
@property (assign, nonatomic) CGRect originalKeyboardRect;
@property (assign, nonatomic) BOOL keyboardShouldShowInScreen;

- (void)deleteSpecifyData:(id)sender;
- (void)insertNewData:(id)sender;
- (void)refreshEntireData;
- (void)refreshSpecifyData:(id)sender;
- (void)clearData;

- (void)tabBarItemClicked;
- (void)loginOutToLoginVC;

+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState;
+ (UIViewController *)analyseVCFromLinkStr:(NSString *)linkStr;
+ (void)presentLinkStr:(NSString *)linkStr;
+ (UIViewController *)presentingVC;
+ (void)presentVC:(UIViewController *)viewController;

@end

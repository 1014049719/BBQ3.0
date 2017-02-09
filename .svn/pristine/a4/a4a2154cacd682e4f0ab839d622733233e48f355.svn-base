//
//  BBQChooseStatusPresenter.h
//  DailyReportDemo
//
//  Created by 朱琨 on 15/10/8.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBQChooseStatusViewInterface.h"
#import "BBQChooseStatusInteractorIO.h"
#import "BBQChooseStatusWireframe.h"
#import "BBQChooseStatusModuleInterface.h"

@interface BBQChooseStatusPresenter : NSObject <BBQChooseStatusInteractorOutput, BBQChooseStatusModuleInterface>

@property (strong, nonatomic) id<BBQChooseStatusInteractorInput> interactor;
@property (strong, nonatomic) BBQChooseStatusWireframe *wireframe;
@property (strong, nonatomic) UIViewController<BBQChooseStatusViewInterface> *userInterface;

- (void)configurePresenterWithUserInterface:(UIViewController<BBQChooseStatusViewInterface>*)userInterface;

@end

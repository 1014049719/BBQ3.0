//
//  BBQDualListViewController.h
//  BBQ
//
//  Created by 朱琨 on 15/12/28.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, BBQDualListType) {
    BBQDualListTypeDailyReport,
    BBQDualListTypePublishDynamic,       // 发表
    BBQDualListTypeCheckDynamic   // 查看
};

@interface BBQDualListViewController : UIViewController

//上传方式
@property (assign, nonatomic) BBQDynamicMediaType mediaType;
@property (assign, nonatomic) BBQDualListType dualListType;
@property (strong, nonatomic) Dynamic *dynamic;

@end

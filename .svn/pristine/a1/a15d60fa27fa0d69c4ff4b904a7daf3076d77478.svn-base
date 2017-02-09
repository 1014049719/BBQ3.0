//
//  RelationshipViewController.h
//  JYEX
//
//  Created by 朱琨 on 15/7/5.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RelationshipModel.h"

/// 选择与宝宝关系回调 (model中保存回传的名字和tag)
typedef void(^RelationshipCallBack)(RelationshipModel *);

@interface RelationshipViewController : BBQBaseViewController

@property (copy, nonatomic) RelationshipCallBack relationshipCallBack;
@property (strong, nonatomic) RelationshipModel *model;

@end

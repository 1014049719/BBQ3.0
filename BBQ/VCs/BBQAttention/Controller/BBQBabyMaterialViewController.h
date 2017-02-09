//
//  BBQBabyMaterialViewController.h
//  BBQ
//
//  Created by anymuse on 15/12/2.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "MTABaseViewController.h"
@class BBQInviteModel;
typedef void (^ReturnCoverImageBlock)(NSString *urlstr);
@interface BBQBabyMaterialViewController : BBQBaseViewController
@property (strong, nonatomic) BBQBabyModel *baby;
@property (strong, nonatomic) BBQInviteModel *inviteModel;
@property (nonatomic, copy) ReturnCoverImageBlock returnCoverImageBlock;
@end

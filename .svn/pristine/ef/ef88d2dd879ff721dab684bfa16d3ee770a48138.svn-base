//
//  BBQInviteAuditCell.h
//  BBQ
//
//  Created by anymuse on 15/11/27.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBQInviteModel,BBQInviteAuditCell;
@protocol BBQInviteAuditCellDelegate <NSObject>

@optional
- (void)inviteAuditCell:(BBQInviteAuditCell *)cell DidClickButton:(BBQInviteModel*)inviteModel status:(NSString *)status;
- (void)inviteAuditCell:(BBQInviteAuditCell *)cell tapIconView:(BBQInviteModel*)inviteModel;

@end
@interface BBQInviteAuditCell : UITableViewCell

@property(nonatomic, strong) BBQInviteModel *curBaobao;
@property (nonatomic, weak) id<BBQInviteAuditCellDelegate> delegate;
@end

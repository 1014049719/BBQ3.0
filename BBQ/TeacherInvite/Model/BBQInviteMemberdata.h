//
//  BBQInviteMemberdata.h
//  BBQ
//
//  Created by anymuse on 15/12/11.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBQInviteMemberdata : NSObject
/** 申请人关系id */
@property (nonatomic, copy) NSString *gxid;
/** 申请人关系名 */
@property (nonatomic, copy) NSString *gxname;
/**申请人呢称 */
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *realname;
/**申请人id */
@property (nonatomic, copy) NSString *uid;
/**申请人姓名 */
@property (nonatomic, copy) NSString *username;
@end

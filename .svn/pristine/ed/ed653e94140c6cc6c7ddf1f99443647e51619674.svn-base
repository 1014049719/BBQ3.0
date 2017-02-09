//
//  User.m
//  BBQ
//
//  Created by 朱琨 on 15/12/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "UserInfo.h"
#import <SSKeychain.h>

@implementation UserInfo

- (NSString *)password {
    return [SSKeychain passwordForService:@"BBQ" account:self.username];
}

@end
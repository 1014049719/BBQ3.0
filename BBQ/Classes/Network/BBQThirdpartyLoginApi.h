//
//  BBQThirdpartyLoginApi.h
//  BBQ
//
//  Created by slovelys on 15/11/20.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQThirdpartyLoginApi : YTKRequest

/*! @brief 用户登录（第三方登陆）
 *
 * @param  authtype     平台类型 1-微信、2-QQ
 * @param  openid       第三方登录返回的openid
 * @param  nickname     第三方用户昵称
 * @param  avartarurl   第三方头像URL
 * @param  access_token 调用接口凭证
 */
- (instancetype)initWithAuthtype:(int)authtype opuser:(NSString *)opuser openid:(NSString *)openid nickname:(NSString *)nickname avartarurl:(NSString *)avartarurl access_token:(NSString *)access_token;

@end

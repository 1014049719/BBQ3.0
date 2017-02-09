//
//  VendorMacro.h
//  JYEX
//
//  Created by mwt on 15/7/9.
//  Copyright (c) 2015年 广州洋基. All rights reserved.
//

#ifndef JYEX_VendorMacro_h
#define JYEX_VendorMacro_h


//信鸽推送

#if TARGET_VERSION_LITE ==3

//园长
#define XINGE_ACCESSID  2200139290
#define XINGE_ACCESSKEY @"IYU16TIU657W"

#elif TARGET_VERSION_LITE ==2

//老师
#define XINGE_ACCESSID  2200139289
#define XINGE_ACCESSKEY @"I5D2I2YR7M9P"

#elif TARGET_VERSION_LITE ==1

 
//家长
#define XINGE_ACCESSID  2200139288
#define XINGE_ACCESSKEY @"I3WB996Q6DGJ"

#endif


//微信支付 appid

#if TARGET_VERSION_LITE ==3

//园长
#define WX_APPID  @"wxf5133e611bdcdd51"

#elif TARGET_VERSION_LITE ==2

//老师
#define WX_APPID  @"wx386df99c42566232"

#elif TARGET_VERSION_LITE ==1

//家长
#define WX_APPID  @"wxe234d2c01d032d6a"
//@"wx61dbed8f0fec95f8"


#endif



#endif

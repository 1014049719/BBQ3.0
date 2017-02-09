//
//  DES.h
//  XF_BusinessCard
//
//  Created by MaYing on 15/5/14.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CommonCrypto/CommonCryptor.h>

@interface DES : NSObject
//+ (NSString *)encryptWithText:(NSString *)sText key:(NSString *)key;//加密
//+ (NSString *)decryptWithText:(NSString *)sText key:(NSString *)key;//解密

//+ (NSString *) md5:(NSString *)str;
+ (NSString *) doCipher:(NSString *)sTextIn key:(NSString *)sKey context:(CCOperation)encryptOrDecrypt;
+ (NSString *) encryptStr:(NSString *) str;
+ (NSString *) decryptStr:(NSString *) str;

#pragma mark Based64
+ (NSString *) encodeBase64WithString:(NSString *)strData;
+ (NSString *) encodeBase64WithData:(NSData *)objData;
+ (NSData *) decodeBase64WithString:(NSString *)strBase64;

@end

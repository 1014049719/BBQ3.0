//
//  ObjEncrypt.h
//  NoteBook
//
//  Created by xpbhere on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define ENCRYPT_SUCCESS             0
#define ENCRYPT_ERR_MASTERKEY       -1
#define ENCRYPT_ERR_PASSWORD        -2
#define ENCRYPT_ERR_PROCESS         -3
#define ENCRYPT_ERR_INVALID_PARAM   -4

#define HI_BYTE(a) (a>>4)
#define LW_BYTE(a) (a & 0x0F)
#define MK_BYTE(a, b) ((a << 4) + (b & 0x0F))
#define H2S(a) (a <= 9 ? a + 0x30 : a + 0x41 - 0x0A)
#define S2H(a) (a <= 0x39 ? a - 0x30 : (a <= 0x46 ? a - 0x41 + 0x0A : a - 0x61 + 0x0A)) 
#define TEST_BCD(a) (a < 0x30 ? 0 : (a < 0x3A ? 1 : (a < 0x41 ? 0 : (a < 0x47 ? 1 : (a < 0x61 ? 0 : (a < 0x67 ? 1 : 0))))))

@interface ObjEncrypt : NSObject {
}

+(int) TranslateWorkKey:(unsigned char *)pszWorkKey pwd:(const char *)Pwd;
+(int) MD5:(unsigned char *)pszSrcBuf len:(int)len md5:(unsigned char *)pszMD5;
+(int) StrToBCD:(char *)chBuf dest:(unsigned char *)ucBuf left:(unsigned char)ucLeft;

// 强加密解密
+(int) EncryptItem:(const char*)src srclen:(int)srclen dst:(char **)dst dstlen:(int*)dstlen pwd:(const char *)pwd;
+(int) DecryptItem:(unsigned char *)data len:(int)len pwd:(const char *)pwd outdata:(unsigned char **)outdata outlen:(int*)outlen;
+(int) EncryptItemEx:(const char *)src srclen:(int)srclen dst:(char **)dst dstlen:(int *)dstlen pwd:(const char *)pwd;
+(int) DecryptItemEx:(unsigned char *)data len:(int)len pwd:(const char *)pwd outdata:(unsigned char **)outdata outlen:(int*)outlen;

@end


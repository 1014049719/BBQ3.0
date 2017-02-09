//
//  ObjEncrypt.cpp
//  NoteBook
//
//  Created by xpbhere on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ObjEncrypt.h"
#import "Common.h"
#import "PFunctions.h"
//#import "EncryptMD5.h"
#import "CommonDefine.h"

@implementation ObjEncrypt

+(int) TranslateWorkKey:(unsigned char *)pszWorkKey pwd:(const char *)Pwd {
    if (pszWorkKey != NULL && Pwd != NULL) {
        
        char szMd5Resule[32];
        memset(szMd5Resule, 0, 32);
        
        int pwdlen = strlen(Pwd);
        char *pszMd5Src = new char[pwdlen];
        memcpy(pszMd5Src, Pwd, pwdlen);
        MD5_GetMD5a(pszMd5Src, pwdlen, szMd5Resule);
        
        char masterkey[64];
        memset(masterkey, 0, 64);
        //[Business getMasterKey:masterkey];  //要加上这句
        
        if (DES_Encrypt2(szMd5Resule, (char *)pszWorkKey, (char *)masterkey, WORK_KEY_LEN) != 1) {
            SAFE_DELETE(pszMd5Src);
            return ENCRYPT_ERR_PROCESS;
        }
        SAFE_DELETE(pszMd5Src);
    }  
    else {
        return ENCRYPT_ERR_INVALID_PARAM;
    }
    return ENCRYPT_SUCCESS;
}

+(int) MD5:(unsigned char *)pszSrcBuf len:(int)len md5:(unsigned char *)pszMD5 {
    unsigned char ucDataHashStr[2 * 16 + 1];
    memset(ucDataHashStr, 0, sizeof(ucDataHashStr));
    MD5_GetMD5a((char *)pszSrcBuf, len, (char *)ucDataHashStr);
    if ([ObjEncrypt StrToBCD:(char *)ucDataHashStr dest:pszMD5 left:0] == -1) {
        return ENCRYPT_ERR_PROCESS;
    }
    return ENCRYPT_SUCCESS;
}


/******************************************************
 函数功能：将字符串转化为BCD码，
 ucLeft = 0x01 "123"->0x0123; "1234" -> 0x12 0x34
 ucLeft = 0x00 "123"->0x1230; "1234" -> 0x12 0x34
 输入参数：
 chBuf为输入字符串，以null结尾÷
 ucLeft 位数不足是否左补0，0x00 标识右补0 0x01标识左补0 
 输出参数：
 ucBuf 输出BCD
 返回值：返回BCD数组长度 -1标识失败 
 ******************************************************/
+(int) StrToBCD:(char *)chBuf dest:(unsigned char *)ucBuf left:(unsigned char)ucLeft
{
	int				i,j;
	unsigned char	ucHigh, ucLow;
    
	j	= 0;
	i	= 0;
	if (strlen(chBuf) % 2 != 0)
	{
		if (ucLeft == 0x01)
		{
			ucHigh		= 0x00;
			if (TEST_BCD(chBuf[i]))
			{
				ucLow	= S2H(chBuf[i]);
			}
			else
			{
				ucLow	= 0x00;
			}
			ucBuf[j++]	= MK_BYTE(ucHigh, ucLow);
			i ++;
		}
	}
	while (i < (int)strlen(chBuf))
	{
		if (TEST_BCD(chBuf[i]))
		{
			ucHigh	= S2H(chBuf[i]);
		}
		i++;
        
		if (i < (int)strlen(chBuf))
		{
			if (TEST_BCD(chBuf[i]))
			{
				ucLow	= S2H(chBuf[i]);
			}
			i++;
		}
		else
		{
			ucLow	= 0x00;
		}
		ucBuf[j++]	= MK_BYTE(ucHigh, ucLow);
	}
	return j;
}

// 强加密加密
+(int) EncryptItem:(const char*)src srclen:(int)srclen dst:(char **)dst dstlen:(int*)dstlen pwd:(const char *)pwd {
    if (src != NULL && srclen != 0 && dst != NULL && dstlen != NULL) {
        *dstlen = ((srclen - 1) / 4 + 1) * 4 + 4 + 8;
        unsigned char *pszOutBuf = new unsigned char[*dstlen];
        unsigned char *pszTempBuf = new unsigned char[*dstlen];
        memcpy(pszTempBuf + 8, src, srclen);
        [CommonFunc createCheckBlock:pszTempBuf len:8];
        
        int totallen = srclen + 8;
        
        int pwdlen = strlen(pwd) + 1;
        char *workkey = new char[pwdlen];
        memset(workkey, 0, pwdlen);
        [ObjEncrypt TranslateWorkKey:(unsigned char *)workkey pwd:pwd];
        
        if (![CommonFunc encrypt_Tea:pszTempBuf len:totallen buf:pszOutBuf outLen:dstlen key:(unsigned char *)workkey]) {
            SAFE_DELETE(workkey);
            SAFE_DELETE(pszTempBuf);
            SAFE_DELETE(pszOutBuf);
            return ENCRYPT_ERR_PROCESS;
        }
        *dst = (char *)pszOutBuf;
        SAFE_DELETE(pszTempBuf);
        SAFE_DELETE(workkey);
    }
    else {
        return ENCRYPT_ERR_INVALID_PARAM;
    }
    return ENCRYPT_SUCCESS;
}

// 强加密解密
+(int) DecryptItem:(unsigned char *)data len:(int)len pwd:(const char *)pwd outdata:(unsigned char **)outdata outlen:(int*)outlen {
    if (data != NULL && len != 0 && pwd != NULL) {
        
        int pwdlen = strlen(pwd) + 1;
        char *workkey = new char[pwdlen];
        memset(workkey, 0, pwdlen);
        [ObjEncrypt TranslateWorkKey:(unsigned char *)workkey pwd:pwd];
        
        int destlen = len;
        unsigned char *pszDestBuf = new unsigned char[destlen];
        if (![CommonFunc decrypt_Tea:data len:len buf:pszDestBuf outLen:&destlen key:(unsigned char *)workkey]) {
            if (![CommonFunc VerifyCheckBlock:pszDestBuf len:8]) {
                SAFE_DELETE(pszDestBuf);
                SAFE_DELETE(workkey);
                // 密码错误
                return ENCRYPT_ERR_PASSWORD;
            }
            else {
                SAFE_DELETE(pszDestBuf);
                SAFE_DELETE(workkey);
                return ENCRYPT_ERR_PROCESS;
            }
        }
        
        if (![CommonFunc VerifyCheckBlock:pszDestBuf len:8]) {
            SAFE_DELETE(workkey);
            SAFE_DELETE(pszDestBuf);
            return ENCRYPT_ERR_PASSWORD;
        }
        
        SAFE_DELETE(workkey);
        
        *outlen = destlen;
        *outdata = pszDestBuf;
    }
    else {
        return ENCRYPT_ERR_INVALID_PARAM;
    }
    return ENCRYPT_SUCCESS;
}

// 弱加密加密
+(int) EncryptItemEx:(const char *)src srclen:(int)srclen dst:(char **)dst dstlen:(int *)dstlen pwd:(const char *)pwd {
    if (src != NULL && srclen != 0 && dst != NULL && dstlen != NULL && pwd != NULL) {
        unsigned char ucFingerPrinter[WORK_KEY_LEN];
        memset(ucFingerPrinter, 0, WORK_KEY_LEN);
        unsigned short MsgLen = sizeof(unsigned short);
        *(unsigned short *)ucFingerPrinter = MsgLen;
        
        unsigned char ucWorkKey[16];
        memset(ucWorkKey, 0, 16);
        const char ucPwd[] = "tes001rj.91.com";
        [ObjEncrypt MD5:(unsigned char *)ucPwd len:sizeof(ucPwd) md5:ucWorkKey];
        
        int printerlen = *(unsigned short *)ucFingerPrinter;
        *dstlen = srclen;
        *dstlen = (((*dstlen + 4 + printerlen + 2 * 16) - 1) / 4 + 1 ) * 4;
        unsigned char *pszOutBuf = new unsigned char[*dstlen];
        unsigned char *pszTempBuf = new unsigned char[*dstlen];
        
        char *workkey = new char[16];
        memset(workkey, 0, 16);
        [ObjEncrypt TranslateWorkKey:(unsigned char *)workkey pwd:pwd];
        
        memcpy(pszTempBuf, workkey, 16);
        
        SAFE_DELETE(workkey);
        
        memcpy(pszTempBuf + 16, ucFingerPrinter, printerlen);
        
        memcpy(pszTempBuf + 16 + printerlen, src, srclen);
        
        int totallen = srclen + printerlen + 2 * 16;
        [ObjEncrypt MD5:pszTempBuf len:totallen - 16 md5:pszTempBuf + totallen - 16];
        
        if (![CommonFunc encrypt_Tea:pszTempBuf len:totallen buf:pszOutBuf outLen:dstlen key:ucWorkKey]) {
            SAFE_DELETE(pszTempBuf);
            SAFE_DELETE(pszOutBuf);
            return ENCRYPT_ERR_PROCESS;
        }
        
        *dst = (char *)pszOutBuf;
        SAFE_DELETE(pszTempBuf);  
    }
    else {
        ENCRYPT_ERR_INVALID_PARAM;
    }
    
    return ENCRYPT_SUCCESS;
}

+(int) DecryptItemEx:(unsigned char *)data len:(int)len pwd:(const char *)pwd outdata:(unsigned char **)outdata outlen:(int*)outlen {
    if (data != NULL && len != 0 && pwd != NULL) {
        
        unsigned char ucWorkKey[16];
        memset(ucWorkKey, 0, sizeof(ucWorkKey));
        const char ucPwd[] = "tes001rj.91.com";
        [ObjEncrypt MD5:(unsigned char *)ucPwd len:sizeof(ucPwd) md5:ucWorkKey];
        
        int destlen = len;
        unsigned char *pszDestBuf = new unsigned char[destlen];
        
        if (![CommonFunc decrypt_Tea:data len:len buf:pszDestBuf outLen:&destlen key:ucWorkKey]) {
            return ENCRYPT_ERR_PASSWORD;
        }
        
        unsigned char ucPwdHash[16];
        memcpy(ucPwdHash, pszDestBuf, sizeof(ucPwdHash));
        unsigned short printerlen = *(unsigned short *)(pszDestBuf + 16);
        
        int pwdlen = strlen(pwd) + 1;
        char *workkey = new char[pwdlen];
        memset(workkey, 0, pwdlen);
        [ObjEncrypt TranslateWorkKey:(unsigned char *)workkey pwd:pwd];
    
        if (memcmp(workkey, pszDestBuf, sizeof(workkey)) != 0) {
            SAFE_DELETE(workkey);
            SAFE_DELETE(pszDestBuf);
            return ENCRYPT_ERR_PASSWORD;
        }
        
        unsigned char ucMsgDigest[16];
        [ObjEncrypt MD5:pszDestBuf len:destlen - 16 md5:ucMsgDigest];
        
        if (memcmp(ucMsgDigest, pszDestBuf + destlen - 16, sizeof(ucMsgDigest)) != 0) {
            SAFE_DELETE(workkey);
            SAFE_DELETE(pszDestBuf);
            return ENCRYPT_ERR_PROCESS;
        }
        
        *outlen = destlen - printerlen - 2 * 16;        
        *outdata = new unsigned char[*outlen];
        memcpy(*outdata, pszDestBuf + printerlen + 16, *outlen);
        
        delete pszDestBuf;
    }
    else {
        return ENCRYPT_ERR_INVALID_PARAM;
    }
    return ENCRYPT_SUCCESS;
}

@end
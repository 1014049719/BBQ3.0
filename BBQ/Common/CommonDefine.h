//
//  Common.h
//  NoteBook
//
//  Created by wangsc on 10-9-16.
//  Copyright 2010 ND. All rights reserved.
//


#define HI_BYTE(a) (a>>4)
#define LW_BYTE(a) (a & 0x0F)
#define MK_BYTE(a, b) ((a << 4) + (b & 0x0F))
#define H2S(a) (a <= 9 ? a + 0x30 : a + 0x41 - 0x0A)
#define S2H(a) (a <= 0x39 ? a - 0x30 : (a <= 0x46 ? a - 0x41 + 0x0A : a - 0x61 + 0x0A)) 
#define TEST_BCD(a) (a < 0x30 ? 0 : (a < 0x3A ? 1 : (a < 0x41 ? 0 : (a < 0x47 ? 1 : (a < 0x61 ? 0 : (a < 0x67 ? 1 : 0))))))



//栏目数据定义
#define LM_BJKJ @"BJKJ"
#define LM_GRKJ @"GRKJ"
#define LM_YEZZB @"YEZZB"
#define LM_CZMYT @"CZMYT"
#define LM_JYZTC @"JYZTC"

//#define LM_JYGT  @"JYGT"  //家园沟通

#define LM_XXKJ LM_GRKJ
#define LM_PM   @"PM"
#define LM_PAJS @"PAJS"

#define LM_CZGS  @"CZGS"
#define LM_FMXT  @"YEZX"
#define LM_QQHK  @"QQHK"
#define LM_CZDA  @"CZDA"


// 常量定义
#define GUID_STR_LEN            37
#define TIME_STR_LEN            20
#define MAX_LEN_ITEM	        (60 * 1024 * 1024)

#define MAX_MEM_FOR_TCP			(MAX_LEN_ITEM + 1024)
#define START_MEM_FOR_TCP		(MAX_LEN_ITEM / 10 + 1024)

#define MAX_LEN_PIC_DATA        (60 * 1024 * 1024)
#define MAX_LEN_WEB_DATA        (60 * 1024 * 1024)
#define MAX_PATH_DEPTH          6       // 目录树深度
#define MAX_USER_NAME_LEN       128     // 最大用户名长度
#define MAX_USER_PWD_LEN        128     // 最大密码长度
#define GROUP_ID_ALL_USER		0xFFFFFFFF


#define WORK_KEY_LEN			16		// 工作密钥长度
#define MASTER_KEY_LEN			8		// 主密钥长度
#define KEY_TIME_TO_LIVE		255		// 密钥生存时间

#define MAX_TITLE_LEN			(1024 - 1)		//标题最大长度（TCHAR类型，预留一个结束字符）
#define MAX_TAG_LEN				(64 - 1)		//标签最大长度（TCHAR类型，预留一个结束字符）


// 宏定义
#ifndef SAFE_DELETE
#define SAFE_DELETE(p)          do{if ((p) != NULL) {delete (p); (p) = NULL;}}while(0)
#endif


#define SAFE_DELETE_ARRAY(p)     do{if ((p) != NULL) {delete [] (p); (p) = NULL;}}while(0)
#define MySprintf(dst, src)     (sprintf_s(dst, sizeof(dst), _T("%s"), src))
#define LOG_FUNC_CALL()         do { LOG_TRACE_INFO1("调用函数 %s", __FUNCTION__); }while(0)
#define ZeroMemory(Destination,len) memset(Destination, 0x0, len);



#ifndef MESSAGEBOX
#define MESSAGEBOX(mes) { \
UIAlertView *note_alertview_01236423 = [[UIAlertView alloc] initWithTitle:@"提示" \
message:mes \
delegate:nil \
cancelButtonTitle:@"ok" \
otherButtonTitles:nil]; \
[note_alertview_01236423 show]; \
[note_alertview_01236423 release]; \
}
#endif


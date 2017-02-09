/************************************************************************************
 * 
 *  @file 
 *  @brief            共通信息定义头文件
 * Default
 *  <b>文件名</b>      : TypeDef.h
 *  @n@n<b>版权所有</b>: 网龙天晴程序部应用软件开发组
 *  @n@n<b>作  者</b>  : 李学锋
 *  @n@n<b>创建时间</b>: 2010-1-6 15:29:42
 *  @n@n<b>文件描述</b>: 
 *  @version		版本	修改者		  时间		  描述@n
 *  @n		        李学锋        2010-02-25 
 * 
************************************************************************************/
#ifndef _TYPE_DEF_H_
#define _TYPE_DEF_H_

#include <stdio.h>
//#include <string>
//#include "../../AstroToolKit/Json/json.h"
//
//// 自定义接口类型
//#ifndef interface
//#define  interface struct
//#endif

typedef  unsigned int     UINT;

#ifdef WIN32
#pragma warning(disable:4018)
#pragma warning(disable:4996)
#pragma warning(disable:4267)
#pragma warning(disable:4244)
#endif


#ifdef TARGET_IPHONE_SIMULATOR
	#define ACCESS_OUTER_SERVICE  1
#else
	#define ACCESS_OUTER_SERVICE  1
#endif

//
//// 算命数据基类
//interface IAstroData
//{
//	virtual ~IAstroData(){}
//	// 获取类型定义值
//	virtual int GetType() = 0;
//	// 转换为Json值
//	virtual Json::Value ToJsonValue() = 0;
//};

// 定义单件模式
#define DECLARE_SINGLETON_PATTERN_BASE(classname,interfacename) \
	protected: \
		C##classname(); \
	public:\
		static interfacename* GetInstance(); \
		static void ReleaseInstance(); \
	private:\
		static C##classname* m_pSingletonObject;\


// 实现单件模式
#define IMPLEMENT_SINGLETON_PATTERN_BASE(classname,interfacename) \
	C##classname* C##classname::m_pSingletonObject = NULL;\
	interfacename* C##classname::GetInstance() { \
		if (m_pSingletonObject == NULL) { \
			m_pSingletonObject = new C##classname(); \
		}\
		return m_pSingletonObject;\
	}\
	void C##classname::ReleaseInstance() {\
		if (m_pSingletonObject == NULL) {\
			return;\
		}\
		delete m_pSingletonObject;\
		m_pSingletonObject = NULL;\
	}\
    

#define DECLARE_SINGLETON_PATTERN(classname) \
	DECLARE_SINGLETON_PATTERN_BASE(classname,I##classname)

#define IMPLEMENT_SINGLETON_PATTERN(classname) \
	IMPLEMENT_SINGLETON_PATTERN_BASE(classname,I##classname)

#define DECLARE_SINGLETON_PATTERN_NOITF(classname) \
	DECLARE_SINGLETON_PATTERN_BASE(classname,C##classname)

#define IMPLEMENT_SINGLETON_PATTERN_NOITF(classname) \
	IMPLEMENT_SINGLETON_PATTERN_BASE(classname,C##classname)


// 自定义GUID类型
#ifndef GUID_DEFINED
#define GUID_DEFINED
#if defined(__midl)
  typedef struct {
	  unsigned long  Data1;
	  unsigned short Data2;
	  unsigned short Data3;
	  byte           Data4[ 8 ];
  }GUID;
#else
  typedef struct{
	  unsigned long  Data1;
	  unsigned short Data2;
	  unsigned short Data3;
	  unsigned char  Data4[ 8 ];
  }GUID;

#endif

#define REFGUID const GUID &

  static const GUID GUID_NULL =
  { 0x00000000, 0x0000, 0x0000, { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 } };

#endif




// 判断GUID是否相等

#ifndef _WINDOWS_
/*
#ifndef _NO_USER_GUID_
__inline int IsEqualGUID(const GUID & rguid1, const GUID & rguid2)
{
  return !memcmp(&rguid1, &rguid2, sizeof(GUID));
}
#endif
*/

#endif 

#ifndef _NO_USER_GUID_
// 转换GUID到字符串

//2015.2.13 注释
/*
__inline std::string GUID2STR(const GUID& guid)
{
	if (IsEqualGUID(guid,GUID_NULL))
	{
		return "";
	}

	char* szGuid = new char[38];
	memset(szGuid,0,38);
	sprintf(szGuid, "%08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X",
		(UINT)guid.Data1, guid.Data2, guid.Data3,
		guid.Data4[0], guid.Data4[1], guid.Data4[2], guid.Data4[3],
		guid.Data4[4], guid.Data4[5], guid.Data4[6], guid.Data4[7]);
  std::string szGuidStr = std::string(szGuid);
  delete[] szGuid;
	return szGuidStr;
}

// 转换字符串到GUID
__inline GUID STR2GUID(const std::string& guidStr)
{
	GUID guid = GUID_NULL;
	if (guidStr.size() != 36)
	{
		return guid;
	}

	int data1;
	int data2;
	int data3;
	int data4[8];
	sscanf(guidStr.c_str(), "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
		&data1, &data2, &data3,
		&data4[0], &data4[1], &data4[2], &data4[3], &data4[4], &data4[5], &data4[6], &data4[7]);

	guid.Data1 = data1;
	guid.Data2 = data2;
	guid.Data3 = data3;
	guid.Data4[0] = static_cast<char>(data4[0]);
	guid.Data4[1] = static_cast<char>(data4[1]);
	guid.Data4[2] = static_cast<char>(data4[2]);
	guid.Data4[3] = static_cast<char>(data4[3]);
	guid.Data4[4] = static_cast<char>(data4[4]);
	guid.Data4[5] = static_cast<char>(data4[5]);
	guid.Data4[6] = static_cast<char>(data4[6]);
	guid.Data4[7] = static_cast<char>(data4[7]);
	return guid;
}
*/

#endif


//释放内存
//#define SAFE_DELETE(obj)		if(obj){delete obj; obj=nil;}
//#define SAFE_DELETE_ARRAY(obj)	if(obj){delete[] obj; obj=nil;}

#ifndef SAFEFREE_OBJECT
#define SAFEFREE_OBJECT(o) \
if( nil != (o) )\
{\
[(o) release]; \
(o) = nil; \
}
#endif

#ifndef SAFEREMOVEANDFREE_OBJECT
#define SAFEREMOVEANDFREE_OBJECT(o) \
if( nil != (o) )\
{\
[(o) removeFromSuperview];\
[(o) release]; \
(o) = nil; \
}
#endif

#ifndef SAFEREMOVE_OBJECT
#define SAFEREMOVE_OBJECT(o) \
if( nil != (o) )\
{\
[(o) removeFromSuperview];\
(o) = nil; \
}
#endif



//方向
enum ETouchSlideDirection
{
	ETSD_NONE,	//不变
	ETSD_LEFT,	//向左
	ETSD_RIGHT	//向右
};


#endif // end of defined _TYPE_DEF_H_

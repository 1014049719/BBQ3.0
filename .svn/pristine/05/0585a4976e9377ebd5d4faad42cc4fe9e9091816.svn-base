//
//  PubFunction.h
//  EnglishDemo
//  力争各个项目能公用的函数，跟业务无关
//  Created by huanghb on 11-1-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageConst.h"

//#import "logging.h"

//定义常量
#define WINDOW_FRAME [[UIApplication sharedApplication] keyWindow].frame
#define WINDOW_WIDTH [[UIApplication sharedApplication] keyWindow].frame.size.width
#define WINDOW_HEIGHT [[UIApplication sharedApplication] keyWindow].frame.size.height


@interface MsgParam : NSObject
{
	id obsv;
	SEL callback;
	id param1;
	id param2;
	int int1;
	int int2;
}

@property (nonatomic, assign) id obsv; //防止环形引用内存泄露不可改为retain
@property (nonatomic, assign) SEL callback; //防止环形引用内存泄露不可改为retain
@property (nonatomic, retain) id param1;
@property (nonatomic, retain) id param2;
@property (nonatomic, assign) int int1;
@property (nonatomic, assign) int int2;

+ (MsgParam*) param :(id)obsv :(SEL)callback :(id)param1 :(int)int1;

@end




@interface GlobalParamCall : NSObject
{ 
	NSMutableArray *listRefreshCity;
	UIWindow *window;
	UIView  *navFunc; 
	NSString *showType, *item, *item1, *item2;
	NSInteger nItemType, nCurMonth, nCurYear, nCurDay;
	NSString *almanacDesc_selfDate, *almanacDesc_type, *almanacDesc_title;
	UIView *pView, *pView2;
	id obj;
	NSObject *respclass, *respclass2;
    SEL respfunc, respfunc2;  
} 

@property (nonatomic, retain) NSMutableArray *listRefreshCity;
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIView  *navFunc; 
@property (nonatomic, retain) NSString *showType, *item, *item1, *item2;
@property (nonatomic, assign) NSInteger nItemType, nCurMonth, nCurYear, nCurDay;
@property (nonatomic, retain) NSString *almanacDesc_selfDate, *almanacDesc_type, *almanacDesc_title;
@property (nonatomic, retain) UIView *pView, *pView2;
@property (nonatomic, retain) id obj;
@property (nonatomic, assign) NSObject *respclass, *respclass2;
@property (nonatomic, assign) SEL respfunc, respfunc2;  

extern GlobalParamCall *globalParam;

+(void)Init;
+ (void) Free;
@end



@interface PubFunction : NSObject { 
}



#pragma mark -
#pragma mark 控件相关

// 改变按钮的caption
+(void)changeBtnCaption:(UIButton *)btn :(NSString *)caption;

// 获得NIB中的对象
+(id)getObjectFromNib:(NSString *)ANibName :(id)AOwner :(Class)AClass;

//Add 2012-07-09 chenyl
+(BOOL)getLableWithString:(NSString*)content \
lable:(UILabel *)uilable contentfont:(UIFont*)font \
maxsize:(CGSize)maxrect origin:(CGPoint)originpoint;
//End Add 2102-07-09 chenyl

#pragma mark -
#pragma mark 时间相关

//时间格式宏定义
#define CS_DATE_FORMAT_YYMM_DD                                           @"yyyy-MM-dd"
#define CS_DATE_FORMAT_YYMM_DD_HH_mm_ss                                  @"yyyy-MM-dd HH:mm:ss"
#define CS_DATE_FORMAT_YYMM_DD_HH_mm										@"yyyy-MM-dd HH:mm"
#define CS_DATE_FORMAT_YYMM                                              @"yyyy-MM"
#define CS_DATE_STR_FORMAT_YYMM_DD                                       @"%04d-%02d-%02d"
#define CS_DATE_STR_FORMAT_YYMM                                          @"%04d-%02d"
#define CS_DATE_STR_FORMAT_YYMM_DD_HH_mm									@"%04d-%02d-%02d %02d:%02d"

#define CS_DEFAULT_UUID                                                     @"00-00"

+ (BOOL) str2ymd :(NSString*)str :(int*)y :(int*)m :(int*)d;
+ (void) getCurrentTimeYMDW :(NSInteger*)out_year 
							:(NSInteger*)out_month 
							:(NSInteger*)out_day 
							:(NSInteger*)out_weekday;

+ (NSString*) getWeekdayStrENP :(NSInteger)weekday;

//静态方法
+ (int) getHourFromDate:(NSDate *) date;

// 设置时间的偏移
+ (BOOL)makeDateOffset:(NSInteger *)out_year :(NSInteger *)out_month :(NSInteger *)out_day 
                      :(NSInteger)offsetMonth :(NSInteger)offsetDay;

// 将指定格式的日期字符串转换成NSDate
+ (NSDate *)convertString2NSDate:(NSString *)dateStr :(NSString *)formatStr;

// 将指定格式的日期字符串转换成NSString
+ (NSString *)convertString2NSString:(NSString *)dateStr :(NSString *)formatStr;

// 将指定年月日生成NSDate
+ (NSDate *)makeDateByNYR:(NSInteger)year :(NSInteger)month :(NSInteger)day;

// 格式化日期，输入日期与格式化样式，输出字符串
+ (NSString *) formatDateTime2NSStringWithDate :(NSDate *)in_date :(NSString *)in_format;

+ (NSString *) formatDateTime2NSString;

+ (NSString *) formatDate2NSString: (int) offsetDay;

+ (NSString *) formatDateTime2NSString: (int) offsetSecond;

+ (NSString *) formatDate2NSString;

+ (NSString *) formatDate2NSString_YYYYMM;

+ (NSString *) formatDate2NSString_YYMM;

+ (BOOL) isTodayTimeStringYMD:(NSString*)sTime;
+ (BOOL) isTodayTimeString:(NSString*)sTime;	//sTime: yyyy-MM-dd HH:mm:ss

// 解析出输入日期的年月日
+ (void)decodeNSDate: (NSDate *)in_date :(NSInteger *)out_year :(NSInteger *)out_month :(NSInteger *)out_day;
// 解析出输入日期的年月日
+ (void)decodeNSDate: (NSDate *)in_date :(NSInteger *)out_year :(NSInteger *)out_month :(NSInteger *)out_day :(NSInteger *)out_hour :(NSInteger *)out_minute :(NSInteger *)out_second;

+ (int)getSecondToNow: (NSString*)sTime;

+ (int)maxMonthDay:(int)y :(int)m;


#pragma mark -
#pragma mark nsstring相关

+ (NSString *) newUUID;

+ (BOOL) stringIsHanzi: (NSString *) obj;

+ (BOOL) stringIsNullOrEmpty: (NSString *) obj;
+ (BOOL) stringContainYM:(NSString*)str;

+ (NSString *) Base64Encode: (NSData *)data;

+ (NSString *) Base64Encode2: (const char*) inputBuf : (int) inputLen;

+ (NSString *) Base64Decode2: (const char*) inputBuf : (int) inputLen;

+ (NSString*) stringFilterRetainNum:(NSString*)str;

+ (BOOL) strHasStr:(NSString*)str1 :(NSString*)str2; 

#pragma mark -
#pragma mark 转义
+ (NSString *) formatNSString4Sqlite:(NSString *) sou;

+ (NSString *) formatNSString4MySql:(NSString *) sou;

//整型转换为字符串型
#define Int2Str(value) [NSString stringWithFormat:@"%d", value]


#pragma mark -
#pragma mark color

// Convert a 6-character hex color to a UIColor object 
+ (UIColor *) getColor: (NSString *) hexColor alpha:(CGFloat)alphaValue;

+ (UIColor *) getColor: (NSString *) hexColor;

+ (UIColor *) getRandomColor;


#pragma mark -
#pragma mark XXTEA md5

+ (NSString *) getMd5Value: (NSString *) sou;

int xxtea( int * v, int n , int * k );

#pragma mark -
#pragma mark 正则表达式判断

// 正则表达式判断
+(BOOL)RegExpMatch:(NSString *)string withPattern:(NSString*)pattern;

#pragma mark -
#pragma mark 参数传递相关

#define IN_CONDITION_KEY1 @"KEY1"
#define IN_CONDITION_KEY2 @"KEY2"
#define IN_CONDITION_KEY3 @"KEY3"
#define IN_CONDITION_KEY4 @"KEY4"
#define INT2NUM(VALUE) [NSNumber numberWithInt:VALUE]
#define NUM2INT(VALUE) [(NSNumber *)VALUE intValue]
#define BOOL2NUM(VALUE) [NSNumber numberWithBool:VALUE]
#define NUM2BOOL(VALUE) [(NSNumber *)VALUE boolValue]
#define GENERATION_DICT_4_1VALUE(VALUE1) [NSDictionary dictionaryWithObjectsAndKeys:VALUE1, IN_CONDITION_KEY1, nil]
#define GENERATION_DICT_4_2VALUE(VALUE1,VALUE2) [NSDictionary dictionaryWithObjectsAndKeys:VALUE1, IN_CONDITION_KEY1, VALUE2, IN_CONDITION_KEY2, nil]
#define GENERATION_DICT_4_3VALUE(VALUE1,VALUE2,VALUE3) [NSDictionary dictionaryWithObjectsAndKeys:VALUE1, IN_CONDITION_KEY1, VALUE2, IN_CONDITION_KEY2, VALUE3, IN_CONDITION_KEY3, nil]
#define GENERATION_DICT_4_4VALUE(VALUE1,VALUE2,VALUE3,VALUE4) [NSDictionary dictionaryWithObjectsAndKeys:VALUE1, IN_CONDITION_KEY1, VALUE2, IN_CONDITION_KEY2, VALUE3, IN_CONDITION_KEY3, VALUE4, IN_CONDITION_KEY4, nil]

#pragma mark -
#pragma mark 页面跳转消息，消息广播相关

#define CS_MSG_KEY_ONE_OBJ          @"OneObj"

// 消息广播
+ (void) SendMessageToAllListener:(NSString *)messageID :(id)obj;

// 页面跳转
+ (void) SendMessageToViewCenter:(NSInteger)idMessage :(NSInteger)wParam :(NSInteger)lParam :(id)obj;
    
#pragma mark -
#pragma mark 日期时间转换相关
+(NSString*) getWeekStr: (NSInteger) index : (NSString*) preWords;
+(NSString*) getWeekStrByDate: (NSString*) preWords :(NSString *)ddate :(NSString *)dateFormat;
+ (void)appendText:(NSString *)text toFile:(NSString *)filePath;
+ (NSString*) getTimeStrWithFMT:(NSString*)fmt;
+ (NSString*) getTimeStr;		//yyyy-MM-dd HH:mm
+ (NSString*) getTimeStr:(NSDate*)date;
+ (NSString*) getTimeStr1;		//yyyy-MM-dd HH:mm:ss
+ (NSString*) getTimeStr1:(NSDate*)date;
+ (NSString*) getTimeStr2;		//yyyy-MM-dd HH:mm.ss.SSS
+ (NSString*) getTimeStr2:(NSDate*)date;
+ (void) getToday:(int*)y :(int*)m :(int*)d;
+ (NSString*) getTodayStr;		//yyyy-MM-dd
+ (void) getCurrentTime:(NSInteger*)y Month :(NSInteger*)m Day:(NSInteger*)d Hour:(NSInteger*)hr Minute:(NSInteger*)min;
+ (NSDate*) dateFromStringByFormat : (NSString*)datestr : (NSString*)datefmt;
+(NSString*) dateStringFromTimeIntervalSince1970:(NSTimeInterval)tmInvl;
+ (int)daysBetweenDates :(NSDate *)dt1 :(NSDate *)dt2;
+ (NSInteger) BetweenDays : (NSInteger)oldDate : (NSInteger) newDate;

#pragma mark -
#pragma mark 时辰转化
//农历时辰=>公历时
+(int) getHourFromNlHour:(NSString*)sShiChen;
//公历时=>农历时辰
+(NSString*) getNlHourFromHour:(int)hr;

#pragma mark -
//微博消费验证码
+ (NSString*) makeCheckCode:(int)ruleID;

//字符串替换
+ (NSString*) replaceStr: (NSString*)oldText : (NSString*)subText : (NSString*)newSubText;

//取第一个拼音
+ (NSString*) getFirstPhonetic:(NSString*)str;

#pragma mark -
#pragma mark 对象判断
+(BOOL) isObjNull:(id) obj;
+(BOOL) isArrayObj:(id)obj;
+(BOOL) isArrayEmpty:(id)obj;

#pragma mark -
#pragma mark 姓名分析
+(NSArray*) splitUserName:(NSString*)name SplitBy:(NSString*)spiltchar;


#pragma mark -
#pragma mark 随机数生成
//以时间作种的随机数
+(int) makeRandomNumberBySeed:(int)nRangeMax;
//IOS更精确的随机数
+(int) makeRandomNumber:(int)nRangeMax;


#pragma mark -
#pragma mark 信息提示

+ (void) showTipMessage: (NSString *) msg withImageNamed: (NSString *)image inSeconds :(NSInteger) seconds;
+ (void) showTipMessageInMainThread : (NSDictionary *) args;
+ (void) showTipMessageInMainThread : (NSString*)msg :(NSTimeInterval)time;
+ (void) showTipMessageInMainThread : (NSString*)msg :(NSTimeInterval)time :(CGFloat)centerOffset;

#pragma mark -
#pragma mark 导航栏回退按钮长度
+(float) getNavBackButtonWidth:(NSString *)strTitle;
@end

#pragma mark -
#pragma mark 释放object-c对象

#ifndef SAFEFREE_OBJECT
#define SAFEFREE_OBJECT(o) \
if( nil != (o) )\
{\
[(o) release]; \
(o) = nil; \
}
#endif

#pragma mark -
#pragma mark NSString扩展
@interface NSString (Astro_Extend)

//FOR SQL
-(NSString*) stringByAppendSqlEndComma;
-(BOOL) isDecimalDigitString;

//TRUNCTE
-(NSString*) stringByTruncatingStringWithFont:(UIFont*)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end


#pragma mark -
#pragma mark UIButton 扩展
@interface UIButton (Astro_Extend)

//统一按钮贴图
-(void)setCustomButtonDefaultImage;
-(void)setCustomButtonImage:(NSString*)fileNormal HighLight:(NSString*)fileHighLight;
+(void)setCustomButtonDefaultImages:(UIButton*)button, ...;
+(void)setCustomButtonImages:(NSString*)fileNormal HighLight:(NSString*)fileHighLight Button:(UIButton*)button, ...;

@end

#pragma mark -
#pragma mark 定义常用字体和颜色
//add 2012.2.2
//定义一些固定的颜色

//普通文本颜色（深棕色）
#define COLOR_DARK_BROWN [UIColor colorWithRed:0x39/255.0 green:0x17/255.0 blue:0x08/255.0 alpha:1.0]
//按钮文本颜色（棕色）
#define COLOR_BROWN [UIColor colorWithRed:0x9d/255.0 green:0x42/255.0 blue:0x16/255.0 alpha:1.0]
//稍淡文本颜色（浅棕色）
#define COLOR_LIGHT_BROWN [UIColor colorWithRed:0xd9/255.0 green:0x9d/255.0 blue:0x7d/255.0 alpha:1.0]
//橙红色
#define COLOR_BROWN_RED_B35101 [UIColor colorWithRed:0xb3/255.0 green:0x51/255.0 blue:0x01/255.0 alpha:1.0]
//棕红色
#define COLOR_BROWN_RED_B12704 [UIColor colorWithRed:0xb1/255.0 green:0x27/255.0 blue:0x04/255.0 alpha:1.0]
//表格分隔线(橙红色)
#define COLOR_TABLE_SEPERATE_RED_EDA06A [UIColor colorWithRed:0xed/255.0 green:0xa0/255.0 blue:0x6a/255.0 alpha:1.0]
//表格文字
#define COLOR_TABLE_TEXT_RED_8C3004 [UIColor colorWithRed:0x8c/255.0 green:0x30/255.0 blue:0x04/255.0 alpha:1.0]
//表格文字(深色)
#define COLOR_TABLE_TEXT_DARK_RED_452314 [UIColor colorWithRed:0x45/255.0 green:0x23/255.0 blue:0x14/255.0 alpha:1.0]
//浅红色(设置类背景)
#define COLOR_TABLE_LIGHT_RED_FEE4DE [UIColor colorWithRed:0x45/255.0 green:0x23/255.0 blue:0x14/255.0 alpha:1.0]

//金色
#define COLOR_GOLD [UIColor colorWithRed:0xf4/255.0 green:0xc1/255.0 blue:0x28/255.0 alpha:1.0]
//金色外边
#define COLOR_GOLD_ROUND [UIColor colorWithRed:0xe6/255.0 green:0x94/255.0 blue:0x17/255.0 alpha:1.0]

//木色
#define COLOR_WOOD [UIColor colorWithRed:0x30/255.0 green:0xc4/255.0 blue:0x0e/255.0 alpha:1.0]
//木色外边
#define COLOR_WOOD_ROUND [UIColor colorWithRed:0x10/255.0 green:0xb3/255.0 blue:0x18/255.0 alpha:1.0]

//水色
#define COLOR_WATER [UIColor colorWithRed:0x3e/255.0 green:0xc2/255.0 blue:0xe8/255.0 alpha:1.0]
//水色外边
#define COLOR_WATER_ROUND [UIColor colorWithRed:0x24/255.0 green:0xa6/255.0 blue:0xc8/255.0 alpha:1.0]

//火色
#define COLOR_FIRE [UIColor colorWithRed:0xea/255.0 green:0x3d/255.0 blue:0x1b/255.0 alpha:1.0]
//火色外边
#define COLOR_FIRE_ROUND [UIColor colorWithRed:0xd7/255.0 green:0x33/255.0 blue:0x13/255.0 alpha:1.0]

//土色
#define COLOR_SOIL [UIColor colorWithRed:0x96/255.0 green:0x78/255.0 blue:0x52/255.0 alpha:1.0]
//土色外边
#define COLOR_SOIL_ROUND [UIColor colorWithRed:0x81/255.0 green:0x66/255.0 blue:0x4b/255.0 alpha:1.0]




//label颜色
#define LABEL_COLOR_RED 0x74
#define LABEL_COLOR_GREEN 0x4b
#define LABEL_COLOR_BLUE 0x02
//文本的颜色
#define TEXT_COLOR_RED 0x7f
#define TEXT_COLOR_GREEN 0x5e
#define TEXT_COLOR_BLUE 0x24
//输入框提示文本的颜色
#define INPUTTICK_COLOR_RED 0xc1
#define INPUTTICK_COLOR_GREEN 0xc1
#define INPUTTICK_COLOR_BLUE 0xc1
//输入框文本的颜色
#define INPUT_COLOR_RED 0x7f
#define INPUT_COLOR_GREEN 0x5e
#define INPUT_COLOR_BLUE 0x24

//流年流月流日运势的翻页数
#define FORTUNE_SELECT_NUM 7

//定义字体的大小
#define  FONT_52PX   [UIFont systemFontOfSize:36]   //对应24号字体
#define  FONT_40PX   [UIFont systemFontOfSize:24]   //对应24号字体
#define  FONT_36PX   [UIFont systemFontOfSize:20]   //对应20号字体
#define  FONT_36PX_BOLD [UIFont boldSystemFontOfSize:20]   //对应20号字体(粗体)
#define  FONT_35PX   [UIFont systemFontOfSize:19]   //对应19号字体
#define  FONT_35PX_BOLD [UIFont boldSystemFontOfSize:19]   //对应19号字体(粗体)
#define  FONT_34PX   [UIFont systemFontOfSize:18]   //对应18号字体
#define  FONT_34PX_BOLD [UIFont boldSystemFontOfSize:18]   //对应18号字体(粗体)
#define  FONT_32PX   [UIFont systemFontOfSize:17]   //对应17号字体
#define  FONT_32PX_BOLD [UIFont boldSystemFontOfSize:17]   //对应17号字体
#define  FONT_31PX   [UIFont systemFontOfSize:16]   //对应号字体
#define  FONT_30PX   [UIFont systemFontOfSize:15]   //对应号字体
#define  FONT_24PX   [UIFont systemFontOfSize:13]   //对应号字体
#define  FONT_22PX   [UIFont systemFontOfSize:12]   //对应号字体
#define  FONT_20PX   [UIFont systemFontOfSize:11]   //对应号字体

//20号粗体
#define FONT_BOLD_36PX [UIFont fontWithName:@"Helvetica-Bold" size:20];

#define FONT_TITLE   [UIFont systemFontOfSize:23]   //对应24号字体

//通用边距(距离边距的像素)
#define MARGINE_NORMAL    10
//按钮的文字大小和颜色,大小
#define FONT_BUTTON  [UIFont systemFontOfSize:13]
#define COLOR_BUTTON [UIColor whiteColor]
#define SIZE_BUTTON  CGSizeMake( 50, 30)
#define MAXWIDTHE_NAV_BUTTON 72
#define MINWIDTHE_NAV_BUTTON 50
#define NAV_BUTTON_MARGIN 24




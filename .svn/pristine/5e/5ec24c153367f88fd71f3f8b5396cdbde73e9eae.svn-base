////
////  PubFunction.m
////  EnglishDemo
////
////  Created by huanghb on 11-1-10.
////  Copyright 2011 __MyCompanyName__. All rights reserved.
////
//
//#import "regex.h"
//#import <CommonCrypto/CommonDigest.h>
//
//#import "PubFunction.h"
//#import "SBJson.h"
//#import "NetConstDefine.h"
//#import "DbConstDefine.h"
//#import <time.h>
//
//
////#import "UIDevice+TAAddition.h"
//
///*
////网卡硬件
//#include <sys/socket.h> // Per msqr
//#include <sys/sysctl.h>
//#include <net/if.h>
//#include <net/if_dl.h>
//#pragma mark MAC addy
//*/
//
//@implementation MsgParam
//@synthesize obsv;
//@synthesize callback;
//@synthesize param1;
//@synthesize param2;
//@synthesize int1;
//@synthesize int2;
//
//+ (MsgParam *)param:(id)obsv:(SEL)callback:(id)param1:(int)int1 {
//  MsgParam *p = [[MsgParam new] autorelease];
//  p.obsv = obsv;
//  p.callback = callback;
//  p.param1 = param1;
//  p.int1 = int1;
//  return p;
//}
//
//- (void)dealloc {
//  self.param1 = nil;
//  self.param2 = nil;
//  [super dealloc];
//}
//
//@end
//
//@implementation GlobalParamCall
//
//@synthesize listRefreshCity;
//@synthesize window;
//@synthesize navFunc;
//@synthesize showType, item, item1, item2;
//@synthesize nItemType, nCurMonth, nCurYear, nCurDay;
//@synthesize almanacDesc_selfDate, almanacDesc_type, almanacDesc_title;
//@synthesize pView, pView2;
//@synthesize obj;
//@synthesize respclass, respclass2;
//@synthesize respfunc, respfunc2;
//
//GlobalParamCall *globalParam = nil;
//
//+ (void)Init {
//  if (globalParam == nil) {
//    globalParam = [[GlobalParamCall alloc] init];
//    globalParam.navFunc = nil;
//
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    globalParam.listRefreshCity = arr;
//    [arr release];
//  }
//}
//
//+ (void)Free {
//  if (globalParam) {
//    [globalParam release];
//    globalParam = nil;
//  }
//}
//
//- (void)dealloc {
//  self.listRefreshCity = nil;
//  self.showType = nil;
//  self.item = nil;
//  self.item1 = nil;
//  self.item2 = nil;
//  self.pView = nil;
//  self.pView2 = nil;
//  self.navFunc = nil;
//  self.window = nil;
//  self.respclass = nil;
//  self.respclass2 = nil;
//  self.respfunc = nil;
//  self.respfunc2 = nil;
//  [super dealloc];
//}
//
//@end
//
//@implementation PubFunction
//
//#pragma mark -
//#pragma mark 时间相关
//
//+ (int)getHourFromDate:(NSDate *)date {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:@"hh"];
//  int hour = [[dateFormatter stringFromDate:date] intValue];
//  [dateFormatter release];
//  return hour;
//}
//
//// 将指定格式的日期字符串转换成NSDate
//+ (NSDate *)convertString2NSDate:(NSString *)dateStr:(NSString *)formatStr {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:formatStr];
//  NSDate *date = [dateFormatter dateFromString:dateStr];
//  [dateFormatter release];
//  return date;
//}
//
//// 将指定格式的日期字符串转换成NSString
//+ (NSString *)convertString2NSString:(NSString *)dateStr:(NSString *)formatStr {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:formatStr];
//  NSDate *date = [dateFormatter dateFromString:dateStr];
//  NSString *result = [dateFormatter stringFromDate:date];
//  [dateFormatter release];
//  return result;
//}
//
//// 将指定年月日生成NSDate
//+ (NSDate *)makeDateByNYR:(NSInteger)year:(NSInteger)month:(NSInteger)day {
//  NSDate *result = nil;
//
//  NSCalendar *gregorian =
//      [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//  NSDateComponents *components = [[NSDateComponents alloc] init];
//  [components setDay:day];
//  [components setMonth:month];
//  [components setYear:year];
//  result = [gregorian dateFromComponents:components];
//
//  [components release];
//  [gregorian release];
//  return result;
//}
//
//// 设置时间的偏移
//+ (BOOL)makeDateOffset:(NSInteger *)
//              out_year:(NSInteger *)
//             out_month:(NSInteger *)
//               out_day:(NSInteger)
//           offsetMonth:(NSInteger)offsetDay {
//  BOOL result = NO;
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:CS_DATE_FORMAT_YYMM_DD];
//  NSDate *yourDate = [dateFormatter
//      dateFromString:[NSString stringWithFormat:CS_DATE_STR_FORMAT_YYMM_DD,
//                                                *out_year, *out_month,
//                                                *out_day]];
//  @try {
//    // start by retrieving day, weekday, month and year components for yourDate
//    NSCalendar *gregorian =
//        [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//
//    // now build a NSDate object for the next day
//    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
//    [offsetComponents setMonth:offsetMonth];
//    [offsetComponents setDay:offsetDay];
//
//    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents
//                                                  toDate:yourDate
//                                                 options:0];
//    NSDateComponents *todayComponents =
//        [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit |
//                               NSYearCalendarUnit)
//                     fromDate:nextDate];
//    *out_day = [todayComponents day];
//    *out_month = [todayComponents month];
//    *out_year = [todayComponents year];
//
//    [offsetComponents release];
//    [gregorian release];
//
//    result = YES;
//  } @catch (NSException *e) {
//  } @finally {
//    [dateFormatter release];
//    return result;
//  }
//}
//
//// 格式化日期，输入日期与格式化样式，输出字符串
//+ (NSString *)formatDateTime2NSStringWithDate:
//                  (NSDate *)in_date:(NSString *)in_format {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:in_format];
//  NSString *result;
//  result = [dateFormatter stringFromDate:in_date];
//  [dateFormatter release];
//  return result;
//}
//
//+ (NSString *)formatDateTime2NSString {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//  NSString *result;
//  result = [dateFormatter stringFromDate:[NSDate date]];
//  [dateFormatter release];
//  return result;
//}
//
//+ (NSString *)formatDate2NSString:(int)offsetDay {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:CS_DATE_FORMAT_YYMM_DD];
//  NSString *result;
//  result = [dateFormatter
//      stringFromDate:[NSDate dateWithTimeIntervalSinceNow:offsetDay * 24 * 60 *
//                                                          60]];
//  [dateFormatter release];
//  return result;
//}
//
//+ (NSString *)formatDateTime2NSString:(int)offsetSecond {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:CS_DATE_FORMAT_YYMM_DD_HH_mm_ss];
//  NSString *result;
//  result = [dateFormatter
//      stringFromDate:[NSDate dateWithTimeIntervalSinceNow:offsetSecond]];
//  [dateFormatter release];
//  return result;
//}
//
//+ (NSString *)formatDate2NSString {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:CS_DATE_FORMAT_YYMM_DD];
//  NSString *result;
//  result = [dateFormatter stringFromDate:[NSDate date]];
//  [dateFormatter release];
//  return result;
//}
//
//+ (NSString *)formatDate2NSString_YYYYMM {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:@"yyyyMM"];
//  NSString *result;
//  result = [dateFormatter stringFromDate:[NSDate date]];
//  [dateFormatter release];
//  return result;
//}
//
//+ (NSString *)formatDate2NSString_YYMM {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:CS_DATE_FORMAT_YYMM];
//  NSString *result;
//  result = [dateFormatter stringFromDate:[NSDate date]];
//  [dateFormatter release];
//  return result;
//}
//
//+ (BOOL)isTodayTimeStringYMD:(NSString *)sTime // sTime: YYYY-MM-DD
//{
//  //指定日期
//  NSDate *dt =
//      [PubFunction convertString2NSDate:sTime:CS_DATE_FORMAT_YYMM_DD];
//  NSInteger paYr, paMon, paDay;
//  [PubFunction decodeNSDate:dt:&paYr:&paMon:&paDay];
//  //今天
//  NSDate *today = [NSDate date];
//  NSInteger tdYr, tdMon, tdDay;
//  [PubFunction decodeNSDate:today:&tdYr:&tdMon:&tdDay];
//  //比较
//  if (paYr == tdYr && paMon == tdMon && paDay == tdDay) {
//    return YES;
//  }
//
//  return NO;
//}
//
//+ (BOOL)isTodayTimeString:(NSString *)sTime // sTime: YYYY-MM-DD HH:MM:ss
//{
//  //指定日期
//  NSDate *dt =
//      [PubFunction convertString2NSDate:
//                                  sTime:CS_DATE_FORMAT_YYMM_DD_HH_mm_ss];
//  NSInteger paYr, paMon, paDay;
//  [PubFunction decodeNSDate:dt:&paYr:&paMon:&paDay];
//  //今天
//  NSDate *today = [NSDate date];
//  NSInteger tdYr, tdMon, tdDay;
//  [PubFunction decodeNSDate:today:&tdYr:&tdMon:&tdDay];
//  //比较
//  if (paYr == tdYr && paMon == tdMon && paDay == tdDay) {
//    return YES;
//  }
//
//  return NO;
//}
//
//// 解析出输入日期的年月日
//+ (void)decodeNSDate:(NSDate *)
//             in_date:(NSInteger *)
//            out_year:(NSInteger *)
//           out_month:(NSInteger *)out_day {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//
//  [dateFormatter setDateFormat:@"yyyy"];
//  *out_year = [[dateFormatter stringFromDate:in_date] integerValue];
//  [dateFormatter setDateFormat:@"MM"];
//  *out_month = [[dateFormatter stringFromDate:in_date] integerValue];
//  [dateFormatter setDateFormat:@"dd"];
//  *out_day = [[dateFormatter stringFromDate:in_date] integerValue];
//  [dateFormatter release];
//}
//
//// 解析出输入日期的年月日
//+ (void)decodeNSDate:(NSDate *)
//             in_date:(NSInteger *)
//            out_year:(NSInteger *)
//           out_month:(NSInteger *)
//             out_day:(NSInteger *)
//            out_hour:(NSInteger *)
//          out_minute:(NSInteger *)out_second {
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:@"yyyy"];
//  *out_year = [[dateFormatter stringFromDate:in_date] integerValue];
//  [dateFormatter setDateFormat:@"MM"];
//  *out_month = [[dateFormatter stringFromDate:in_date] integerValue];
//  [dateFormatter setDateFormat:@"dd"];
//  *out_day = [[dateFormatter stringFromDate:in_date] integerValue];
//  [dateFormatter setDateFormat:@"HH"];
//  *out_hour = [[dateFormatter stringFromDate:in_date] integerValue];
//  [dateFormatter setDateFormat:@"mm"];
//  *out_minute = [[dateFormatter stringFromDate:in_date] integerValue];
//  [dateFormatter setDateFormat:@"ss"];
//  *out_second = [[dateFormatter stringFromDate:in_date] integerValue];
//  [dateFormatter release];
//}
//
//+ (int)getSecondToNow:(NSString *)sTime {
//  //指定日期
//  NSDate *dt =
//      [PubFunction convertString2NSDate:
//                                  sTime:CS_DATE_FORMAT_YYMM_DD_HH_mm_ss];
//  int sec = (int)[dt timeIntervalSinceNow];
//  if (sec < 0)
//    sec = -sec;
//  return sec;
//}
//
//+ (int)maxMonthDay:(int)y:(int)m {
//  if (m == 2) {
//    if (y % 4 == 0 && y % 100 != 0)
//      return 29;
//    else
//      return 28;
//  } else if (m == 4 || m == 6 || m == 9 || m == 11)
//    return 30;
//  else
//    return 31;
//}
//
//#pragma mark -
//#pragma mark 控件相关
//
//// 获得NIB中的对象
//+ (id)getObjectFromNib:(NSString *)ANibName:(id)AOwner:(Class)AClass {
//  id resultObj = nil;
//
//  NSArray *nib =
//      [[NSBundle mainBundle] loadNibNamed:ANibName owner:AOwner options:nil];
//
//  for (id oneObject in nib)
//    if ([oneObject isKindOfClass:AClass])
//      resultObj = oneObject;
//
//  return resultObj;
//}
//
//// 改变按钮的caption
//+ (void)changeBtnCaption:(UIButton *)btn:(NSString *)caption {
//  [btn setTitle:caption forState:UIControlStateNormal];
//  [btn setTitle:caption forState:UIControlStateHighlighted];
//}
//
//+ (BOOL)getLableWithString:(NSString *)content
//                     lable:(UILabel *)uilable
//               contentfont:(UIFont *)font
//                   maxsize:(CGSize)maxrect
//                    origin:(CGPoint)originpoint {
//  if (nil == uilable || nil == content || nil == font) {
//    return NO;
//  }
//
//  float fwide = maxrect.width;
//  if (fwide <= 0) {
//    return NO;
//  }
//
//  CGSize lineSize = {0, 0};
//  // CGSize bound = CGSizeMake( fwide, 10000 );
//  lineSize = [content sizeWithFont:font
//                 constrainedToSize:maxrect
//                     lineBreakMode:NSLineBreakByWordWrapping];
//  if (lineSize.width <= 0.1)
//    lineSize.width = maxrect.width;
//
//  uilable.text = content;
//  [uilable setFrame:CGRectMake(originpoint.x, originpoint.y, lineSize.width,
//                               lineSize.height)];
//  uilable.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
//  uilable.font = font;
//  uilable.lineBreakMode = NSLineBreakByWordWrapping;
//  uilable.numberOfLines = 0;
//  return YES;
//}
//
//#pragma mark -
//#pragma mark nsstring相关
//
//+ (NSString *)newUUID {
//  CFUUIDRef uuidObj = CFUUIDCreate(NULL);
//  NSString *uuidString = (NSString *)CFUUIDCreateString(NULL, uuidObj);
//  CFRelease(uuidObj);
//  return [uuidString autorelease];
//}
//
//+ (BOOL)stringIsHanzi:(NSString *)obj {
//  if (obj == nil) {
//    return NO;
//  }
//
//  if (![obj isKindOfClass:[NSString class]]) {
//    return NO;
//  }
//
//  int len = obj.length;
//  if (len == 0)
//    return YES;
//
//  for (int i = 0; i < len; i++) {
//    unichar uc = [obj characterAtIndex:i];
//    if (uc < 0x4e00 || uc > 0x9fa5)
//      return NO;
//  }
//
//  return YES;
//}
//
//+ (BOOL)stringIsNullOrEmpty:(NSString *)obj {
//  if (obj == nil) {
//    return YES;
//  }
//  if (![obj isKindOfClass:[NSString class]]) {
//    return YES;
//  }
//  if ([[obj stringByTrimmingCharactersInSet:
//                [NSCharacterSet whitespaceAndNewlineCharacterSet]]
//          isEqualToString:@""]) {
//    return YES;
//  }
//  return NO;
//}
//
//+ (BOOL)stringContainYM:(NSString *)str {
//  if ([str rangeOfString:@"a"].location != NSNotFound)
//    return YES;
//  else if ([str rangeOfString:@"o"].location != NSNotFound)
//    return YES;
//  else if ([str rangeOfString:@"e"].location != NSNotFound)
//    return YES;
//  else if ([str rangeOfString:@"i"].location != NSNotFound)
//    return YES;
//  else if ([str rangeOfString:@"u"].location != NSNotFound)
//    return YES;
//  else if ([str rangeOfString:@"ü"].location != NSNotFound)
//    return YES;
//
//  return NO;
//}
//
//+ (NSString *)Base64Encode:(NSData *)data {
//  // Point to start of the data and set buffer sizes
//  int inLength = [data length];
//  int outLength =
//      ((((inLength * 4) / 3) / 4) * 4) + (((inLength * 4) / 3) % 4 ? 4 : 0);
//  const char *inputBuffer = (char *)[data bytes];
//  char *outputBuffer = (char *)malloc(outLength);
//  outputBuffer[outLength] = 0;
//
//  // 64 digit code
//  static char Encode[] =
//      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
//
//  // start the count
//  int cycle = 0;
//  int inpos = 0;
//  int outpos = 0;
//  char temp;
//
//  // Pad the last to bytes, the outbuffer must always be a multiple of 4
//  outputBuffer[outLength - 1] = '=';
//  outputBuffer[outLength - 2] = '=';
//
//  /* http://en.wikipedia.org/wiki/Base64
//   Text content   M           a           n
//   ASCII          77          97          110
//   8 Bit pattern  01001101    01100001    01101110
//
//   6 Bit pattern  010011  010110  000101  101110
//   Index          19      22      5       46
//   Base64-encoded T       W       F       u
//   */
//
//  while (inpos < inLength) {
//    switch (cycle) {
//    case 0:
//      outputBuffer[outpos++] = Encode[(inputBuffer[inpos] & 0xFC) >> 2];
//      cycle = 1;
//      break;
//    case 1:
//      temp = (inputBuffer[inpos++] & 0x03) << 4;
//      outputBuffer[outpos] = Encode[temp];
//      cycle = 2;
//      break;
//    case 2:
//      outputBuffer[outpos++] = Encode[temp | (inputBuffer[inpos] & 0xF0) >> 4];
//      temp = (inputBuffer[inpos++] & 0x0F) << 2;
//      outputBuffer[outpos] = Encode[temp];
//      cycle = 3;
//      break;
//    case 3:
//      outputBuffer[outpos++] = Encode[temp | (inputBuffer[inpos] & 0xC0) >> 6];
//      cycle = 4;
//      break;
//    case 4:
//      outputBuffer[outpos++] = Encode[inputBuffer[inpos++] & 0x3f];
//      cycle = 0;
//      break;
//    default:
//      cycle = 0;
//      break;
//    }
//  }
//  NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
//  free(outputBuffer);
//  return pictemp;
//}
//
//+ (NSString *)Base64Encode2:(const char *)src:(int)src_len {
//  char *dst = (char *)malloc(src_len * 2);
//  int i = 0, j = 0;
//
//  char base64_map[65] =
//      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
//
//  for (; i < src_len - src_len % 3; i += 3) {
//
//    dst[j++] = base64_map[(src[i] >> 2) & 0x3F];
//
//    dst[j++] = base64_map[((src[i] << 4) & 0x30) + ((src[i + 1] >> 4) & 0xF)];
//
//    dst[j++] =
//        base64_map[((src[i + 1] << 2) & 0x3C) + ((src[i + 2] >> 6) & 0x3)];
//
//    dst[j++] = base64_map[src[i + 2] & 0x3F];
//  }
//
//  if (src_len % 3 == 1) {
//
//    dst[j++] = base64_map[(src[i] >> 2) & 0x3F];
//
//    dst[j++] = base64_map[(src[i] << 4) & 0x30];
//
//    dst[j++] = '=';
//
//    dst[j++] = '=';
//
//  }
//
//  else if (src_len % 3 == 2) {
//
//    dst[j++] = base64_map[(src[i] >> 2) & 0x3F];
//
//    dst[j++] = base64_map[((src[i] << 4) & 0x30) + ((src[i + 1] >> 4) & 0xF)];
//
//    dst[j++] = base64_map[(src[i + 1] << 2) & 0x3C];
//
//    dst[j++] = '=';
//  }
//
//  dst[j] = '\0';
//
//  NSString *pictemp = [NSString stringWithUTF8String:dst];
//  free(dst);
//  return pictemp;
//}
//
//+ (NSString *)Base64Decode2:(const char *)src:(int)src_len {
//  char *dst = (char *)malloc(src_len * 2);
//  // char *pointer4Dst;
//
//  int i = 0, j = 0;
//
//  unsigned char base64_decode_map[256] = {
//
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//
//      255, 255, 255, 62,  255, 255, 255, 63,  52,  53,
//      54,  55,  56,  57,  58,  59,  60,  61,  255, 255,
//
//      255, 0,   255, 255, 255, 0,   1,   2,   3,   4,
//      5,   6,   7,   8,   9,   10,  11,  12,  13,  14,
//
//      15,  16,  17,  18,  19,  20,  21,  22,  23,  24,
//      25,  255, 255, 255, 255, 255, 255, 26,  27,  28,
//
//      29,  30,  31,  32,  33,  34,  35,  36,  37,  38,
//      39,  40,  41,  42,  43,  44,  45,  46,  47,  48,
//
//      49,  50,  51,  255, 255, 255, 255, 255, 255, 255,
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//
//      255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
//      255, 255, 255, 255, 255, 255};
//
//  for (; i < src_len; i += 4) {
//
//    dst[j++] = base64_decode_map[src[i]] << 2 |
//
//               base64_decode_map[src[i + 1]] >> 4;
//
//    dst[j++] = base64_decode_map[src[i + 1]] << 4 |
//
//               base64_decode_map[src[i + 2]] >> 2;
//
//    dst[j++] = base64_decode_map[src[i + 2]] << 6 |
//
//               base64_decode_map[src[i + 3]];
//  }
//
//  dst[j] = '\0';
//
//  NSString *pictemp = [NSString stringWithUTF8String:dst];
//  free(dst);
//  return pictemp;
//}
//
//+ (NSString *)stringFilterRetainNum:(NSString *)str {
//  unichar buf[20];
//  unichar tmp;
//  int idx = 0;
//  for (int i = 0, n = [str length]; i < n; i++) {
//    tmp = [str characterAtIndex:i];
//    if (tmp >= '0' && tmp <= '9') {
//      buf[idx++] = tmp;
//      if (idx >= 20)
//        break;
//    }
//  }
//
//  if (idx <= 0)
//    return nil;
//
//  return [NSString stringWithCharacters:buf length:idx];
//}
//
//+ (BOOL)strHasStr:(NSString *)str1:(NSString *)str2 {
//  return ([str1 rangeOfString:str2].location != NSNotFound);
//}
//
//#pragma mark -
//#pragma mark 转义
//+ (NSString *)formatNSString4Sqlite:(NSString *)sou {
//  if (![sou isKindOfClass:[NSString class]]) {
//    return @"";
//  }
//  NSRange range = [sou rangeOfString:@"'"];
//  if (range.length > 0) {
//    return [sou stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
//  }
//  return sou;
//}
//
//+ (NSString *)formatNSString4MySql:(NSString *)sou {
//  NSMutableString *result = [NSMutableString stringWithString:sou];
//  NSString *sou2;
//  NSRange range = [result rangeOfString:@"\\"];
//  if (range.length > 0) {
//    sou2 =
//        [result stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
//    [result setString:sou2];
//  }
//  range = [result rangeOfString:@"'"];
//  if (range.length > 0) {
//    sou2 = [result stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
//    [result setString:sou2];
//  }
//
//  return result;
//}
//
//#pragma mark -
//#pragma mark color
//
//// Convert a 6-character hex color to a UIColor object
//+ (UIColor *)getColor:(NSString *)hexColor alpha:(CGFloat)alphaValue {
//  unsigned int red, green, blue;
//  NSRange range;
//  range.length = 2;
//  range.location = 0;
//  [[NSScanner scannerWithString:[hexColor substringWithRange:range]]
//      scanHexInt:&red];
//  range.location = 2;
//  [[NSScanner scannerWithString:[hexColor substringWithRange:range]]
//      scanHexInt:&green];
//  range.location = 4;
//  [[NSScanner scannerWithString:[hexColor substringWithRange:range]]
//      scanHexInt:&blue];
//  return [UIColor colorWithRed:(float)(red / 255.0f)
//                         green:(float)(green / 255.0f)
//                          blue:(float)(blue / 255.0f)
//                         alpha:alphaValue];
//}
//
//+ (UIColor *)getColor:(NSString *)hexColor {
//  return [self getColor:hexColor alpha:1.0];
//}
//
//+ (UIColor *)getRandomColor {
//  CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
//  CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
//  CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
//  return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//}
//
///*
//#pragma mark －
//#pragma mark 手机相关
//
//+ (NSString *) getUDID4Device
//{
//    NSString *result = nil;
//        @try {
//                result = [[UIDevice currentDevice] uniqueIdentifier];
//        }
//        @catch (NSException * e) {
//                result = CS_DEFAULT_UUID;
//        }
//        @finally {
//                if (nil == result)
//            result = CS_DEFAULT_UUID;
//        }
//        return result;
//}
// */
//
//#pragma mark -
//#pragma mark md5
//
//+ (NSString *)getMd5Value:(NSString *)sou {
//  const char *cStr = [sou UTF8String];
//  // NSLog(@"%@", sou);
//  unsigned char result[16];
//
//  CC_MD5(cStr, strlen(cStr), result);
//
//  return [[NSString
//      stringWithFormat:
//
//          @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//          result[0], result[1], result[2], result[3], result[4], result[5],
//          result[6], result[7], result[8], result[9], result[10], result[11],
//          result[12], result[13], result[14], result[15]] lowercaseString];
//}
//
//int xxtea(int *v, int n, int *k) {
//  unsigned int z /*=v[n-1]*/, y = v[0], sum = 0, e, DELTA = 0x9e3779b9;
//  int /*m,*/ p, q;
//  if (n > 1) {
//    /*加密部分 */
//    z = v[n - 1];
//    q = 6 + 52 / n;
//    while (q-- > 0) {
//      sum += DELTA;
//      e = sum >> 2 & 3;
//      for (p = 0; p < n - 1; p++) {
//        y = v[p + 1], z = v[p] += (z >> 5 ^ y << 2) + (y >> 3 ^ z << 4) ^
//                                  (sum ^ y) + (k[p & 3 ^ e] ^ z);
//      }
//      y = v[0];
//      z = v[n - 1] += (z >> 5 ^ y << 2) + (y >> 3 ^ z << 4) ^
//                      (sum ^ y) + (k[p & 3 ^ e] ^ z);
//    }
//    return 0;
//
//    /* 解密部分 */
//  } else if (n < -1) {
//    n = -n;
//    q = 6 + 52 / n;
//    sum = q * DELTA;
//    while (sum != 0) {
//      e = sum >> 2 & 3;
//      for (p = n - 1; p > 0; p--) {
//        z = v[p - 1], y = v[p] -= (z >> 5 ^ y << 2) + (y >> 3 ^ z << 4) ^
//                                  (sum ^ y) + (k[p & 3 ^ e] ^ z);
//      }
//      z = v[n - 1];
//      y = v[0] -= (z >> 5 ^ y << 2) + (y >> 3 ^ z << 4) ^
//                  (sum ^ y) + (k[p & 3 ^ e] ^ z);
//      sum -= DELTA;
//    }
//    return 0;
//  }
//  return 1;
//}
//
//#pragma mark -
//#pragma mark 正则表达式判断
//
//// 正则表达式判断
//+ (BOOL)RegExpMatch:(NSString *)string withPattern:(NSString *)pattern {
//  regex_t reg;
//  regmatch_t sub[10];
//  int status = regcomp(&reg, [pattern UTF8String], REG_EXTENDED);
//  if (status)
//    return NO;
//  status = regexec(&reg, [string UTF8String], 10, sub, 0);
//  if (status == REG_NOMATCH)
//    return NO;
//  else if (status)
//    return NO;
//  return YES;
//}
//
//#pragma mark -
//#pragma mark 页面跳转消息，消息广播相关
//
//// 消息广播
//+ (void)SendMessageToAllListener:(NSString *)messageID:(id)obj {
//  NSDictionary *d = nil;
//  if (nil != obj) {
//    d = [NSDictionary dictionaryWithObject:obj forKey:CS_MSG_KEY_ONE_OBJ];
//  }
//  [[NSNotificationCenter defaultCenter] postNotificationName:messageID
//                                                      object:nil
//                                                    userInfo:d];
//}
//
//// 页面跳转
//+ (void)SendMessageToViewCenter:(NSInteger)
//                      idMessage:(NSInteger)
//                         wParam:(NSInteger)
//                         lParam:(id)obj {
//
//  NSLog(@"窗口切换.msg=%d", idMessage);
//  NSDictionary *dictionary = nil;
//  NSArray *keys = nil;
//  NSArray *objects = nil;
//  if (nil == obj) {
//    keys = [NSArray arrayWithObjects:CS_MSG_ID_4_WHICH_PAGE_WILL_BE_NAVIGATED,
//                                     CS_WPARAM_4_NAVIGATE_VIA_CENTER,
//                                     CS_LPARAM_4_NAVIGATE_VIA_CENTER, nil];
//    objects = [NSArray arrayWithObjects:[NSNumber numberWithInt:idMessage],
//                                        [NSNumber numberWithInt:wParam],
//                                        [NSNumber numberWithInt:lParam], nil];
//  } else {
//    keys = [NSArray arrayWithObjects:CS_MSG_ID_4_WHICH_PAGE_WILL_BE_NAVIGATED,
//                                     CS_WPARAM_4_NAVIGATE_VIA_CENTER,
//                                     CS_LPARAM_4_NAVIGATE_VIA_CENTER,
//                                     CS_OPARAM_4_NAVIGATE_VIA_CENTER, nil];
//    objects =
//        [NSArray arrayWithObjects:[NSNumber numberWithInt:idMessage],
//                                  [NSNumber numberWithInt:wParam],
//                                  [NSNumber numberWithInt:lParam], obj, nil];
//  }
//
//  dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//  [[NSNotificationCenter defaultCenter] postNotificationName:CS_MSG_NAVIGATE
//                                                      object:nil
//                                                    userInfo:dictionary];
//}
//
//+ (NSString *)getWeekStrByDate:(NSString *)
//                      preWords:(NSString *)
//                         ddate:(NSString *)dateFormat {
//  NSDate *date;
//
//  if ([dateFormat isEqualToString:@""])
//    date = [PubFunction convertString2NSDate:ddate:@"yyyy-MM-dd"];
//  else
//    date = [PubFunction convertString2NSDate:ddate:dateFormat];
//  NSCalendar *calendar = [NSCalendar currentCalendar];
//  NSDateComponents *comps;
//
//  comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |
//                                NSWeekdayOrdinalCalendarUnit)
//                      fromDate:date];
//  NSInteger weekday = [comps weekday];
//  if ([preWords isEqualToString:@""])
//    preWords = @"周";
//  NSString *strWeek = preWords;
//  switch (weekday % 7) {
//  case 1:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"日"];
//    break;
//  case 2:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"一"];
//    break;
//  case 3:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"二"];
//    break;
//  case 4:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"三"];
//    break;
//  case 5:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"四"];
//    break;
//  case 6:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"五"];
//    break;
//  case 0:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"六"];
//    break;
//  default:
//    break;
//  }
//  return strWeek;
//}
//
//+ (NSString *)getWeekStr:(NSInteger)index:(NSString *)preWords {
//  NSDate *date = [NSDate date];
//  NSCalendar *calendar = [NSCalendar currentCalendar];
//  NSDateComponents *comps;
//
//  comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |
//                                NSWeekdayOrdinalCalendarUnit)
//                      fromDate:date];
//  NSInteger weekday = [comps weekday] + index;
//  if ([preWords isEqualToString:@""])
//    preWords = @"周";
//  NSString *strWeek = preWords;
//  switch (weekday % 7) {
//  case 1:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"日"];
//    break;
//  case 2:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"一"];
//    break;
//  case 3:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"二"];
//    break;
//  case 4:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"三"];
//    break;
//  case 5:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"四"];
//    break;
//  case 6:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"五"];
//    break;
//  case 0:
//    strWeek = [NSString stringWithFormat:@"%@%@", preWords, @"六"];
//    break;
//  default:
//    break;
//  }
//  return strWeek;
//}
//
//+ (void)appendText:(NSString *)text toFile:(NSString *)filePath {
//
//  // NSFileHandle won't create the file for us, so we need to check to make sure
//  // it exists
//  NSFileManager *fileManager = [NSFileManager defaultManager];
//  if (![fileManager fileExistsAtPath:filePath]) {
//
//    // the file doesn't exist yet, so we can just write out the text using the
//    // NSString convenience method
//
//    NSError *error = nil;
//    BOOL success = [text writeToFile:filePath
//                          atomically:YES
//                            encoding:NSUTF8StringEncoding
//                               error:&error];
//    if (!success) {
//      // handle the error
//      NSLog(@"%@", error);
//    }
//
//  } else {
//
//    // the file already exists, so we should append the text to the end
//
//    // get a handle to the file
//    //        NSFileHandle *fileHandle = [NSFileHandle
//    //        fileHandleForWritingAtPath:filePath];
//    TheLogFile = [NSFileHandle fileHandleForWritingAtPath:filePath];
//
//    // move to the end of the file
//    [TheLogFile seekToEndOfFile];
//
//    // convert the string to an NSData object
//    NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];
//
//    // write the data to the end of the file
//    [TheLogFile writeData:textData];
//
//    //        // clean up
//    //        [fileHandle closeFile];
//  }
//}
//
//+ (NSString *)getTimeStrWithFMT:(NSString *)fmt {
//  NSDate *date = [NSDate date];
//  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//  [formatter setDateFormat:fmt];
//  NSString *str = [formatter stringFromDate:date];
//  [formatter release];
//  return str;
//}
//
//+ (NSString *)getTimeStr {
//  NSDate *date = [NSDate date];
//  return [PubFunction getTimeStr:date];
//}
//
//+ (NSString *)getTimeStr:(NSDate *)date {
//  if (!date) {
//    date = [NSDate date];
//  }
//  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//  [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//  NSString *str = [formatter stringFromDate:date];
//  [formatter release];
//  return str;
//}
//
//+ (NSString *)getTimeStr1; // yyyy-MM-dd HH:mm.ss
//{
//  NSDate *date = [NSDate date];
//  return [PubFunction getTimeStr1:date];
//}
//
//+ (NSString *)getTimeStr1:(NSDate *)date // yyyy-MM-dd HH:mm.ss
//{
//  if (!date) {
//    date = [NSDate date];
//  }
//
//  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//  NSString *str = [formatter stringFromDate:date];
//  [formatter release];
//  return str;
//}
//
//+ (NSString *)getTimeStr2 {
//  NSDate *date = [NSDate date];
//  return [PubFunction getTimeStr2:date];
//}
//
//+ (NSString *)getTimeStr2:(NSDate *)date {
//  if (!date) {
//    date = [NSDate date];
//  }
//
//  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
//  NSString *str = [formatter stringFromDate:date];
//  [formatter release];
//  return str;
//}
//
//+ (void)getToday:(int *)y:(int *)m:(int *)d {
//  NSDate *date = [NSDate date];
//  NSCalendar *calendar = [NSCalendar currentCalendar];
//  NSDateComponents *comps;
//
//  // 年月日获得
//  comps = [calendar
//      components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
//        fromDate:date];
//  *y = (int)[comps year];
//  *m = (int)[comps month];
//  *d = (int)[comps day];
//}
//
//+ (NSString *)getTodayStr {
//  int y, m, d;
//  [PubFunction getToday:&y:&m:&d];
//  return [NSString stringWithFormat:@"%d-%02d-%02d", y, m, d];
//}
//
//+ (BOOL)str2ymd:(NSString *)str:(int *)y:(int *)m:(int *)d {
//  NSArray *strs = [str componentsSeparatedByString:@"-"];
//  if ([strs count] != 3)
//    return NO;
//
//  *y = [((NSString *)[strs objectAtIndex:0])intValue];
//  *m = [((NSString *)[strs objectAtIndex:1])intValue];
//  *d = [((NSString *)[strs objectAtIndex:2])intValue];
//
//  return YES;
//}
//
//+ (void)getCurrentTimeYMDW:(NSInteger *)
//                  out_year:(NSInteger *)
//                 out_month:(NSInteger *)
//                   out_day:(NSInteger *)out_weekday {
//  NSDate *date = [NSDate date];
//  NSCalendar *calendar = [NSCalendar currentCalendar];
//  NSDateComponents *comps;
//
//  // 年月日获得
//  comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |
//                                NSDayCalendarUnit | NSWeekdayCalendarUnit)
//                      fromDate:date];
//
//  *out_year = [comps year];
//  *out_month = [comps month];
//  *out_day = [comps day];
//  *out_weekday = [comps weekday];
//}
//
//+ (NSString *)getWeekdayStrENP:(NSInteger)weekday {
//  NSString *strForReturn;
//  switch (weekday) {
//  case 1:
//    strForReturn = @"Sun";
//    break;
//
//  case 2:
//    strForReturn = @"Mon";
//    break;
//
//  case 3:
//    strForReturn = @"Tues";
//    break;
//
//  case 4:
//    strForReturn = @"Wed";
//    break;
//
//  case 5:
//    strForReturn = @"Thur";
//    break;
//
//  case 6:
//    strForReturn = @"Fri";
//    break;
//
//  case 7:
//    strForReturn = @"Sat";
//    break;
//
//  default:
//    strForReturn = @"Err";
//    break;
//  }
//
//  return strForReturn;
//}
//
//+ (void)getCurrentTime:(NSInteger *)y
//                 Month:(NSInteger *)m
//                   Day:(NSInteger *)d
//                  Hour:(NSInteger *)hr
//                Minute:(NSInteger *)min {
//  NSDate *date = [NSDate date];
//  NSCalendar *calendar = [NSCalendar currentCalendar];
//  NSDateComponents *comps;
//
//  // 年月日获得
//  comps = [calendar
//      components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
//                  NSHourCalendarUnit | NSMinuteCalendarUnit)
//        fromDate:date];
//  *y = [comps year];
//  *m = [comps month];
//  *d = [comps day];
//  *hr = [comps hour];
//  *min = [comps minute];
//}
//
//+ (void)WriteLogFile:(NSString *)sLogText {
//  //	return;  //不写日志
//
//  NSString *str =
//      [NSString stringWithFormat:@"%@ %@\r\n", [self getTimeStr2], sLogText];
//#ifdef TARGET_IPHONE_SIMULATOR
//  NSLog(@"%@", str);
//#endif
//
//  // 写日志到文件中
//  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                       NSUserDomainMask, YES);
//  NSString *documentsDirectoryPath = [paths objectAtIndex:0];
//  NSString *filePath =
//      [documentsDirectoryPath stringByAppendingPathComponent:@"91Astro.log"];
//
//  [PubFunction appendText:str toFile:filePath];
//}
//
//// convert string to date by given format
//+ (NSDate *)dateFromStringByFormat:(NSString *)datestr:(NSString *)datefmt {
//  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//  [dateFormatter setDateFormat:datefmt];
//  return [dateFormatter dateFromString:datestr];
//}
//
//+ (NSString *)dateStringFromTimeIntervalSince1970:(NSTimeInterval)tmInvl {
//  NSDate *date = [NSDate dateWithTimeIntervalSince1970:tmInvl];
//  return [PubFunction getTimeStr1:date];
//}
//
//+ (int)daysBetweenDates:(NSDate *)dt1:(NSDate *)dt2 {
//  /*
//  int numDays;
//  NSCalendar *gregorian = [[NSCalendar alloc]
//  initWithCalendarIdentifier:NSGregorianCalendar];
//  NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
//  NSDateComponents *components = [gregorian components:unitFlags fromDate:dt1
//  toDate:dt2 options:0];
//  numDays = [components day];
//  [gregorian release];
//   */
//  int i = [dt1 timeIntervalSince1970];
//  int j = [dt2 timeIntervalSince1970];
//
//  double X = j - i;
//
//  int days = (int)((double)X / (3600.0 * 24.00));
//
//  return days;
//}
//
//+ (NSInteger)BetweenDays:(NSInteger)oldDate:(NSInteger)newDate {
//  NSInteger spanNum = 0;
//  // oldDate = 20110304;
//  if (oldDate == newDate)
//    return spanNum;
//
//  NSDate *startDate = [PubFunction
//      dateFromStringByFormat:[NSString stringWithFormat:@"%d", oldDate
//  ]:@"yyyyMMdd"];
//  NSDate *endDate = [PubFunction
//      dateFromStringByFormat:[NSString stringWithFormat:@"%d", newDate
//  ]:@"yyyyMMdd"];
//
//  spanNum = [PubFunction daysBetweenDates:startDate:endDate];
//  return spanNum;
//}
//
////农历时辰=>公历时
//+ (int)getHourFromNlHour:(NSString *)sShiChen {
//  int nHour = -1;
//  if ([PubFunction stringIsNullOrEmpty:sShiChen]) {
//    return nHour;
//  }
//
//  NSString *sSC = [sShiChen substringToIndex:1];
//  if ([sSC isEqualToString:@"子"]) {
//    nHour = 0;
//  } else if ([sSC isEqualToString:@"丑"] || [sSC isEqualToString:@"醜"]) {
//    nHour = 2;
//  } else if ([sSC isEqualToString:@"寅"]) {
//    nHour = 4;
//  } else if ([sSC isEqualToString:@"卯"]) {
//    nHour = 6;
//  } else if ([sSC isEqualToString:@"辰"]) {
//    nHour = 8;
//  } else if ([sSC isEqualToString:@"巳"]) {
//    nHour = 10;
//  } else if ([sSC isEqualToString:@"午"]) {
//    nHour = 12;
//  } else if ([sSC isEqualToString:@"未"]) {
//    nHour = 14;
//  } else if ([sSC isEqualToString:@"申"]) {
//    nHour = 16;
//  } else if ([sSC isEqualToString:@"酉"]) {
//    nHour = 18;
//  } else if ([sSC isEqualToString:@"戌"]) {
//    nHour = 20;
//  } else if ([sSC isEqualToString:@"亥"]) {
//    nHour = 22;
//  }
//
//  return nHour;
//}
//
////公历时=>农历时辰
//+ (NSString *)getNlHourFromHour:(int)hr {
//  NSString *sNlHour = @"";
//  if (hr == 23 || hr == 0) {
//    sNlHour = @"子";
//  } else if (hr >= 1 && hr <= 2) {
//    sNlHour = @"丑";
//  } else if (hr >= 3 && hr <= 4) {
//    sNlHour = @"寅";
//  } else if (hr >= 5 && hr <= 6) {
//    sNlHour = @"卯";
//  } else if (hr >= 7 && hr <= 8) {
//    sNlHour = @"辰";
//  } else if (hr >= 9 && hr <= 10) {
//    sNlHour = @"巳";
//  } else if (hr >= 11 && hr <= 12) {
//    sNlHour = @"午";
//  } else if (hr >= 13 && hr <= 14) {
//    sNlHour = @"未";
//  } else if (hr >= 15 && hr <= 16) {
//    sNlHour = @"申";
//  } else if (hr >= 17 && hr <= 18) {
//    sNlHour = @"酉";
//  } else if (hr >= 19 && hr <= 20) {
//    sNlHour = @"戌";
//  } else if (hr >= 21 && hr <= 22) {
//    sNlHour = @"亥";
//  }
//
//  return sNlHour;
//}
//
////微博消费验证码
//+ (NSString *)makeCheckCode:(int)ruleID {
//  // md5源：mac + '|' + key + '|' + cudate + '|' + ruleid;
//  // 例： 18879614b7ad|958dabae617e4f68da9bd0c8e20978ad|2011-12-15|42004
//
//  // mac地址
//  NSString *sMAC = @""; //[UIDevice macAddress];
//  if ([PubFunction stringIsNullOrEmpty:sMAC])
//    return @"";
//
//  //固定key
//  NSString *sSolidKey = @"958dabae617e4f68da9bd0c8e20978ad";
//  NSString *sCurDate = [PubFunction getTodayStr];
//  // md5值
//  NSString *sSour = [NSString
//      stringWithFormat:@"%@|%@|%@|%d", sMAC, sSolidKey, sCurDate, ruleID];
//  NSString *sMD5 = [PubFunction getMd5Value:sSour];
//  if ([PubFunction stringIsNullOrEmpty:sMD5])
//    return @"";
//
//  //验证码：md5 + mac
//  //例： "chkcode":"db5cb6cfcc1d4869be826606721f2bdc18879614b7ad"
//  NSString *sChkCode = [NSString stringWithFormat:@"%@%@", sMD5, sMAC];
//  return sChkCode;
//}
//
//+ (NSString *)replaceStr:(NSString *)
//                 oldText:(NSString *)
//                 subText:(NSString *)newSubText {
//  NSMutableString *str = [[NSMutableString alloc] init];
//  [str setString:oldText];
//  // NSString *result = [[str stringByReplacingOccurrencesOfString:subText
//  // withString:newSubText mutableCopy];
//  NSString *result =
//      [str stringByReplacingOccurrencesOfString:subText withString:newSubText];
//  [str release];
//  return result;
//}
//
//+ (NSString *)getFirstPhonetic:(NSString *)str {
//  NSRange rg = [str rangeOfString:@"|"];
//  if (rg.location == NSNotFound)
//    return str;
//  else
//    return [str substringToIndex:rg.location];
//}
//
//#pragma mark -
//#pragma mark 对象判断
//+ (BOOL)isObjNull:(id)obj {
//  if (!obj) {
//    return YES;
//  } else if ([obj isKindOfClass:[NSNull class]]) {
//    return YES;
//  } else if (obj == [NSNull null]) {
//    return YES;
//  } else {
//    return NO;
//  }
//}
//
//+ (BOOL)isArrayObj:(id)obj {
//  if ([obj isKindOfClass:[NSArray class]] ||
//      [obj isKindOfClass:[NSMutableArray class]]) {
//    return YES;
//  } else {
//    return NO;
//  }
//}
//
//+ (BOOL)isArrayEmpty:(id)obj {
//  if ([PubFunction isObjNull:obj]) {
//    return YES;
//  }
//
//  //不是数组对象时认为是空数组
//  if (![PubFunction isArrayObj:obj]) {
//    return YES;
//  }
//
//  if ([obj count] > 0) {
//    return NO;
//  } else {
//    return YES;
//  }
//}
//
//#pragma mark -
//#pragma mark 姓名分析
//+ (NSArray *)splitUserName:(NSString *)name SplitBy:(NSString *)spiltchar {
//  return [name componentsSeparatedByString:spiltchar];
//}
//
//#pragma mark -
//#pragma mark 随机数生成
////以时间作种的随机数, 返回[1,nRangeMax]
//+ (int)makeRandomNumberBySeed:(int)nRangeMax {
//  //生成随机数
//  srand((unsigned)time(0));
//  int nNum = random() % nRangeMax + 1;
//  return nNum;
//}
//
//// IOS更精确的随机数, 返回[1,nRangeMax]
//+ (int)makeRandomNumber:(int)nRangeMax {
//  int nNum = arc4random() % nRangeMax + 1;
//  return nNum;
//}
//
//#pragma mark -
//#pragma mark 信息提示
//
//+ (void)showTipMessage:(NSString *)msg
//        withImageNamed:(NSString *)image
//             inSeconds:(NSInteger)seconds {
//  NSDictionary *args = [NSDictionary
//      dictionaryWithObjectsAndKeys:msg, @"msg", image, @"image",
//                                   [NSNumber numberWithInt:seconds], @"seconds",
//                                   nil];
//  [self performSelectorOnMainThread:@selector(showTipMessageInMainThread:)
//                         withObject:args
//                      waitUntilDone:YES];
//}
//
//
//+ (float)getNavBackButtonWidth:(NSString *)strTitle {
//  if (!strTitle || strTitle.length <= 2) {
//    return MINWIDTHE_NAV_BUTTON;
//  }
//  CGSize lineSize = {0, 0};
//  // CGSize bound = CGSizeMake( fwide, 10000 );
//  lineSize = [strTitle sizeWithFont:FONT_24PX
//                  constrainedToSize:CGSizeMake(1000, 30)
//                      lineBreakMode:NSLineBreakByTruncatingTail];
//  lineSize.width += NAV_BUTTON_MARGIN;
//  if (lineSize.width > MAXWIDTHE_NAV_BUTTON) {
//    return MAXWIDTHE_NAV_BUTTON;
//  } else if (lineSize.width < MINWIDTHE_NAV_BUTTON) {
//    return MINWIDTHE_NAV_BUTTON;
//  }
//  return lineSize.width;
//}
//@end
//
//#pragma mark -
//#pragma mark NSString扩展
//@implementation NSString (Astro_Extend)
//
//#pragma mark--FOR SQL--
//- (NSString *)stringByAppendSqlEndComma {
//  int len = [self length];
//  if (len > 0 && [self characterAtIndex:(len - 1)] == ';')
//    return self;
//
//  return [self stringByAppendingString:@";"];
//}
//
//- (BOOL)isDecimalDigitString {
//  NSString *trimmedString =
//      [self stringByTrimmingCharactersInSet:[NSCharacterSet
//                                                    decimalDigitCharacterSet]];
//  if ([trimmedString length] > 0) {
//    return NO;
//  } else {
//    return YES;
//  }
//}
//
//#pragma mark--TRUNCTE--
//- (NSString *)stringByTruncatingStringWithFont:(UIFont *)font
//                                      forWidth:(CGFloat)width
//                                 lineBreakMode:(NSLineBreakMode)lineBreakMode {
//  NSMutableString *resultString = [[self mutableCopy] autorelease];
//  NSRange range = {resultString.length - 1, 1};
//
//  BOOL bTruncated = NO;
//  NSString *truncateReplacementString = @"...";
//  NSString *tmp = [NSString
//      stringWithFormat:@"%@%@", resultString, truncateReplacementString];
//  CGSize szResult =
//      [tmp sizeWithFont:font forWidth:FLT_MAX lineBreakMode:lineBreakMode];
//  while (szResult.width > width) {
//    // delete the last character
//    [resultString deleteCharactersInRange:range];
//    range.location--;
//    bTruncated = YES;
//
//    // config new string
//    if (lineBreakMode == NSLineBreakByTruncatingTail) {
//      tmp = [NSMutableString
//          stringWithFormat:@"%@%@", resultString, truncateReplacementString];
//    } else {
//      tmp = [NSMutableString stringWithString:resultString];
//    }
//
//    szResult =
//        [tmp sizeWithFont:font forWidth:FLT_MAX lineBreakMode:lineBreakMode];
//  }
//
//  if (bTruncated) {
//    return tmp;
//  } else {
//    return resultString;
//  }
//}
//
//@end
//
//#pragma mark -
//#pragma mark UIButton 扩展
//@implementation UIButton (Astro_Extend)
//
////统一按钮贴图
//- (void)setCustomButtonDefaultImage {
//  [self setCustomButtonImage:@"btn_common_2.png" HighLight:@"btn_common_1.png"];
//}
//
//- (void)setCustomButtonImage:(NSString *)fileNormal
//                   HighLight:(NSString *)fileHighLight {
//  UIImage *imgNorm = [UIImage imageNamed:fileNormal];
//  [self setBackgroundImage:[imgNorm stretchableImageWithLeftCapWidth:10
//                                                        topCapHeight:10]
//                  forState:UIControlStateNormal];
//  UIImage *imgHight = [UIImage imageNamed:fileHighLight];
//  [self setBackgroundImage:[imgHight stretchableImageWithLeftCapWidth:10
//                                                         topCapHeight:10]
//                  forState:UIControlStateHighlighted];
//}
//
//+ (void)setCustomButtonDefaultImages:(UIButton *)button, ... {
//  // button
//  [button setCustomButtonDefaultImage];
//
//  // parameter list
//  va_list argList;
//  va_start(argList, button);
//  while (id arg = va_arg(argList, id)) {
//    UIButton *btn = (UIButton *)arg;
//    [btn setCustomButtonDefaultImage];
//  }
//  va_end(argList);
//}
//
//+ (void)setCustomButtonImages:(NSString *)fileNormal
//                    HighLight:(NSString *)fileHighLight
//                       Button:(UIButton *)button, ... {
//  // button
//  [button setCustomButtonImage:fileNormal HighLight:fileHighLight];
//
//  // parameter list
//  va_list argList;
//  va_start(argList, button);
//  while (id arg = va_arg(argList, id)) {
//    UIButton *btn = (UIButton *)arg;
//    [btn setCustomButtonImage:fileNormal HighLight:fileHighLight];
//  }
//  va_end(argList);
//}
//
//@end

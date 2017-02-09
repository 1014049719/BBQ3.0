//
//  Common.mm
//  NoteBook
//
//  Created by wangsc on 10-9-16.
//  Copyright 2010 ND. All rights reserved.
//

#import "CommonDateTime.h"
#import <DateTools.h>

@implementation CommonFunc (ForDateTime)

+ (NSString *)getCurrentTime {
  NSDate *now = [NSDate date];

  NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
  [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  [forMatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];

  NSString *strDate = [forMatter stringFromDate:now];
  [forMatter release];
  return strDate;
}

+ (NSString *)getCurrentDate {
  NSDate *now = [NSDate date];

  NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
  [forMatter setDateFormat:@"yyyy-MM-dd"];
  [forMatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];

  NSString *strDate = [forMatter stringFromDate:now];
  [forMatter release];
  return strDate;
}

+ (NSDate *)get1970Date {
  NSCalendar *calendar = [[[NSCalendar alloc]
      initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
  [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
  NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
  [comps setYear:1970];
  [comps setMonth:1];
  [comps setDay:1];
  [comps setHour:0];
  [comps setMinute:0];
  [comps setSecond:0];
  return [calendar dateFromComponents:comps];
}

+ (NSDate *)dateFromIntervalSince1970:(NSTimeInterval)interval {
  NSDate *date1970 = [CommonFunc get1970Date];
  return [date1970 dateByAddingTimeInterval:interval];
}

+ (NSString *)getTimeString:(NSDate *)date format:(NSString *)strFormat {
  NSString *format = strFormat;
  if (nil == format) {
    format = @"yyyy-MM-dd HH:mm:ss";
  }
  NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
  [formatter setDateFormat:format];
  [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
  return [formatter stringFromDate:date];
}

+ (NSString *)getTimeString:(NSTimeInterval)interval
                 withFormat:(NSString *)strFormat {
  NSDate *date =
      [NSDate dateWithTimeIntervalSince1970:
                  interval]; //[CommonFunc dateFromIntervalSince1970:interval];
  NSString *format = strFormat;
  if (nil == format) {
    format = @"yyyy-MM-dd HH:mm:ss";
  }
  NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
  [formatter setDateFormat:format];
  [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
  return [formatter stringFromDate:date];
}

+ (NSString *)getTimestring:(NSTimeInterval)interval {
  return [CommonFunc getTimeString:interval withFormat:nil];
}

+ (NSString *)getAgeWithYear:(NSInteger)birthyear
                       month:(NSInteger)birthmonth
                         day:(NSInteger)birthday {
  NSInteger year = 0;
  NSInteger month = 0;
  month = [[NSDate date]
      monthsFrom:[NSDate dateWithYear:birthyear month:birthmonth day:birthday]];
  year = month / 12;
  month %= 12;
  return month ? [NSString stringWithFormat:@"%ld岁%ld个月", year, month]
               : [NSString stringWithFormat:@"%ld岁", year];
}

+ (NSString *)getDateString:(NSTimeInterval)interval {
  NSDate *date =
      [NSDate dateWithTimeIntervalSince1970:
                  interval]; //[CommonFunc dateFromIntervalSince1970:interval];

  NSString *format = @"yyyy-MM-dd";
  NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
  [formatter setDateFormat:format];
  [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
  return [formatter stringFromDate:date];
}

@end

//
//  Common.h
//  NoteBook
//
//  Created by wangsc on 10-9-16.
//  Copyright 2010 ND. All rights reserved.
//

#import "Common.h"


@interface CommonFunc (ForDateTime)
{
    
}


+ (NSString*)getCurrentTime;
//+ (void)getCurrentTimeA:(char*)pBuf;
//+ (void)getCurrentTimeW:(unichar*)pBuf;
+ (NSString*)getCurrentDate;

+ (NSString *)getAgeWithYear:(NSInteger)birthyear month:(NSInteger)birthmonth day:(NSInteger)birthday;

+(NSDate *)get1970Date;
+(NSDate *)dateFromIntervalSince1970:(NSTimeInterval)interval;
+(NSString *)getTimeString:(NSDate *)date format:(NSString *)strFormat;
+(NSString *)getTimeString:(NSTimeInterval)interval withFormat:(NSString *)strFormat;

+(NSString *)getTimestring:(NSTimeInterval)interval;

+(NSString *)getDateString:(NSTimeInterval)interval;

@end

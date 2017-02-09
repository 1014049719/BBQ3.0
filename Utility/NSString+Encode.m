//
//  NSString+Encode.m
//
//
//  Created by 朱琨 on 15/9/14.
//
//

#import "NSString+Encode.h"

@implementation NSString (Encode)

- (NSString *)encodeString:(NSStringEncoding)encoding {
  return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
      NULL, (CFStringRef)self, NULL, (CFStringRef) @";/?:@&=$+{}<>,",
      CFStringConvertNSStringEncodingToEncoding(encoding)));
}

@end

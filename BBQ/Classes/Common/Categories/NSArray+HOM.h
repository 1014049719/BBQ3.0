#import <Foundation/Foundation.h>

@interface NSArray (HOM)

- (NSArray *)arrayFromObjectsCollectedWithBlock:(id(^)(id object))block;

@end

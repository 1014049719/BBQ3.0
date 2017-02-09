//
//  BBQAddCommentQueue.m
//  BBQ
//
//  Created by 朱琨 on 15/11/4.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQAddCommentQueue.h"

@implementation BBQAddCommentQueue

+ (instancetype)sharedQueue {
  static BBQAddCommentQueue *queue;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    queue = [[BBQAddCommentQueue alloc] init];
  });
  return queue;
}

- (void)handleTask:(SlateOfflineMessageQueueTask *)task
          complete:(void (^)(BOOL))block {
  [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeAddComment
      param:task.userInfo
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        block(YES);
      }
      errorHandler:^(NSDictionary *responseObject) {
        block(NO);
      }
      failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO);
      }];
}

@end

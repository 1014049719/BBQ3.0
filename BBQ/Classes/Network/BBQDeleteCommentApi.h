//
//  BBQDeleteCommentApi.h
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQDeleteCommentApi : YTKRequest

- (instancetype)initWithComment:(Comment *)comment;

@end

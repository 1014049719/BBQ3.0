//
//  BBQUploadAvartarApi.h
//  BBQ
//
//  Created by 朱琨 on 15/11/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQUploadAvartarApi : YTKRequest

- (instancetype)initWithUid:(NSNumber *)uid avartar:(NSData *)data filename:(NSString *)filename;

@end

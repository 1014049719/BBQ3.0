//
//  HttpTool.h
//  httpTool2
//
//  Created by apple on 15/3/5.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadFileModel.h"


@interface HttpTool : NSObject
typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock)(NSError *error);

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+ (void)multipartPostFileDataWithPath:(NSString*)path params:(NSDictionary*)params dataAry:(NSArray*)dataAry success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
@end

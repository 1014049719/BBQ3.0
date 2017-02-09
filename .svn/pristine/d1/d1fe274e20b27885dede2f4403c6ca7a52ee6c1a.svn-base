//
//  BBQUploadAvartarApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQUploadAvartarApi.h"

@interface BBQUploadAvartarApi ()

@property (strong, nonatomic) NSData *fileData;
@property (copy, nonatomic) NSString *filename;
@property (copy, nonatomic) NSNumber *uid;

@end

@implementation BBQUploadAvartarApi

- (instancetype)initWithUid:(NSNumber *)uid avartar:(NSData *)data filename:(NSString *)filename {
    if (self = [super init]) {
        _uid = uid;
        _fileData = data;
        _filename = filename;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_UPLOAD_AVATAR;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSString *formKey = @"avartar";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:_fileData name:formKey fileName:_filename mimeType:type];
    };
}

- (id)requestArgument {
    return @{
             @"uid": _uid
             };
}

@end

//
//  UploadFileModel.h
//  BBQ
//
//  Created by slovelys on 15/8/5.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadFileModel : NSObject

/// 文件流
@property (nonatomic, strong) NSData* fileData;
/// 文件名
@property (nonatomic, strong) NSString* fileName;

@end

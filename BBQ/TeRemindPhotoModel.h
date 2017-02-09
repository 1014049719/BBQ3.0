//
//  TeRemindPhotoModel.h
//  BBQ
//
//  Created by slovelys on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeRemindPhotoModel : NSObject

/// 学生uid
@property (copy, nonatomic) NSString *uid;
/// 学生名字
@property (copy, nonatomic) NSString *baobaoName;
/// 是否是会员
@property (copy, nonatomic) NSString *qzkbz;
/// 当天是否有拍照任务 (0:没有 1:有)
@property (copy, nonatomic) NSString *flag;
/// 当天需要完成的照片数
@property (copy, nonatomic) NSString *pic_num1;
/// 当天已经完成的照片数
@property (copy, nonatomic) NSString *pic_num2;
/// 当天还需完成的照片数
@property (copy, nonatomic) NSString *pic_num3;
/// 当天拍照任务完成标志(0:未完成 1:已完成 ,拍够了当天需完成的张数算完成)
@property (copy, nonatomic) NSString *finished;
/// 更新日期
@property (copy, nonatomic) NSString *dateLine;
/// 头像
@property (copy, nonatomic) NSString *avatar;
/// mark=1时 和qzkbz=1的作用是一样的
@property (copy, nonatomic) NSString *mark;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end

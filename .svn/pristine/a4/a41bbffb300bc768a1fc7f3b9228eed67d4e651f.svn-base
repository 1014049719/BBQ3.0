//
//  SendToViewController.h
//  BBQ
//
//  Created by 朱琨 on 15/8/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SendToViewBlock)(int dtype,NSString *leftuid,NSString *rightuid,NSString *strName);

@interface SendToViewController : BBQBaseViewController


@property (strong,nonatomic) NSString *StyleString;


@property (strong, nonatomic) SendToViewBlock block;

//上传方式
@property (assign, nonatomic) BBQDynamicMediaType mediaType;

//调用方式 (0:非编辑页面调用   1:编辑页面调用);
@property (assign, nonatomic ) int nCallMode;


@end

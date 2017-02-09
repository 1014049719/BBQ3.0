//
//  BBQDynamicLayout.h
//  BBQ
//
//  Created by 朱琨 on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dynamic.h"
#import "BBQDynamicConst.h"

@class BBQDynamicCell;

typedef NS_ENUM(NSUInteger, BBQDynamicTagType) {
    BBQDynamicTagTypeNone,
    BBQDynamicTagTypeFirst,
    BBQDynamicTagTypeReport,
};

typedef NS_ENUM(NSUInteger, BBQDynamicStyle) {
    BBQDynamicStyleTimeline,
    BBQDynamicStyleDetail,
    BBQDynamicStyleWelcome
};

@interface BBQDynamicLayout : NSObject

@property (strong, nonatomic) Dynamic *dynamic;
@property (weak, nonatomic) BBQDynamicCell *cell;
@property (assign, nonatomic) BBQDynamicStyle style;

@property (assign, nonatomic) CGFloat height;   //总高度
@property (assign, nonatomic) CGFloat marginTop;    //顶部留白
@property (assign, nonatomic) BOOL showDateView;    //是否显示左边日期
@property (strong, nonatomic) YYTextLayout *dateLayout;
@property (assign, nonatomic) CGFloat profileHeight;    //个人信息
@property (strong, nonatomic) YYTextLayout *nameTextLayout;
@property (strong, nonatomic) YYTextLayout *sourceTextLayout;
@property (strong, nonatomic) YYTextLayout *postTimeTextLayout;
@property (strong, nonatomic) YYTextLayout *tagTextLayout;
@property (assign, nonatomic) CGFloat tagHeight;    //标签
@property (copy, nonatomic) NSString *tagPicName;   //标签图片
@property (strong, nonatomic) UIColor *tagColor;
@property (assign, nonatomic) BBQDynamicTagType tagType;
@property (assign, nonatomic) CGFloat textHeight;   //正文
@property (strong, nonatomic) YYTextLayout *textLayout;
@property (assign, nonatomic) BBQDynamicMediaType mediaType;    //媒体类型
@property (assign, nonatomic) CGFloat mediaHeight;    //媒体高度
@property (assign, nonatomic) CGSize mediaSize;  //媒体尺寸
@property (assign, nonatomic) CGFloat funcHeight;   //中间工具栏
@property (strong, nonatomic) YYTextLayout *giftTextLayout;
@property (assign, nonatomic) CGFloat giftHeight;   //礼物高度
@property (assign, nonatomic) CGFloat commentHeight;    //评论总高度
@property (copy, nonatomic) NSArray *commentTextLayouts;
@property (assign, nonatomic) CGFloat toolbarHeight;    //底部工具栏
@property (assign, nonatomic) CGFloat marginBottom;

- (instancetype)initWithDynamic:(Dynamic *)dynamic style:(BBQDynamicStyle)style;
- (void)layout;

@end
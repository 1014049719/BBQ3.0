//
//  BBQDynamicConst.h
//  BBQ
//
//  Created by 朱琨 on 15/11/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#ifndef BBQDynamicConst_h
#define BBQDynamicConst_h

// 宽高
#define kDynamicCellTopMargin 10      // cell 顶部灰色留白
#define kDynamicCellProfileBottomMargin 7.5 // cell profile底部留白
#define kDynamicCellTitleHeight 36   // cell 标题高度 (例如"仅自己可见")
#define kDynamicCellPadding 7.5       // cell 内边距
#define kDynamicCellPaddingText 10   // cell 文本与其他元素间留白
#define kDynamicCellPaddingPic 5     // cell 多张图片中间留白
#define kDynamicCellProfileHeight 47.5 // cell 名片高度
#define kDynamicCellTagReportHeight 30 // cell 每日报告Tag高度
#define kDynamicCellFuncHeight 34 // cell 中间功能条高度
#define kDynamicCellToolbarHeight 45     // cell 下方工具栏高度
#define kDynamicCellProfileWidth (kScreenWidth - 65 - 15)
#define kDynamicCellCardHeight 70    // cell card 视图高度
#define kDynamicCellNamePaddingLeft 14 // cell 名字和 avatar 之间留白
#define kDynamicCellContentWidth (kScreenWidth - 65 - 2 * kDynamicCellPadding - 15) // cell 内容宽度
#define kDynamicCellNameWidth (kDynamicCellProfileWidth - 50) // cell 名字最宽限制

#define kDynamicCellTagPadding 8         // tag 上下留白
#define kDynamicCellTagNormalHeight 16   // 一般 tag 高度
#define kDynamicCellTagPlaceHeight 24    // 地理位置 tag 高度
#define kDynamicCellToolbarBottomMargin 10 // cell 下方灰色留白

#define kDynamicCellNameFontSize 14      // 名字字体大小
#define kDynamicCellNormalFontSize 14   //一般字体大小
#define kDynamicCellTextSubTitleFontSize 12 //次要字体大小
#define kDynamicCellSourceFontSize 12    // 来源字体大小
#define kDynamicCellTextFontSize 17      // 文本字体大小
#define kDynamicCellTitlebarFontSize 14 // 标题栏字体大小
#define kDynamicCellToolbarFontSize 14 // 工具栏字体大小

// 颜色
#define kDynamicCellTextNormalColor UIColorHex(333333) // 一般文本色
#define kDynamicCellTextSubTitleColor UIColorHex(999999) // 次要文本色
#define kDynamicCellTextHighlightColor UIColorHex(527ead) // Link 文本色
#define kDynamicCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kDynamicCellToolbarTitleColor UIColorHex(929292) // 工具栏文本色
#define kDynamicCellToolbarTitleHighlightColor UIColorHex(df422d) // 工具栏文本高亮色

// tag标签颜色
#define kDynamicCellTagFirstColor UIColorHex(ff6440)    //第一次标签颜色
#define kDynamicCellTagHomeworkColor UIColorHex(6bcf69) //作业
#define kDynamicCellTagBreakfastColor UIColorHex(ffba00)    //早餐
#define kDynamicCellTagLunchColor UIColorHex(ff6440)    //午餐
#define kDynamicCellTagNoonbreakColor UIColorHex(ffba00)    //午睡
#define kDynamicCellTagDrinkingColor UIColorHex(65c3ff)    //喝水
#define kDynamicCellTagStudyColor UIColorHex(5dd3be)    //学习
#define kDynamicCellTagEmotionColor UIColorHex(ff6969)    //情绪
#define kDynamicCellTagHealthColor UIColorHex(6bcf69)    //健康
#define kDynamicCellTagWordsColor UIColorHex(ff6969)    //寄语
#define kDynamicCellTagMessageColor UIColorHex(ffba00)    //通知

#define kDynamicCellBackgroundColor UIColorHex(f5f5f5)    // Cell背景灰色
#define kDynamicCellHighlightColor UIColorHex(f0f0f0)     // Cell高亮时灰色
#define kDynamicCellInnerViewColor UIColorHex(f7f7f7)   // Cell内部卡片灰色
#define kDynamicCellInnerViewHighlightColor  UIColorHex(f0f0f0) // Cell内部卡片高亮时灰色
#define kDynamicCellLineColor [UIColor colorWithWhite:0.000 alpha:0.09] //线条颜色


#endif /* BBQDynamicConst_h */
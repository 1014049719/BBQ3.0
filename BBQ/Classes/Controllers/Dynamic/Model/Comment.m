//
//  Comment.m
//  BBQ
//
//  Created by 朱琨 on 15/12/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "Comment.h"
#import "NSString+Common.h"

@implementation Comment

+ (instancetype)commentWithDynamic:(Dynamic *)dynamic comment:(Comment *)comment {
    Comment *newComment = [Comment new];
    newComment.guid = dynamic.guid;
    newComment.flag = NO;
    newComment.fbztx = TheCurUser.member.avartar;
    newComment.uid = TheCurUser.member.uid;
    newComment.isreplay = comment ? YES : NO;
    newComment.cguid = newComment.isreplay ? comment.cguid : nil;
    newComment.reuid = newComment.isreplay ? comment.uid : dynamic.creuid;
    newComment.groupkey = TheCurUser.member.groupkey;
    newComment.dateline = @([[NSDate date] timeIntervalSince1970]);
    NSString *gxname = @"";
#ifdef TARGET_PARENT
    gxname = [NSString relationshipWithID:TheCurBaoBao.gxid gxname:TheCurBaoBao.gxname];
    newComment.gxid = TheCurBaoBao.gxid;
    newComment.gxname = TheCurBaoBao.gxname;
    newComment.classname = TheCurBaoBao.curClass.classname;
    newComment.schoolname = TheCurBaoBao.curSchool.schoolname;
    newComment.baobaoname = TheCurBaoBao.realname;
    newComment.nickname = [TheCurBaoBao.realname stringByAppendingString:[NSString relationshipWithID:TheCurBaoBao.gxid gxname:TheCurBaoBao.gxname]];
#elif TARGET_TEACHER
    newComment.classname = TheCurUser.curClass.classname;
    newComment.schoolname = TheCurUser.curSchool.schoolname;
    newComment.nickname = TheCurUser.member.realname;
#else
    newComment.schoolname = TheCurUser.curSchool.schoolname;
    newComment.nickname = TheCurUser.member.realname;
#endif
    newComment.gxname = gxname;
    NSString *regxname = @"";
    if (newComment.isreplay) {
        if (comment.groupkey.integerValue == BBQGroupkeyTypeParent) { //家长
            regxname = [comment.baobaoname
                        stringByAppendingString:[NSString relationshipWithID:comment.gxid gxname:comment.gxname]];
        } else {
            regxname = comment.nickname;
        }
    }
    newComment.regxname = regxname;
    return newComment;
}

@end

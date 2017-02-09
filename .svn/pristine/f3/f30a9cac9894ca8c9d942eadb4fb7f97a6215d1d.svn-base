//
//  PatchUrlTools.m
//  BBQ
//
//  Created by wth on 15/12/31.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "PatchUrlTools.h"

@implementation PatchUrlTools

+(NSString *)patchUrlWithUrlStr:(NSString *)UrlStr{

    NSString *patchUrlStr = UrlStr;
    
#ifdef TARGET_PARENT
    
    if ([patchUrlStr rangeOfString:@"?"].location!=NSNotFound) {
        
        if ([patchUrlStr rangeOfString:@"baobaouid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"&baobaouid=%@",TheCurBaoBao.uid]];
        }
        if ([patchUrlStr rangeOfString:@"classid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"&classid=%@",TheCurBaoBao.curClass.classid]];
        }
        if ([patchUrlStr rangeOfString:@"schoolid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"&schoolid=%@",TheCurBaoBao.curSchool.schoolid]];
        }
        
    }else{
        
        patchUrlStr =[patchUrlStr stringByAppendingString:@"?"];
        if ([patchUrlStr rangeOfString:@"baobaouid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"baobaouid=%@",TheCurBaoBao.uid]];
        }
        if ([patchUrlStr rangeOfString:@"classid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"&classid=%@",TheCurBaoBao.curClass.classid]];
        }
        if ([patchUrlStr rangeOfString:@"schoolid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"&schoolid=%@",TheCurBaoBao.curSchool.schoolid]];
        }
    }

#elif TARGET_TEACHER
   
    if ([patchUrlStr rangeOfString:@"?"].location!=NSNotFound) {
        
        if ([patchUrlStr rangeOfString:@"classid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"&classid=%@",TheCurUser.curClass.classid]];
        }
        if ([patchUrlStr rangeOfString:@"schoolid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"&schoolid=%@",TheCurUser.curSchool.schoolid]];
        }
        
    }else{
        
        patchUrlStr =[patchUrlStr stringByAppendingString:@"?"];
        if ([patchUrlStr rangeOfString:@"classid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"classid=%@",TheCurUser.curClass.classid]];
        }
        if ([patchUrlStr rangeOfString:@"schoolid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"&schoolid=%@",TheCurUser.curSchool.schoolid]];
        }
    }
#elif TARGET_MASTER

    if ([patchUrlStr rangeOfString:@"?"].location!=NSNotFound) {
        
        if ([patchUrlStr rangeOfString:@"schoolid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"&schoolid=%@",TheCurUser.curSchool.schoolid]];
        }
    }else{
        
        patchUrlStr =[patchUrlStr stringByAppendingString:@"?"];
        if ([patchUrlStr rangeOfString:@"schoolid"].location!=NSNotFound) {
            
            
        }else{
            
            patchUrlStr =[patchUrlStr stringByAppendingString:[NSString stringWithFormat:@"schoolid=%@",TheCurUser.curSchool.schoolid]];
        }
    }
#endif
    
        return patchUrlStr;
}

@end

//
//  KxMenuItem+BBQSchoolClassItme.m
//  BBQ
//
//  Created by slovelys on 15/12/11.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "KxMenuItem+BBQSchoolClassItme.h"

@implementation KxMenuItem (BBQSchoolClassItme)

- (NSString *)schoolid {
    NSString *sid = objc_getAssociatedObject(self, _cmd);
    return sid;
}

- (void)setSchoolid:(NSString *)schoolid {
    objc_setAssociatedObject(self, @selector(schoolid), schoolid, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)classid {
    NSString *cid = objc_getAssociatedObject(self, _cmd);
    return cid;
}

- (void)setClassid:(NSString *)classid {
    objc_setAssociatedObject(self, @selector(classid), classid, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)schoolclassname {
    NSString *name = objc_getAssociatedObject(self, _cmd);
    return name;
}

- (void)setSchoolclassname:(NSString *)schoolclassname {
    objc_setAssociatedObject(self, @selector(schoolclassname), schoolclassname, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end

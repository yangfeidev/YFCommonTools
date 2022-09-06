//
//  NSNull+NoNull.m
//  MobileMall_YF
//
//  Created by YangFei on 16/6/16.
//  Copyright © 2016年 JiuBianLi. All rights reserved.
//
//  给null添加的分类, 避免出现null引起项目Crash
#import "NSNull+NoNull.h"

@implementation NSNull (NoNull)

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}
@end

//
//  NSObject+YFAdd.m
//  MobileMall
//
//  Created by fei.yang on 2019/11/11.
//  Copyright © 2019 SoftBest1. All rights reserved.
//

#import "NSObject+YFAdd.h"

#import <objc/runtime.h>

@implementation NSObject (YFAdd)

+ (void)yf_propertyWithDictionary:(NSDictionary *)dict
{

    NSMutableString *strM = [NSMutableString string];

    // 遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop) {
        //        NSLog(@"%@ %@",propertyName,[value class]);
        NSString *code;
        
         NSLog(@"%@",[value class]);
        
        if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",propertyName];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",propertyName];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSArray *%@;",propertyName];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSDictionary *%@;",propertyName];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",propertyName];
            
        }
        else if ([value isKindOfClass:NSClassFromString(@"__NSArray0")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSArray *%@;",propertyName];
        }
        else if ([value isKindOfClass:NSClassFromString(@"__NSArrayI")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSArray *%@;",propertyName];
        }
        
        else if ([value isKindOfClass:NSClassFromString(@"NSTaggedPointerString")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",propertyName];
        }
        [strM appendFormat:@"\n%@\n",code];
        
    }];
    
    NSLog(@"%@",strM);
}

- (void)yf_performSelector:(SEL)selector withPrimitiveReturnValue:(void *)returnValue {
    [self yf_performSelector:selector withPrimitiveReturnValue:returnValue arguments:nil];
}

- (void)yf_performSelector:(SEL)selector withPrimitiveReturnValue:(void *)returnValue arguments:(void *)firstArgument, ... {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    
    if (firstArgument) {
        va_list valist;
        va_start(valist, firstArgument);
        [invocation setArgument:firstArgument atIndex:2];// 0->self, 1->_cmd
        
        void *currentArgument;
        NSInteger index = 3;
        while ((currentArgument = va_arg(valist, void *))) {
            [invocation setArgument:currentArgument atIndex:index];
            index++;
        }
        va_end(valist);
    }
    
    [invocation invoke];
    
    if (returnValue) {
        [invocation getReturnValue:returnValue];
    }
}

@end

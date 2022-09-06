//
//  UILabel+YFAdd.m
//  YFZhiHuLoading
//
//  Created by YangFei on 2017/3/7.
//  Copyright © 2017年 JiuBianLi. All rights reserved.
//

#import "UILabel+YFAdd.h"
#import <objc/runtime.h>

CG_INLINE void
UILabelReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}


@implementation UILabel (YFAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UILabelReplaceMethod([self class], @selector(drawTextInRect:), @selector(yf_drawTextInRect:));
    });
}

- (void)yf_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.yf_contentInsets;
    [self yf_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGRect)yf_sizeThatFitsWithFrame:(CGRect)rect {
    if (CGRectEqualToRect(rect, CGRectZero)) {
        NSAssert(NO, @"label frame can not be CGRectZero");
    }
    
    UIEdgeInsets insets = self.yf_contentInsets;
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize labelSize = [self sizeThatFits:CGSizeMake(rect.size.width - insets.left - insets.right, HUGE)];
    labelSize.height = labelSize.height + self.yf_contentInsets.top + self.yf_contentInsets.bottom;
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, labelSize.height);
}

const void *kAssociatedYf_contentInsets;
- (void)setYf_contentInsets:(UIEdgeInsets)yf_contentInsets {
    objc_setAssociatedObject(self, &kAssociatedYf_contentInsets, [NSValue valueWithUIEdgeInsets:yf_contentInsets] , OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)yf_contentInsets {
    return [objc_getAssociatedObject(self, &kAssociatedYf_contentInsets) UIEdgeInsetsValue];
}

@end












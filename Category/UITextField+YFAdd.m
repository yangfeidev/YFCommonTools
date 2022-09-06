//
//  UITextField+YFAdd.m
//  MobileMall
//
//  Created by YangFei on 2018/11/7.
//  Copyright © 2018 SoftBest1. All rights reserved.
//

#import "UITextField+YFAdd.h"


/// 是否可以 粘贴
//@property (nonatomic, assign) UIEdgeInsets yf_banPaste;
//
///// 是否可以 选择
//@property (nonatomic, assign) NSTimeInterval yf_selectEnable;
//
///// 是否可以 全选
//@property (nonatomic, assign) NSTimeInterval yf_selectAllEnable;




@implementation UITextField (YFAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(canPerformAction:withSender:), @selector(yf_canPerformAction:withSender:));
    });
}


static char * kAssociated_yf_banPaste = "kAssociatedObject_yf_pasteEnable";
- (void)setYf_banPaste:(BOOL)yf_banPaste {
    objc_setAssociatedObject(self, &kAssociated_yf_banPaste, @(yf_banPaste), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)yf_banPaste {
    return [objc_getAssociatedObject(self, &kAssociated_yf_banPaste) boolValue];
}

- (BOOL)yf_canPerformAction:(SEL)action withSender:(id)sender {
    
    if (self.yf_banPaste && (action == @selector(paste:))) { /// 禁止粘贴
        return NO;
    }
   return [self yf_canPerformAction:action withSender:sender];
}


@end

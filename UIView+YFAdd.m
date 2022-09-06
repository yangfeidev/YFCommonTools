//
//  UIView (YFAdd).m
//  
//
//  Created by YangFei on 15/8/17.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "UIView+YFAdd.h"

#define kLabelH (30.0f)
#define kBottomMargin (100.0f)

#ifndef YFiOS8Later
#define YFiOS8Later  ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#endif


@implementation UIView (YFAdd)

#pragma mark - /**************** UIView Frame 相关 ****************/

- (void)setYf_x:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)yf_x {
    return self.frame.origin.x;
}

- (void)setYf_y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)yf_y {
    return self.frame.origin.y;
}

- (void)setYf_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)yf_centerX {
    return self.center.x;
}

- (void)setYf_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)yf_centerY {
    return self.center.y;
}

- (void)setYf_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)yf_width {
    return self.frame.size.width;
}

- (void)setYf_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)yf_height {
    return self.frame.size.height;
}

- (void)setYf_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)yf_size {
    return self.frame.size;
}

- (void)setYf_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)yf_origin {
    return self.frame.origin;
}


/*--------------------华丽分割线------------------------*/

- (CGFloat)yf_top {
    return self.frame.origin.y;
}

- (void)setYf_top:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)yf_left {
    return self.frame.origin.x;
}

- (void)setYf_left:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)yf_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYf_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.origin.y;
    self.frame = frame;
}

- (CGFloat)yf_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYf_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.origin.x;
    self.frame = frame;
}


/*--------------------华丽分割线------------------------*/
- (CGPoint)yf_bottomLeft {
    CGFloat bottomX = self.frame.origin.x;
    CGFloat bottomY = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(bottomX, bottomY);
}

- (CGPoint)yf_bottomRight {
    CGFloat bottomX = self.frame.origin.x + self.frame.size.width;
    CGFloat bottomY = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(bottomX, bottomY);
}

- (CGPoint)yf_topLeft {
    CGFloat topX = self.frame.origin.x;
    CGFloat topY = self.frame.origin.y;
    return CGPointMake(topX, topY);
}

- (CGPoint)yf_topRight {
    CGFloat topX = self.frame.origin.x + self.frame.size.width;
    CGFloat topY = self.frame.origin.y;
    return CGPointMake(topX, topY);
}


@end



#pragma mark - /**************** HUD 弹窗 加载中...  提示信息 ****************/
@interface UIView ()
@property (nonatomic, strong) MBProgressHUD *yf_hud;
@end

@implementation UIView (YF_LoadingHUDView)

static NSString * const loadingMessage = @"请稍候...";
static char kAssociatedObject_hud;


- (void)setYf_hud:(MBProgressHUD *)yf_hud {
    objc_setAssociatedObject(self, &kAssociatedObject_hud, yf_hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)yf_hud {
    return objc_getAssociatedObject(self, &kAssociatedObject_hud) ;
}



- (void)yf_showLoading {
    [self yf_showHUDWithMessage:loadingMessage showType:MBProgressHUDModeIndeterminate];
}

- (void)yf_hideLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.yf_hud hide:YES];
    });
}


- (void)yf_showMessage:(NSString *)message {
    [self yf_showHUDWithMessage:message showType:MBProgressHUDModeText];
}

- (void)yf_showHUDWithMessage:(NSString *)message showType:(MBProgressHUDMode )showType {
    self.yf_hud = ({
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.animationType = MBProgressHUDAnimationZoomOut|MBProgressHUDAnimationFade;
        hud.labelText = message;
        hud.mode = showType;
        hud;
    });
    
    if (showType == MBProgressHUDModeText) {
        [self.yf_hud hide:YES afterDelay:1.5f];
        
    }
}
@end






@implementation UIView (YF_cornerRadius_border)
- (void)yf_cornerRadius:(CGFloat)cornerRadius {
//    if (cornerRadius < 0) return;
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
- (void)yf_borderWidth:(CGFloat)borderWidth color:(UIColor *)borderColor {
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}
/// 给 view 添加任意圆角
- (void)yf_clipsByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

@end


//移除子视图
@implementation UIView (SubView_leader)

- (void)yf_removeSubviews
{
    for (UIView *tV in self.subviews) {
        [tV removeFromSuperview];
    }
}


@end



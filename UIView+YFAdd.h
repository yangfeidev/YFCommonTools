//
//  UIView (YFAdd).h
//
//
//  Created by YangFei on 15/8/17.
//  Copyright (c) 2015年 . All rights reserved.
//
//  因为控件的frame不能直接修改，必须整体赋值。所以重写方法，可以直接修改size，height，width，x，y

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface UIView (YFAdd)

#pragma mark - /**************** UIView Frame 相关 ****************/
/**
 *  x坐标
 */
@property (assign, nonatomic) CGFloat yf_x;

/**
 *  y坐标
 */
@property (assign, nonatomic) CGFloat yf_y;

/**
 *  width
 */
@property (assign, nonatomic) CGFloat yf_width;

/**
 *  height
 */
@property (assign, nonatomic) CGFloat yf_height;

/**
 *  size
 */
@property (assign, nonatomic) CGSize yf_size;

/**
 *  origin
 */
@property (assign, nonatomic) CGPoint yf_origin;

/**
 *  中心x坐标
 */
@property (assign, nonatomic) CGFloat yf_centerX;

/**
 *  中心y坐标
 */
@property (assign, nonatomic) CGFloat yf_centerY;


/*--------------------上。左。下。右。------------------------*/
/**
 *  上
 */
@property (assign, nonatomic) CGFloat yf_top;

/**
 *  左
 */
@property (assign, nonatomic) CGFloat yf_left;

/**
 *  下
 */
@property (assign, nonatomic) CGFloat yf_bottom;

/**
 *  右
 */
@property (assign, nonatomic) CGFloat yf_right;


/*-------------------- 点 ------------------------*/
/**
 *  左下角
 */
@property (readonly) CGPoint yf_bottomLeft;

/**
 *  右下角
 */
@property (readonly) CGPoint yf_bottomRight;

/**
 *  右上角
 */
@property (readonly) CGPoint yf_topRight;

/**
 *  左上角
 */
@property (readonly) CGPoint yf_topLeft;




@end

#pragma mark - /**************** HUD 加载提示信息 以下方法依赖 MBProgressHUD ****************/
@interface UIView (YF_LoadingHUDView)

/**
 *  加载网络数据等待...
 */
- (void)yf_showLoading;

/**
 *   隐藏弹窗加载等待框...
 */
- (void)yf_hideLoading;
@end

#pragma mark - /**************** layer 层 ****************/

@interface UIView (YF_cornerRadius_border)
/// 给 view 切圆角
- (void)yf_cornerRadius:(CGFloat)cornerRadius;
/// 给 view 添加边框
- (void)yf_borderWidth:(CGFloat)borderWidth color:(UIColor *)borderColor;
/// 给 view 添加任意圆角   例如  上边左右圆角  corners 传入 :UIRectCornerTopLeft | UIRectCornerTopRight
- (void)yf_clipsByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;


@end

#pragma mark - /**************** 操控view ****************/
@interface UIView (SubView_leader)

- (void)yf_removeSubviews;


@end



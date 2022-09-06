//
//  MallAlertView.h
//
//  Created by YangFei on 2018/8/22.
//  Copyright © 2018年 SoftBest1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallAlertView : UIView

/**
 俩个标题的弹窗
 
 @param title 弹窗标题
 @param message 要提示的信息
 @param leftTitle 左按钮标题
 @param leftAction 左按钮点击事件
 @param rightTitle 右侧按钮
 @param rightAction 右侧按钮点击事件
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
            leftTitle:(NSString *)leftTitle
              handler:(void (^)(void))leftAction
           rightTitle:(NSString *)rightTitle
              handler:(void (^)(void))rightAction;


/**
 只有一个按钮的弹窗
 
 @param title 标题
 @param message 要提示的信息
 @param buttonTitle 按钮标题
 @param leftAction 按钮点击事件
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          buttonTitle:(NSString *)buttonTitle
              handler:(void (^)(void))leftAction;


/**
 只有一个按钮的弹窗, 默认标题 `提示`
 
 @param message 要提示的信息
 @param buttonTitle 按钮标题
 @param leftAction 按钮点击事件
 */
+ (void)showWithMessage:(NSString *)message
            buttonTitle:(NSString *)buttonTitle
                handler:(void (^)(void))leftAction;

@end

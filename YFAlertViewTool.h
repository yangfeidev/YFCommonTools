//
//  YFAlertMessageTool.h
//  
//
//  Created by YangFei on 2016/12/13.
//  Copyright © 2016年 JiuBianLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIAlertController+YFAdd.h"

static NSString * const UIAlertViewToolTitleCancel = @"取消";

static NSString * const UIAlertViewToolTitleConfirm = @"确定";

#ifndef YFiOS_8_OR_LATER
#define YFiOS_8_OR_LATER   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#endif

@interface YFAlertViewTool : NSObject

/**
        弹窗工具

 @param title 弹窗标题
 @param message 弹窗信息提示
 @param leftTitle 左侧标题
 @param leftAction 左侧回调block
 @param rightTitle 右侧标题
 @param rightAction 右侧block
 */

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
      messageAlignment:(NSTextAlignment)alignment
       leftActionTitle:(NSString *)leftTitle
               handler:(void (^)(void))leftAction
      rightActionTitle:(NSString *)rightTitle
               handler:(void (^)(void))rightAction NS_AVAILABLE_IOS(8_0);


/**
 弹出信息提示, 只有确定按钮
 @param message 提示信息
 */
+ (void)alertMessage:(NSString *)message NS_AVAILABLE_IOS(8_0);

/**
 只有一个确定按钮,点击确定后的回调

 @param message 提示的信息
 @param leftAction 点击确定后的回调
 */
+ (void)alertMessage:(NSString *)message
             handler:(void (^)(void))leftAction NS_AVAILABLE_IOS(8_0);

@end

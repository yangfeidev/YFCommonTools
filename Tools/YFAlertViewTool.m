//
//  YFAlertMessageTool.m
//
//
//  Created by YangFei on 2016/12/13.
//  Copyright © 2016年 JiuBianLi. All rights reserved.
//

#import "YFAlertViewTool.h"

static NSString * const mainTitle = @"提示";

static NSString * const doneTitle = @"确定";



@interface YFAlertViewTool () 

@end

@implementation YFAlertViewTool

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
      messageAlignment:(NSTextAlignment)alignment
       leftActionTitle:(NSString *)leftTitle
               handler:(void (^)(void))leftAction
      rightActionTitle:(NSString *)rightTitle
               handler:(void (^)(void))rightAction {
    
    NSAssert(title, @"YFAlertViewTool title can not be nil");
    NSAssert(message, @"YFAlertViewTool message can not be nil");
    
    if (YFiOS_8_OR_LATER) {
        
        UIAlertController *yf_alertVC = [UIAlertController alertControllerWithTitle:title
                                                                            message:message
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        yf_alertVC.yf_messageLabel.textAlignment = alignment;
        
        UIAlertAction *yf_action1 = [UIAlertAction actionWithTitle:leftTitle
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (leftAction) {
                                                                   leftAction();
                                                               }
                                                           }];
        [yf_alertVC addAction:yf_action1];
        
        // ------ 如果存在第二个按钮
        if (rightTitle.length) {
            UIAlertAction *yf_action2 = [UIAlertAction actionWithTitle:rightTitle
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (rightAction) {
                                                                       rightAction();
                                                                   }
                                                               }];
            
            [yf_alertVC addAction:yf_action2];
        }
        
        UIViewController *myVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [myVc presentViewController:yf_alertVC animated:YES completion:nil];
        
    }
}

+ (void)alertMessage:(NSString *)message {
    [self alertWithTitle:mainTitle
                     message:message
            messageAlignment:NSTextAlignmentCenter
             leftActionTitle:doneTitle
                     handler:nil
            rightActionTitle:nil
                     handler:nil];
}

+ (void)alertMessage:(NSString *)message handler:(void (^)(void))leftAction {
    [self alertWithTitle:mainTitle
                     message:message
            messageAlignment:NSTextAlignmentCenter
             leftActionTitle:doneTitle
                     handler:leftAction
            rightActionTitle:nil
                     handler:nil];
}


@end

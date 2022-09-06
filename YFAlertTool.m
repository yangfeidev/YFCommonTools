//
//  YFAlertMessageTool.m
//
//
//  Created by YangFei on 2016/12/13.
//  Copyright © 2016年 JiuBianLi. All rights reserved.
//

#import "YFAlertTool.h"

static NSString * const mainTitle = @"提示";

static NSString * const doneTitle = @"确定";



@interface YFAlertTool () 

@end

@implementation YFAlertTool

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
      messageAlignment:(NSTextAlignment)alignment
       leftActionTitle:(NSString *)leftTitle
               handler:(void (^)(void))leftAction
      rightActionTitle:(NSString *)rightTitle
               handler:(void (^)(void))rightAction {
    
    NSAssert(title, @"YFAlertTool title can not be nil");
    NSAssert(message, @"YFAlertTool message can not be nil");
    
    if (YFiOS_8_OR_LATER) {
        
        UIAlertController *yf_alertVC = [UIAlertController alertControllerWithTitle:title
                                                                            message:message
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        yf_alertVC.yf_messageLabel.textAlignment = alignment;
        
        UIAlertAction *yf_action1 = [UIAlertAction actionWithTitle:leftTitle
                                                             style:UIAlertActionStyleDefault
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
                
        
        UIViewController *myVc = [self topViewController];

        dispatch_async_on_main_queue(^{
            [myVc presentViewController:yf_alertVC animated:YES completion:nil];
        });
    }
}


+ (void)alertWithTitle1:(NSString *)title
               message:(NSString *)message
      messageAlignment:(NSTextAlignment)alignment
       leftActionTitle:(NSString *)leftTitle
               handler:(void (^)(void))leftAction
       rightActionTitle:(NSString *)rightTitle setController:(UIViewController *)controller
               handler:(void (^)(void))rightAction {
    
    NSAssert(title, @"YFAlertTool title can not be nil");
    NSAssert(message, @"YFAlertTool message can not be nil");
    
    if (YFiOS_8_OR_LATER) {
        
        UIAlertController *yf_alertVC = [UIAlertController alertControllerWithTitle:title
                                                                            message:message
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        yf_alertVC.yf_messageLabel.textAlignment = alignment;
        
        UIAlertAction *yf_action1 = [UIAlertAction actionWithTitle:leftTitle
                                                             style:UIAlertActionStyleDefault
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
        
                
        dispatch_async_on_main_queue(^{
            [controller presentViewController:yf_alertVC animated:YES completion:nil];
        });
        
        
        
        
    }
}

+ (UIViewController *)topViewController {
   return [[self new] topViewController];
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
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

+ (void)alertMessage:(NSString *)message
           leftTitle:(NSString *)leftTtitle
             handler:(void (^)(void))leftAction
          rightTitle:(NSString *)rightTtitle
             handler:(void (^)(void))rightAction {
    [self alertWithTitle:mainTitle
                 message:message
        messageAlignment:NSTextAlignmentCenter
         leftActionTitle:leftTtitle
                 handler:leftAction
        rightActionTitle:rightTtitle
                 handler:rightAction];
}


+ (void)alertTitle:(NSString *)title
           Message:(NSString *)message
         leftTitle:(NSString *)leftTtitle
           handler:(void (^)(void))leftAction {
    [self alertWithTitle:title
                 message:message
        messageAlignment:NSTextAlignmentCenter
         leftActionTitle:leftTtitle
                 handler:leftAction
        rightActionTitle:nil
                 handler:nil];
}


@end

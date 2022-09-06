//
//  UINavigationController+YFAdd.h
//
//  Created by YangFei on 16/1/12.
//  Copyright © 2016年 YangFei All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UINavigationController (YFAdd) <UIGestureRecognizerDelegate>

@end

@protocol UINavigationControllerBackButtonHandlerProtocol <NSObject>

@optional

/// 当自定义了`leftBarButtonItem`按钮之后，系统的手势返回就失效了。可以通过`forceEnableInteractivePopGestureRecognizer`来决定要不要把那个手势返回强制加回来
- (BOOL)forceEnableInteractivePopGestureRecognizer;

@end


/**
 *  @see UINavigationControllerBackButtonHandlerProtocol
 */
@interface UIViewController () <UINavigationControllerBackButtonHandlerProtocol>

@end

//
//  UIGestureRecognizer+YFAdd.h
//  MobileMall
//
//  Created by YangFei on 2017/3/30.
//  Copyright © 2017年 SoftBest1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (YFAdd)
typedef void(^YFGestureBlock)();


/**
 给手势绑定block, 不再需要繁琐地使用 selector 反射，解决代码分离的问题。
 @param block 手势出发执行发block
 @return 这个手势
 */
+ (instancetype)yf_gestureRecognizerWithBlock:(YFGestureBlock)block;

@end

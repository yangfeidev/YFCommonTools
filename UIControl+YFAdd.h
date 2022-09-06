//
//  UIControl+YFAdd.h
//  IOSMall
//
//  Created by YangFei on 2017/1/23.
//  Copyright © 2017年 Social. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (YFAdd)

/**
    响应区域需要改变的大小，负值表示往外扩大，正值表示往内缩小
 */
@property (nonatomic, assign) UIEdgeInsets yf_touchExtendInset;

/**
  重复点击的间隔, 隔这个  `yf_acceptEventInterval`  时间段后才可以再次响应点击事件
 */
@property (nonatomic, assign) NSTimeInterval yf_acceptEventInterval;


@end

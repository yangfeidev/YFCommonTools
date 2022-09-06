//
//  UILabel+YFAdd.h
//  YFZhiHuLoading
//
//  Created by YangFei on 2017/3/7.
//  Copyright © 2017年 JiuBianLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YFAdd)


/**
    控制label内容的padding，默认为UIEdgeInsetsZero
 */
@property (nonatomic, assign) UIEdgeInsets yf_contentInsets;


/**
 根据内容计算 label 合适的高度
 如果需要 yf_contentInsets , 需要先设置, 再调用这个方法
 @param rect 原label 的frame 需要确定 label 的 origin 和 width
 @return 计算好的 CGRect
 */
- (CGRect)yf_sizeThatFitsWithFrame:(CGRect)rect;

@end

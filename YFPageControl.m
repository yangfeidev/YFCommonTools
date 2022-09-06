//
//  YFPageControl.m
//  MobileMall
//
//  Created by fei.yang on 2019/5/27.
//  Copyright © 2019 SoftBest1. All rights reserved.
//

#import "YFPageControl.h"


#define dotW 8

#define dotH 3

#define magrin 5

@implementation YFPageControl

- (void)layoutSubviews
{
    //这里一定要调用
    [super layoutSubviews];
    //计算圆点间距
    CGFloat marginX = dotW + magrin;
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1) * marginX;
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView *dot = [self.subviews objectAtIndex:i];
//        if (i == self.currentPage) {
//            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
//        } else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
//        }
    }
}



@end

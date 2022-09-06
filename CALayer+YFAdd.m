//
//  CALayer+YFAdd.m
//  MobileMall
//
//  Created by fei.yang on 2019/9/4.
//  Copyright © 2019 SoftBest1. All rights reserved.
//

#import "CALayer+YFAdd.h"

@implementation CALayer (YFAdd)

- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}


@end

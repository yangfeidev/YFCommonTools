//
//  UIAlertController+YFAdd.m
//  MobileMall
//
//  Created by YangFei on 2017/2/24.
//  Copyright © 2017年 SoftBest1. All rights reserved.
//

#import "UIAlertController+YFAdd.h"

@implementation UIAlertController (YFAdd)
@dynamic yf_titleLabel;
@dynamic yf_messageLabel;

- (NSArray *)yf_viewArray:(UIView *)root {
    static NSArray *_subviews = nil;
    _subviews = nil;
    for (UIView *v in root.subviews) {
        if (_subviews) {
            break;
        }
        if ([v isKindOfClass:[UILabel class]]) {
            _subviews = root.subviews;
            return _subviews;
        }
        [self yf_viewArray:v];
    }
    return _subviews;
}

- (UILabel *)yf_titleLabel {
    return [self yf_viewArray:self.view][0];
}

- (UILabel *)yf_messageLabel {
    return [self yf_viewArray:self.view][1];
}

@end

//
//  UIGestureRecognizer+YFAdd.m
//  MobileMall
//
//  Created by YangFei on 2017/3/30.
//  Copyright © 2017年 SoftBest1. All rights reserved.
//

#import "UIGestureRecognizer+YFAdd.h"

typedef void(^YFGestureBlock)();

static const char * target_key = "target_key";

@implementation UIGestureRecognizer (YFAdd)

+ (instancetype)yf_gestureRecognizerWithBlock:(YFGestureBlock)block {
    return [[self alloc] initWithActionBlock:block];
}

- (instancetype)initWithActionBlock:(YFGestureBlock)block {
    self = [self init];
    [self addActionBlock:block];
    [self addTarget:self action:@selector(invoke:)];
    return self;
}

- (void)addActionBlock:(YFGestureBlock)block {
    if (block) {
        objc_setAssociatedObject(self, target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)invoke:(id)sender {
    YFGestureBlock block = objc_getAssociatedObject(self, target_key);
    if (block) {
        block(sender);
    }
}

@end

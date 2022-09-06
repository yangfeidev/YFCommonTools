//
//  NSObject+YFAdd.h
//  MobileMall
//
//  Created by fei.yang on 2019/11/11.
//  Copyright © 2019 SoftBest1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YFAdd)

+ (void)yf_propertyWithDictionary:(NSDictionary *)dict;

- (void)yf_performSelector:(SEL)selector withPrimitiveReturnValue:(nullable void *)returnValue;

@end

NS_ASSUME_NONNULL_END

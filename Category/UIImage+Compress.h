//
//  UIImage+Compress.h
//  ShunFuTianXia
//
//  Created by 赵世超 on 2021/6/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Compress)
- (NSData *)compressWithMaxLength:(NSUInteger)maxLength;
@end

NS_ASSUME_NONNULL_END

//
//  NSMutableAttributedString+YFAdd.h
//  MobileMall
//
//  Created by YangFei on 2018/2/9.
//  Copyright © 2018年 SoftBest1. All rights reserved.
//


typedef void(^CallBackBlock)(void);

#import <UIKit/UIKit.h>

#import "YYLabel.h"
#import "NSAttributedString+YYText.h"

@interface NSMutableAttributedString (YFAdd)

+ (NSMutableAttributedString *)yf_attributedString:(NSString *)string imageName:(NSString *)imageName;

+ (NSMutableAttributedString *)yf_attributedString:(NSString *)string imageName:(NSString *)imageName imageBounds:(CGRect)frame;

+ (NSMutableAttributedString *)yf_attributedString:(NSString *)string
                                         imageName:(NSString *)imageName
                                       imageBounds:(CGRect)frame
                                       imageAtLast:(BOOL)isAtLast;


+ (NSMutableAttributedString *)yf_newAttributedString:(NSString *)string netImageName:(NSString *)aPath;

+ (NSMutableAttributedString *)yf_attributedString:(NSString *)string bounds:(CGRect)bounds imageName:(NSString *)imageName;

- (NSAttributedString *)yf_truncationTokenWithCallBack:(CallBackBlock)callBack;


// 富文本便利构造
- (NSMutableAttributedString *)initWithString:(NSString *)string andColorHex:(NSString *)colorHex andFont:(UIFont *)font andRange:(NSRange)range;
// 金额富文本展示
- (NSMutableAttributedString *)initMoneyString:(NSString *)string withFont:(nullable UIFont *)font;
@end

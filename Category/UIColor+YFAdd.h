//
//  UIColor+YFAdd.h
//  MobileMall
//
//  Created by YangFei on 2017/12/22.
//  Copyright © 2017年 SoftBest1. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorMakeWithHex(hex) [UIColor yf_colorWithHexString:hex]


@interface UIColor (YFAdd)
/**
 *  使用HEX命名方式的颜色字符串生成一个UIColor对象
 *
 *  @param hexString
 *      #RGB        例如#f0f，等同于#ffff00ff，RGBA(255, 0, 255, 1)
 *      #ARGB       例如#0f0f，等同于#00ff00ff，RGBA(255, 0, 255, 0)
 *      #RRGGBB     例如#ff00ff，等同于#ffff00ff，RGBA(255, 0, 255, 1)
 *      #AARRGGBB   例如#00ff00ff，等同于RGBA(255, 0, 255, 0)
 *
 * @return UIColor对象
 */
+ (UIColor *)yf_colorWithHexString:(NSString *)hexString;
@end

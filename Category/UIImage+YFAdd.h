//
//  UIImage+YFAdd.h
//  IOSMall
//
//  Created by YangFei on 2017/1/12.
//  Copyright © 2017年 Social. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YFImageShape) {
    YFImageShapeOval,                 // 椭圆
    YFImageShapeTriangle,             // 三角形
    YFImageShapeDisclosureIndicator,  // 列表cell右边的箭头
    YFImageShapeCheckmark,            // 列表cell右边的checkmark
    YFImageShapeNavBack,              // 返回按钮的箭头
    YFImageShapeNavClose              // 导航栏的关闭icon
};

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YFAdd)

/**
 根据颜色创建指定大小图片
 @param color  颜色
 @param size   图片大小
 */
+ (nullable UIImage *)yf_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  创建一个指定大小和颜色的形状图片
 *  @param shape 图片形状
 *  @param size 图片大小
 *  @param tintColor 图片颜色
 */
+ (UIImage *)yf_imageWithShape:(YFImageShape)shape size:(CGSize)size tintColor:(UIColor *)tintColor;

/**
 *  判断一张图是否不存在 alpha 通道，注意 “不存在 alpha 通道” 不等价于 “不透明”。一张不透明的图有可能是存在 alpha 通道但 alpha 值为 1。
 */
- (BOOL)yf_opaque;

/**
 *  保持当前图片的形状不变，使用指定的颜色去重新渲染它，生成一张新图片并返回
 *
 *  @param tintColor 要用于渲染的新颜色
 *
 *  @return 与当前图片形状一致但颜色与参数tintColor相同的新图片
 */
- (UIImage *)yf_imageWithTintColor:(UIColor *)tintColor;


/**
 根据图片url获取网络图片尺寸

 @param URL 图片url
 @return 得到的image的大小
 */
+ (CGSize)yf_imageSizeWithURL:(id)URL;

/**
 *  切割出在指定位置中的图片
 *
 *  @param rect 要切割的rect
 *
 *  @return 切割后的新图片
 */
- (UIImage *)yf_imageWithClippedRect:(CGRect)rect;




/**
 给 image 对象添加圆角

 @param radius 圆角大小
 @return 添加圆角后的 image 对象
 */
- (UIImage *)yf_imageWithCornerRadius:(CGFloat)radius;




NS_ASSUME_NONNULL_END
@end

//
//  UIImage+YFAdd.m
//  IOSMall
//
//  Created by YangFei on 2017/1/12.
//  Copyright © 2017年 Social. All rights reserved.
//

#import "UIImage+YFAdd.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (YFAdd)

+ (UIImage *)yf_imageWithColor:(UIColor *)color size:(CGSize)size {
    
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)yf_imageWithShape:(YFImageShape)shape size:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat lineWidth = 0;
    switch (shape) {
        case YFImageShapeNavBack:
            lineWidth = 2.0f;
            break;
        case YFImageShapeDisclosureIndicator:
            lineWidth = 1.5f;
            break;
        case YFImageShapeCheckmark:
            lineWidth = 1.5f;
            break;
        case YFImageShapeNavClose:
            lineWidth = 1.2f;   // 取消icon默认的lineWidth
            break;
        default:
            break;
    }
    return [UIImage yf_imageWithShape:shape size:size lineWidth:lineWidth tintColor:tintColor];
}

+ (UIImage *)yf_imageWithShape:(YFImageShape)shape size:(CGSize)size lineWidth:(CGFloat)lineWidth tintColor:(UIColor *)tintColor {

    UIImage *resultImage = nil;
    tintColor = tintColor ? tintColor : UIColorWhite;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = nil;
    BOOL drawByStroke = NO;
    CGFloat drawOffset = lineWidth / 2;
    switch (shape) {
        case YFImageShapeOval: {
            path = [UIBezierPath bezierPathWithOvalInRect:CGRectMakeWithSize(size)];
        }
            break;
        case YFImageShapeTriangle: {
            path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, size.height)];
            [path addLineToPoint:CGPointMake(size.width / 2, 0)];
            [path addLineToPoint:CGPointMake(size.width, size.height)];
            [path closePath];
        }
            break;
        case YFImageShapeNavBack: {
            drawByStroke = YES;
            path = [UIBezierPath bezierPath];
            path.lineWidth = lineWidth;
            [path moveToPoint:CGPointMake(size.width - drawOffset, drawOffset)];
            [path addLineToPoint:CGPointMake(0 + drawOffset, size.height / 2.0)];
            [path addLineToPoint:CGPointMake(size.width - drawOffset, size.height - drawOffset)];
        }
            break;
        case YFImageShapeDisclosureIndicator: {
            path = [UIBezierPath bezierPath];
            drawByStroke = YES;
            path.lineWidth = lineWidth;
            [path moveToPoint:CGPointMake(drawOffset, drawOffset)];
            [path addLineToPoint:CGPointMake(size.width - drawOffset, size.height / 2)];
            [path addLineToPoint:CGPointMake(drawOffset, size.height - drawOffset)];
        }
            break;
        case YFImageShapeCheckmark: {
            CGFloat lineAngle = M_PI_4;
            path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, size.height / 2)];
            [path addLineToPoint:CGPointMake(size.width / 3, size.height)];
            [path addLineToPoint:CGPointMake(size.width, lineWidth * sin(lineAngle))];
            [path addLineToPoint:CGPointMake(size.width - lineWidth * cos(lineAngle), 0)];
            [path addLineToPoint:CGPointMake(size.width / 3, size.height - lineWidth / sin(lineAngle))];
            [path addLineToPoint:CGPointMake(lineWidth * sin(lineAngle), size.height / 2 - lineWidth * sin(lineAngle))];
            [path closePath];
        }
            break;
        case YFImageShapeNavClose: {
            drawByStroke = YES;
            path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(size.width, size.height)];
            [path closePath];
            [path moveToPoint:CGPointMake(size.width, 0)];
            [path addLineToPoint:CGPointMake(0, size.height)];
            [path closePath];
            path.lineWidth = lineWidth;
            path.lineCapStyle = kCGLineCapRound;
        }
            break;
        default:
            break;
    }
    
    if (drawByStroke) {
        CGContextSetStrokeColorWithColor(context, tintColor.CGColor);
        [path stroke];
    } else {
        CGContextSetFillColorWithColor(context, tintColor.CGColor);
        [path fill];
    }
    
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

- (BOOL)yf_opaque {
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast
    || alphaInfo == kCGImageAlphaNoneSkipFirst
    || alphaInfo == kCGImageAlphaNone;
    return opaque;
}


- (UIImage *)yf_imageWithTintColor:(UIColor *)tintColor {
    UIImage *imageIn = self;
    CGRect rect = CGRectMake(0, 0, imageIn.size.width, imageIn.size.height);
    UIGraphicsBeginImageContextWithOptions(imageIn.size, self.yf_opaque, imageIn.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, imageIn.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, imageIn.CGImage);
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

+ (CGSize)yf_imageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    
    NSString * urlStr = [url absoluteString];
    
    CGImageSourceRef imageSourceRef = nil;
    if ([YFHelper isUrl:urlStr]) {
        imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    }
    
    
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        //以下是对手机32位、64位的处理
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            CFRelease(imageProperties);
        }

        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

- (UIImage *)yf_imageWithClippedRect:(CGRect)rect {
    CGRect imageRect = CGRectMakeWithSize(self.size);
    if (CGRectContainsRect(rect, imageRect)) {
        // 要裁剪的区域比自身大，所以不用裁剪直接返回自身即可
        return self;
    }
    // 由于CGImage是以pixel为单位来计算的，而UIImage是以point为单位，所以这里需要将传进来的point转换为pixel
    CGRect scaledRect = CGRectApplyScale(rect, self.scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, scaledRect);
    UIImage *imageOut = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return imageOut;

}


- (UIImage *)yf_imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0 ,0, self.size};
    // size——同UIGraphicsBeginImageContext,参数size为新创建的位图上下文的大小
    // opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    // scale—–缩放因子
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    // 根据矩形画带圆角的曲线
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    [self drawInRect:rect];
    // 图片缩放，是非线程安全的
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}



@end

//
//  NSMutableAttributedString+YFAdd.m
//  MobileMall
//
//  Created by YangFei on 2018/2/9.
//  Copyright © 2018年 SoftBest1. All rights reserved.
//

#import "NSMutableAttributedString+YFAdd.h"


@implementation NSMutableAttributedString (YFAdd)


+ (NSMutableAttributedString *)yf_attributedString:(NSString *)string imageName:(NSString *)imageName {
    /// 拿到整体的字符串
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    /// 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:imageName];
    attach.bounds = CGRectMake(0, -3, 35, 16);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    /// 将图片插入到合适的位置
    [attributedString insertAttributedString:attachString atIndex:0];
    
    return attributedString;
}

+ (NSMutableAttributedString *)yf_attributedString:(NSString *)string bounds:(CGRect)bounds imageName:(NSString *)imageName {
    /// 拿到整体的字符串
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    /// 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:imageName];
    attach.bounds = bounds;
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    /// 将图片插入到合适的位置
    [attributedString insertAttributedString:attachString atIndex:0];
    
    return attributedString;
}

//网络图片

+ (NSMutableAttributedString *)yf_newAttributedString:(NSString *)string netImageName:(NSString *)aPath {
    /// 拿到整体的字符串
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    /// 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    
    if (GlobalData.PreDeliveryImage) {
        attach.image = GlobalData.PreDeliveryImage;
    }
    // 这个不会走(非常低可能性)
    else {
        attach.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[CacheHelper PreDeliveryImageUrl]]]];
    }
    
    attach.bounds = CGRectMake(0, -3, 50, 16);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    /// 将图片插入到合适的位置
    [attributedString insertAttributedString:attachString atIndex:0];
    
    return attributedString;
}

+ (NSMutableAttributedString *)yf_attributedString:(NSString *)string imageName:(NSString *)imageName imageBounds:(CGRect)frame {
    /// 拿到整体的字符串
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    /// 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:imageName];
    attach.bounds = frame;
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    /// 将图片插入到合适的位置
    [attributedString insertAttributedString:attachString atIndex:0];
    
    return attributedString;
}

+ (NSMutableAttributedString *)yf_attributedString:(NSString *)string
                                         imageName:(NSString *)imageName
                                       imageBounds:(CGRect)frame
                                       imageAtLast:(BOOL)isAtLast {
    /// 拿到整体的字符串
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    /// 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:imageName];
    attach.bounds = frame;
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    /// 将图片插入到合适的位置
    [attributedString insertAttributedString:attachString atIndex:isAtLast ? string.length : 0];
    
    return attributedString;
}




- (NSAttributedString *)yf_truncationTokenWithCallBack:(CallBackBlock)callBack {

    YYTextHighlight *hi = [YYTextHighlight new];
//    [hi setColor:color];
    
    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) {

        if (callBack) {
            callBack();
        }
    };
    

//    [self yy_setColor:color range:[self.string rangeOfString:self.string]];
    [self yy_setTextHighlight:hi range:[self.string rangeOfString:self.string]];
//    self.yy_font = font;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = self;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore
                                                                                 contentMode:UIViewContentModeCenter
                                                                              attachmentSize:seeMore.frame.size
                                                                                 alignToFont:self.yy_font
                                                                                   alignment:YYTextVerticalAlignmentCenter];
        
    return truncationToken;
    
}

- (NSMutableAttributedString *)initMoneyString:(NSString *)string withFont:(UIFont *)font {
    self = [[NSMutableAttributedString alloc] initWithString:string];
    NSString *validString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!IsBlankString(validString)) {
        NSString *amountString = validString;
        if ([amountString containsString:@" "]) {
            NSInteger location = [string rangeOfString:@" "].location+1;
            amountString = [amountString substringFromIndex:location];
        }else if([amountString containsString:@"¥"]) {
            NSInteger location = [string rangeOfString:@"¥"].location+1;
            amountString = [amountString substringFromIndex:location];
        }
        
//        if ([amountString containsString:@"."]) {
//            NSInteger location = [string rangeOfString:@"."].location-1;
//            amountString = [amountString substringToIndex:location];
//        }
        NSRange amountRange = [validString rangeOfString:amountString];
        self = [self initWithString:validString andColorHex:nil andFont:font andRange:amountRange];
    }
    return self;
}


- (NSMutableAttributedString *)initWithString:(NSString *)string andColorHex:(NSString *)colorHex andFont:(UIFont *)font andRange:(NSRange)range {
    self = [[NSMutableAttributedString alloc] initWithString:string];
    if (self) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (colorHex) {
            [dic setValue:UIColorMakeWithHex(colorHex) forKey:NSForegroundColorAttributeName];
        }
        if (font) {
            [dic setValue:font forKey:NSFontAttributeName];
        }
        [self addAttributes:dic range:range];
    }
    return self;
}


@end

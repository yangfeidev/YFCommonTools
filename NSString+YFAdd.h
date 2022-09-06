//
//  NSString+YFAdd.h
//  
//
//  Created by YangFei on 2016/12/27.
//  Copyright © 2016年 Social. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface NSString (YFAdd)

/**
 *  判断自己是否为空 null null null NULL nil
 *
 *  @return 是否为空
 */
- (BOOL)yf_isBlank;

/**
 Returns an NSDictionary/NSArray which is decoded from receiver.
 Returns nil if an error occurs.
 
 e.g. NSString: @"{"name":"a","count":2}"  => NSDictionary: @[@"name":@"a",@"count":@2]
 */
- (id)yf_jsonValueDecoded;

/**
 计算字符串的size

 @param font 字体
 @param size 限制范围
 @param lineBreakMode 换行方式
 @return 计算后的大小
 */
/*
    UILineBreakModeWordWrap = 0,
 以单词为单位换行，以单位为单位截断。
 
    UILineBreakModeCharacterWrap,
 以字符为单位换行，以字符为单位截断。
 
    UILineBreakModeClip,
 以单词为单位换行。以字符为单位截断。
 
    UILineBreakModeHeadTruncation,
 以单词为单位换行。如果是单行，则开始部分有省略号。如果是多行，则中间有省略号，省略号后面有4个字符。
 
    UILineBreakModeTailTruncation,
 以单词为单位换行。无论是单行还是多行，都是末尾有省略号。
 
    UILineBreakModeMiddleTruncation,
 以单词为单位换行。无论是单行还是多行，都是中间有省略号，省略号后面只有2个字符。
 */
- (CGSize)yf_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;


/**
 Returns a new UUID NSString
 e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 */
+ (NSString *)yf_stringWithUUID;


/*
        正则表达式判断是否为手机号
 电信号段:133/153/180/181/189/177
 联通号段:130/131/132/155/156/185/186/145/176
 移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
 虚拟运营商:170
 */
- (BOOL)yf_isMobileNumber:(NSString *)mobileNum;



/**
 通过html字符串生成对应的attributedText

 @param htmlString html 字符串
 @return attributedText
 */
+ (NSAttributedString *)yf_stringToAttributedText:(NSString *)htmlString;



/**
 格式化 string 格式的 数值

 @param numString sting格式的数值
 @return 格式化后的数值字符串     // 例如: 传入 @"123.4503", 返回123.45.    传入 123.00 , 返回 123  
 */
+ (NSString *)yf_formatNumString:(NSString *)numString;




@end

/**
 NSInteger, CGFloat 快速转换字符串
 */
@interface NSString (YF_StringFormat)
+ (instancetype)yf_stringWithNSInteger:(NSInteger)integerValue;
+ (instancetype)yf_stringWithCGFloat:(CGFloat)floatValue;
+ (instancetype)yf_stringWithCGFloat:(CGFloat)floatValue decimal:(NSUInteger)decimal;
@end

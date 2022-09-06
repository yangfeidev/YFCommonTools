//
//  NSString+YFAdd.m
//  
//
//  Created by YangFei on 2016/12/27.
//  Copyright © 2016年 Social. All rights reserved.
//

#import "NSString+YFAdd.h"
#import "NSData+YFAdd.h"

@implementation NSString (YFAdd)

- (BOOL)yf_isBlank
{
    if (!self.length ||
        self == nil ||
        self == NULL ||
        (NSNull *)self == [NSNull null] ||
        [self isKindOfClass:[NSNull class]] ||
        [self isEqualToString:@"(null)"] ||
        [self isEqualToString:@"<null>"] ||
        [self isEqualToString:@"null"] ||
        [self isEqualToString:@"NULL"]
        ) {
        return YES;
    }else {
        return NO;
    }
}

- (NSData *)yf_dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)yf_jsonValueDecoded {
    return [[self yf_dataValue] yf_jsonValueDecoded];
}


- (CGSize)yf_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

+ (NSString *)yf_stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

- (BOOL)yf_isMobileNumber:(NSString *)mobileNum {
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [predicate evaluateWithObject:mobileNum];
}


+  (NSAttributedString *)yf_stringToAttributedText:(NSString *)htmlString {
    NSData *dataStr = [htmlString dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *dict = @{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:dataStr options:dict documentAttributes:nil   error:nil];
    return attrStr;
}



+ (NSString *)yf_formatNumString:(NSString *)numString {
    
    if (![numString containsString:@"."]) return numString;
    
    NSArray *numArray = [numString componentsSeparatedByString:@"."];
    NSString *integerNum = numArray[0];
    NSString *decimalNum = [numArray[1] substringToIndex:2];
    
    return (decimalNum.integerValue)?[NSString stringWithFormat:@"%@.%@",integerNum,decimalNum]:integerNum;
}


@end

@implementation NSString (YF_StringFormat)

+ (instancetype)yf_stringWithNSInteger:(NSInteger)integerValue {
    return [NSString stringWithFormat:@"%@", @(integerValue)];
}

+ (instancetype)yf_stringWithCGFloat:(CGFloat)floatValue {
    return [NSString yf_stringWithCGFloat:floatValue decimal:2];
}

+ (instancetype)yf_stringWithCGFloat:(CGFloat)floatValue decimal:(NSUInteger)decimal {
    NSString *formatString = [NSString stringWithFormat:@"%%.%@f", @(decimal)];
    return [NSString stringWithFormat:formatString, floatValue];
}

@end

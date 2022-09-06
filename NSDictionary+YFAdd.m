//
//  NSDictionary+YFAdd.m
//  
//
//  Created by YangFei on 2016/12/27.
//  Copyright © 2016年 Social. All rights reserved.
//

#import "NSDictionary+YFAdd.h"

@implementation NSDictionary (YFAdd)

- (NSString *)yf_jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        /** option 如果设置为 0, 输出为一整行, 否则会格式化输出 */
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (NSString *)getObjectForKey:(NSString *)key {
    NSString *value = @"";
    NSString *obj = [NSString stringWithFormat:@"%@", [self objectForKey:key]];
    if (!IsBlankString(obj)) {
        value = obj;
    }
    return value;
}
@end

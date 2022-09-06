//
//  NSData+YFAdd.m
//
//
//  Created by YangFei on 2016/12/27.
//  Copyright © 2016年 Social. All rights reserved.
//

#import "NSData+YFAdd.h"

@implementation NSData (YFAdd)

- (id)yf_jsonValueDecoded {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}
@end

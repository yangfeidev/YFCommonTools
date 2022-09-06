//
//  NSDictionary+YFAdd.h
//  
//
//  Created by YangFei on 2016/12/27.
//  Copyright © 2016年 Social. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YFAdd)

NS_ASSUME_NONNULL_BEGIN
/**
 Convert dictionary to json string. return nil if an error occurs.
 */
- (nullable NSString *)yf_jsonStringEncoded;
- (NSString *)getObjectForKey:(NSString *)key;
NS_ASSUME_NONNULL_END

@end

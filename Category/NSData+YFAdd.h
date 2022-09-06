//
//  NSData+YFAdd.h
//  
//
//  Created by YangFei on 2016/12/27.
//  Copyright © 2016年 Social. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YFAdd)
NS_ASSUME_NONNULL_BEGIN
/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id)yf_jsonValueDecoded;

NS_ASSUME_NONNULL_END
@end

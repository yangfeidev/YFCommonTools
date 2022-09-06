//
//  MallJumpTool.h
//  MobileMall
//
//  Created by YangFei on 2018/8/3.
//  Copyright © 2018年 SoftBest1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFSectionItemModel.h"

@interface MallJumpTool : NSObject

+ (instancetype)sharedTool;

+ (void)jumpWithNavigationController:(UINavigationController *)nav
                    tabBarController:(UITabBarController *)tabBarController
                   itemNavigationUrl:(NSString *)itemNavigationUrl;

+ (void)jumpWithNavigationController:(UINavigationController *)nav
                    tabBarController:(UITabBarController *)tabBar
                           itemModel:(YFSectionItemModel *)itemModel
                           isWebJSload:(BOOL)isWebJSload;

- (void)recordClickHistory:(YFSectionItemModel *)model;

@end

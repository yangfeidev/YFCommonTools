//
//  UITableView+YFAdd.h
//
//  Created by YangFei on 2018/8/19.
//  Copyright © 2018年 SoftBest1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YFAdd)

/**
 有提示语, 无图

 @param title 提示语
 @param data 数据源
 */
- (void)yf_noDataWithTitle:(NSString *)title data:(NSMutableArray *)data;

/**
  有图, 无提示语

 @param imageName 图片名称
 @param data 数据源
 */
- (void)yf_noDataWithImageName:(NSString *)imageName data:(NSMutableArray *)data;

/**
 有提示语, 有图

 @param title 提示语
 @param imageName 图片名称
 @param data 数据源
 */
- (void)yf_noDataWithTitle:(NSString *)title imageName:(NSString *)imageName data:(NSMutableArray *)data;


- (void)yf_noDataFooterView;

- (void)yf_noDataFooterViewWithTitle:(NSString *)title;


@end




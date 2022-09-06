//
//  UICollectionView+YFAdd.h
//  MobileMall
//
//  Created by fei.yang on 2019/12/17.
//  Copyright © 2019 SoftBest1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (YFAdd)
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

@end

NS_ASSUME_NONNULL_END

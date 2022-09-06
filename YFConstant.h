//
//  YFConstant.h
//  MobileMall
//
//  Created by YangFei on 2016/11/1.
//  Copyright © 2016年 SoftBest1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NSString*  NSNotificationName;

FOUNDATION_EXTERN NSNotificationName const  PushToPointRecordNotification;

FOUNDATION_EXTERN NSNotificationName const  MyPointViewControllerPopNotification;

FOUNDATION_EXTERN NSNotificationName const  PresentTimeSelectViewControllerNotification;

FOUNDATION_EXTERN NSNotificationName const  UserCenterAutoPushToHomePageNotification;

FOUNDATION_EXPORT NSNotificationName const  YFClubListRefreshListNotification;

FOUNDATION_EXPORT NSNotificationName const  ChangeLoginStatusNotification;

FOUNDATION_EXPORT NSNotificationName const  HPJumpWithSectionItemNotification;

FOUNDATION_EXPORT NSNotificationName const  RefreshShoppingCartNotification;

FOUNDATION_EXPORT NSNotificationName const  ConfigBrandClubBtnNotification;

FOUNDATION_EXPORT NSNotificationName const  ClubExchangeSuccessNotification;

FOUNDATION_EXPORT NSNotificationName const  ChangeAddressRefreshNotification;

FOUNDATION_EXPORT NSNotificationName const  RefreshClubIconNotification;


FOUNDATION_EXTERN NSString * const  IsPresentTimeSelectViewControllerKey;

FOUNDATION_EXTERN NSString * const  IsGoToHomePageKey;
FOUNDATION_EXPORT NSString * const  MobileMallDownloadUrlKey;

FOUNDATION_EXPORT NSString * const  JPushMessageKey;

FOUNDATION_EXPORT NSString * const  ChangeListStyleShowKPKey;

FOUNDATION_EXPORT NSString * const   RefreshAccountMoneyNotification;

FOUNDATION_EXPORT NSNotificationName const ChangeProductListStyleNotification;

FOUNDATION_EXPORT NSNotificationName const RefreshMainInfoNotification;


FOUNDATION_EXPORT NSString * const PayMethodKey;


FOUNDATION_EXPORT NSNotificationName const RefreshFlashSaleNotification;

FOUNDATION_EXPORT NSNotificationName const RefreshWithSearchResultNotification;

FOUNDATION_EXPORT NSNotificationName const IntegratedSortNotification;/// 综合排序

FOUNDATION_EXPORT NSNotificationName const OrderBySalesNotification;

FOUNDATION_EXPORT NSNotificationName const OrderByPriceNotification;


FOUNDATION_EXPORT NSNotificationName const  ChangeRefreshStatusLabelColorNotification;

FOUNDATION_EXPORT NSNotificationName const  UnionPayResultNotification;

FOUNDATION_EXPORT NSNotificationName const  AppDidEnterForegroundNotification;

FOUNDATION_EXPORT NSString * const MallJumpCountSecondsKey;


FOUNDATION_EXPORT NSString * const MallPushToDetailWineNameKey;



FOUNDATION_EXPORT NSNotificationName const  CalloutViewDidClickedNotification;

/// 环信收到消息
FOUNDATION_EXPORT NSNotificationName const  HXDidReceiveMessageNotification;


FOUNDATION_EXPORT NSNotificationName const  RefreshWelfareMainPageNotification;

FOUNDATION_EXPORT NSNotificationName const  DidAddProductToShoppingCartNotification;

FOUNDATION_EXPORT NSNotificationName const  DidChangeNationalSalesNotification;

FOUNDATION_EXPORT NSNotificationName const  ForceChangeNationalSaleNotification;

FOUNDATION_EXPORT NSNotificationName const  OpenPlusSuccessNotification;

/// 切换地址后，需要刷新个人中心-常用功能按钮
FOUNDATION_EXPORT NSNotificationName const  UpdateUserCenterGridNotification;

FOUNDATION_EXPORT NSNotificationName const  RefreshProductDetailNotification;


// 设置tabBar数量
FOUNDATION_EXPORT NSNotificationName const  SetTabBarItemsCountAndTitlesNotificaton;

// 更新tabBar颜色和选中未选中图片
FOUNDATION_EXPORT NSNotificationName const RefreshTabBarImageNotification;


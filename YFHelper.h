//
//  YFHelper.h
//
//  Created by YangFei on 2017/3/8.
//  Copyright © 2017年 JiuBianLi. All rights reserved.
//


/*
 * 工具类
 */
static BOOL isBackFromDetailPage;
static BOOL isLoadingNetWorking;
static NSArray *welfareImages;

//地址



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YFHelper : NSObject

+ (instancetype)sharedInstance;

@end


@interface YFHelper (Device)

+ (BOOL)isIPad;
+ (BOOL)isIPadPro;
+ (BOOL)isIPod;
+ (BOOL)isIPhone;
+ (BOOL)isSimulator;

/// 是否刘海屏型的设备
+ (BOOL)isNotchedScreen;

/// iPhone XS Max
+ (BOOL)is65InchScreen;

/// iPhone XR
+ (BOOL)is61InchScreen;

/// iPhone X/XS
+ (BOOL)is58InchScreen;
+ (BOOL)is55InchScreen;
+ (BOOL)is47InchScreen;
+ (BOOL)is40InchScreen;
+ (BOOL)is35InchScreen;

+ (CGSize)screenSizeFor58Inch;
+ (CGSize)screenSizeFor55Inch;
+ (CGSize)screenSizeFor47Inch;
+ (CGSize)screenSizeFor40Inch;
+ (CGSize)screenSizeFor35Inch;

/**
 获取设备名称 如: iPhone X
 @return 设备名称
 */
+ (NSString *)deviceType;

+ (BOOL)hasChinese:(NSString *)str;//判断是否有汉字

@end


@interface YFHelper (Tool)

/**
 拨打电话
 
 @param phoneNumber 要拨打的号码
 */
+ (void)callWithNumber:(NSString * )phoneNumber;


/**
 获取当前控制器

 @return 当前控制器
 */
+ (UIViewController * )currentViewController;






/**
 存取每一个城市的对应的 几小时到达的地址 void
 */



+(void)getCityArrivedImage;
+(CGFloat)getDiscountRate;
//俱乐部内容
+(CGFloat)getClubContentHeight;
//处理这种sb时间结构 处理带T的
+(NSString *)getNewTimeStr:(NSString *)time;


+(NSInteger)timeTotimeStr:(NSString *)formatTime andFormatter:(NSString *)format setcurry:(BOOL)isorno;

+(NSString *)timeStrToTime:(NSInteger)timeStr setFormat:(NSString *)format;

+ (NSString *)getJBLTimeYMD:(NSString *)dateStr;

+ (NSString *)getJBLTimeYMD_HM:(NSString *)dateStr;

+ (NSString *)getJBLTimeYMDChinaYMD:(NSString *)dateStr;

+ (NSString *)getJBLTimeYMDChinaMD:(NSString *)dateStr;

+ (NSString *)getJBLTimeYMDChinaYMDHM:(NSString *)dateStr;



+(NSString *)changeChineseToEnglish:(NSString *)ursStr;

+(void)setIsBackFromDetailPage:(BOOL)value;
+(BOOL)getIsBackFromDetailPage;

+(void)setIsLoadingNetWoring:(BOOL)value;
+(BOOL)getIsLoadingNetWoring;

+(void)setWelFareImages:(NSArray *)arr;
+(NSArray *)getWelfareImages;



+ (NSInteger)getTotalTimeForSeconds:(NSString *)startTime endTime:(NSString *)endTime;

+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startTime withExpireTime:(NSString *)expireTime;//判断在时间范围内

+ (NSString *)getJBLTimeYMDChinaDianYMD:(NSString *)dateStr;

+ (NSString *)getJBLTimeYMDChinaDianMinuteYMDHM:(NSString *)dateStr;

+ (NSString *)getJBLTimeYMDChinaDianMinuteYMDHMS:(NSString *)dateStr;

+ (NSDate *)JBL_T_TimeToFullDate:(NSString *)datetime;




+(MJRefreshGifHeader *)setMjHeaderGift:(id)value setMotherGategro:(id)value1;//uivie 使用刷新


+(BOOL)isUrl:(NSString *)url1;
/*
 *完善储存的不足
 */

//保存城市名字
+(void)saveCityName:(NSString * )value;
+(NSString * )getCityName;

/// 保存是否开通俱乐部
+ (void)setIsOpenBrandClub:(BOOL)value;

+ (BOOL )IsOpenBrandClub;

+ (void)setBrandClubImageUrl:(NSString *)imageUrl;

+ (NSString *)brandClubImageUrl;

+ (void)setClubJumpNavigationUrl:(NSString *)navigationUrl;

+ (NSString *)clubJumpNavigationUrl ;

//+(NSString *)jungelShowOrHide;



/**
 设置字体大小不一样的价格
 
 @param priceLabel 要设置的label
 @param price 要设置的价格
 @param leftSize 左边大小
 @param middleSize 中间大小
 @param rightSize 右边大小
 */
+ (void)configureLabel:(UILabel *)priceLabel
                 price:(NSString *)price
              leftSize:(int)leftSize
               midSize:(int)middleSize
             rightSize:(int)rightSize;


/**
处理四舍五入
 */
+(NSString *)fourGoFiveReceive:(NSString *)value;


/// 字符串判空
BOOL IsBlankString(NSString *checkedString);

//获取用户头像
+ (UIImage *)userIcon;

@end





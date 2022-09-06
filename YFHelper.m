//
//  YFHelper.m
//
//  Created by YangFei on 2017/3/8.
//  Copyright © 2017年 JiuBianLi. All rights reserved.
//

#import "YFHelper.h"
#import <sys/utsname.h>

#define DEVICE_WIDTH    ([UIScreen mainScreen].bounds.size.width)

#define DEVICE_HEIGHT   ([UIScreen mainScreen].bounds.size.height)


@implementation YFHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static YFHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end

@implementation YFHelper (Device)

static NSInteger isIPad = -1;
+ (BOOL)isIPad {
    if (isIPad < 0) {
        // [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] 无法判断模拟器，改为以下方式
        isIPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 1 : 0;
    }
    return isIPad > 0;
}

static NSInteger isIPadPro = -1;
+ (BOOL)isIPadPro {
    if (isIPadPro < 0) {
        isIPadPro = [YFHelper isIPad] ? (DEVICE_WIDTH == 1024 && DEVICE_HEIGHT == 1366 ? 1 : 0) : 0;
    }
    return isIPadPro > 0;
}

static NSInteger isIPod = -1;
+ (BOOL)isIPod {
    if (isIPod < 0) {
        isIPod = [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"] ? 1 : 0;
    }
    return isIPod > 0;
}

static NSInteger isIPhone = -1;
+ (BOOL)isIPhone {
    if (isIPhone < 0) {
        isIPhone = [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] ? 1 : 0;
    }
    return isIPhone > 0;
}

static NSInteger isSimulator = -1;
+ (BOOL)isSimulator {
    if (isSimulator < 0) {
#if TARGET_OS_SIMULATOR
        isSimulator = 1;
#else
        isSimulator = 0;
#endif
    }
    return isSimulator > 0;
}

//+ (BOOL)isNotchedScreen {
//    return [self is65InchScreen] || [self is61InchScreen] || [self is58InchScreen];
//}

/// fei.yang 开始修改 以下 ⤵️ ********* ///
static NSInteger isNotchedScreen = -1;
+ (BOOL)isNotchedScreen {
    if (@available(iOS 11, *)) {
        if (isNotchedScreen < 0) {
            if (@available(iOS 12.0, *)) {
                /*
                 检测方式解释/测试要点：
                 1. iOS 11 与 iOS 12 可能行为不同，所以要分别测试。
                 2. 与触发 [QMUIHelper isNotchedScreen] 方法时的进程有关，例如 https://github.com/Tencent/QMUI_iOS/issues/482#issuecomment-456051738 里提到的 [NSObject performSelectorOnMainThread:withObject:waitUntilDone:NO] 就会导致较多的异常。
                 3. iOS 12 下，在非第2点里提到的情况下，iPhone、iPad 均可通过 UIScreen -_peripheryInsets 方法的返回值区分，但如果满足了第2点，则 iPad 无法使用这个方法，这种情况下要依赖第4点。
                 4. iOS 12 下，不管是否满足第2点，不管是什么设备类型，均可以通过一个满屏的 UIWindow 的 rootViewController.view.frame.origin.y 的值来区分，如果是非全面屏，这个值必定为20，如果是全面屏，则可能是24或44等不同的值。但由于创建 UIWindow、UIViewController 等均属于较大消耗，所以只在前面的步骤无法区分的情况下才会使用第4点。
                 5. 对于第4点，经测试与当前设备的方向、是否有勾选 project 里的 General - Hide status bar、当前是否处于来电模式的状态栏这些都没关系。
                 */
                SEL peripheryInsetsSelector = NSSelectorFromString([NSString stringWithFormat:@"_%@%@", @"periphery", @"Insets"]);
                UIEdgeInsets peripheryInsets = UIEdgeInsetsZero;
                [[UIScreen mainScreen] yf_performSelector:peripheryInsetsSelector withPrimitiveReturnValue:&peripheryInsets];
                if (peripheryInsets.bottom <= 0) {
                    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
                    peripheryInsets = window.safeAreaInsets;
                    if (peripheryInsets.bottom <= 0) {
                        UIViewController *viewController = [UIViewController new];
                        window.rootViewController = viewController;
                        if (CGRectGetMinY(viewController.view.frame) > 20) {
                            peripheryInsets.bottom = 1;
                        }
                    }
                }
                isNotchedScreen = peripheryInsets.bottom > 0 ? 1 : 0;
            } else {
                isNotchedScreen = [YFHelper is58InchScreen] ? 1 : 0;
            }
        }
    } else {
        isNotchedScreen = 0;
    }
    
    return isNotchedScreen > 0;
}
/// fei.yang 修改结束 以上 ⤴️********* ///


static NSInteger is65InchScreen = -1;
+ (BOOL)is65InchScreen {
    if (is65InchScreen < 0) {
        /// 由于 iPhone XS Max 和 iPhone XR 的屏幕宽高是一致的，我们通过机器 Identifier 加以区别
        is65InchScreen = (DEVICE_WIDTH == self.screenSizeFor65Inch.width &&
                          DEVICE_HEIGHT == self.screenSizeFor65Inch.height) ? 1 : 0;
    }
    return is65InchScreen > 0;
}

static NSInteger is61InchScreen = -1;
+ (BOOL)is61InchScreen {
    if (is61InchScreen < 0) {
        is61InchScreen = (DEVICE_WIDTH == self.screenSizeFor61Inch.width &&
                          DEVICE_HEIGHT == self.screenSizeFor61Inch.height) ? 1 : 0;
    }
    return is61InchScreen > 0;
}

static NSInteger is58InchScreen = -1;
+ (BOOL)is58InchScreen {
    if (is58InchScreen < 0) {
        /// iPhone XS 和 iPhone X 的物理尺寸是一致的，因此无需比较机器 Identifier
        is58InchScreen = (DEVICE_WIDTH == self.screenSizeFor58Inch.width && DEVICE_HEIGHT == self.screenSizeFor58Inch.height) ? 1 : 0;
    }
    return is58InchScreen > 0;
}

static NSInteger is55InchScreen = -1;
+ (BOOL)is55InchScreen {
    if (is55InchScreen < 0) {
        is55InchScreen = (DEVICE_WIDTH == self.screenSizeFor55Inch.width && DEVICE_HEIGHT == self.screenSizeFor55Inch.height) ? 1 : 0;
    }
    return is55InchScreen > 0;
}

static NSInteger is47InchScreen = -1;
+ (BOOL)is47InchScreen {
    if (is47InchScreen < 0) {
        is47InchScreen = (DEVICE_WIDTH == self.screenSizeFor47Inch.width && DEVICE_HEIGHT == self.screenSizeFor47Inch.height) ? 1 : 0;
    }
    return is47InchScreen > 0;
}

static NSInteger is40InchScreen = -1;
+ (BOOL)is40InchScreen {
    if (is40InchScreen < 0) {
        is40InchScreen = (DEVICE_WIDTH == self.screenSizeFor40Inch.width && DEVICE_HEIGHT == self.screenSizeFor40Inch.height) ? 1 : 0;
    }
    return is40InchScreen > 0;
}

static NSInteger is35InchScreen = -1;
+ (BOOL)is35InchScreen {
    if (is35InchScreen < 0) {
        is35InchScreen = (DEVICE_WIDTH == self.screenSizeFor35Inch.width && DEVICE_HEIGHT == self.screenSizeFor35Inch.height) ? 1 : 0;
    }
    return is35InchScreen > 0;
}

+ (CGSize)screenSizeFor67Inch {
    return CGSizeMake(428, 926);
}

+ (CGSize)screenSizeFor65Inch {
    return CGSizeMake(414, 896);
}

+ (CGSize)screenSizeFor61Inch {
    return CGSizeMake(414, 896);
}

+ (CGSize)screenSizeFor61InchAndiPhone12 {
    return CGSizeMake(390, 844);
}

+ (CGSize)screenSizeFor58Inch {
    return CGSizeMake(375, 812);
}

+ (CGSize)screenSizeFor55Inch {
    return CGSizeMake(414, 736);
}

+ (CGSize)screenSizeFor47Inch {
    return CGSizeMake(375, 667);
}

+ (CGSize)screenSizeFor40Inch {
    return CGSizeMake(320, 568);
}

+ (CGSize)screenSizeFor35Inch {
    return CGSizeMake(320, 480);
}


+ (NSString *)deviceModel {
    if ([self isSimulator]) {
        /// 模拟器不返回物理机器信息，但会通过环境变量的方式返回
        return [NSString stringWithFormat:@"%s", getenv("SIMULATOR_MODEL_IDENTIFIER")];
    }
    
    struct utsname systemInfo;

    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)deviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    NSDictionary *dict = @{
                           @"Watch1,1" : @"Apple Watch",
                           @"Watch1,2" : @"Apple Watch",
                           
                           @"iPod1,1" : @"iPod touch 1",
                           @"iPod2,1" : @"iPod touch 2",
                           @"iPod3,1" : @"iPod touch 3",
                           @"iPod4,1" : @"iPod touch 4",
                           @"iPod5,1" : @"iPod touch 5",
                           @"iPod7,1" : @"iPod touch 6",
                           
                           @"iPhone1,1" : @"iPhone 1G",
                           @"iPhone1,2" : @"iPhone 3G",
                           @"iPhone2,1" : @"iPhone 3GS",
                           @"iPhone3,1" : @"iPhone 4 (GSM)",
                           @"iPhone3,2" : @"iPhone 4",
                           @"iPhone3,3" : @"iPhone 4 (CDMA)",
                           @"iPhone4,1" : @"iPhone 4S",
                           @"iPhone5,1" : @"iPhone 5",
                           @"iPhone5,2" : @"iPhone 5",
                           @"iPhone5,3" : @"iPhone 5c",
                           @"iPhone5,4" : @"iPhone 5c",
                           @"iPhone6,1" : @"iPhone 5s",
                           @"iPhone6,2" : @"iPhone 5s",
                           @"iPhone7,1" : @"iPhone 6 Plus",
                           @"iPhone7,2" : @"iPhone 6",
                           @"iPhone8,1" : @"iPhone 6s",
                           @"iPhone8,2" : @"iPhone 6s Plus",
                           @"iPhone8,4" : @"iPhone SE",
                           @"iPhone9,1" : @"iPhone 7",
                           @"iPhone9,2" : @"iPhone 7 Plus",
                           @"iPhone10,1" : @"iPhone 8",
                           @"iPhone10,4" : @"iPhone 8",
                           @"iPhone10,2" : @"iPhone 8 Plus",
                           @"iPhone10,5" : @"iPhone 8 Plus",
                           @"iPhone10,3" : @"iPhone X",
                           @"iPhone10,6" : @"iPhone X",
                           
                           @"iPhone11,8" : @"iPhone XR",
                           @"iPhone11,2" : @"iPhone XS",
                           @"iPhone11,6" : @"iPhone XS Max",
                           @"iPhone12,1" : @"iPhone 11",
                           @"iPhone12,3" : @"iPhone 11 Pro",
                           @"iPhone12,5" : @"iPhone 11 Pro Max",
                           @"iPhone12,8" : @"iPhone SE",
                           @"iPhone13,1" : @"iPhone 12 mini",
                           @"iPhone13,2" : @"iPhone 12",
                           @"iPhone13,3" : @"iPhone 12 Pro",
                           @"iPhone13,4" : @"iPhone 12 Pro Max",

                           
                           @"iPad1,1" : @"iPad 1",
                           @"iPad2,1" : @"iPad 2 (WiFi)",
                           @"iPad2,2" : @"iPad 2 (GSM)",
                           @"iPad2,3" : @"iPad 2 (CDMA)",
                           @"iPad2,4" : @"iPad 2",
                           @"iPad2,5" : @"iPad mini 1",
                           @"iPad2,6" : @"iPad mini 1",
                           @"iPad2,7" : @"iPad mini 1",
                           @"iPad3,1" : @"iPad 3 (WiFi)",
                           @"iPad3,2" : @"iPad 3 (4G)",
                           @"iPad3,3" : @"iPad 3 (4G)",
                           @"iPad3,4" : @"iPad 4",
                           @"iPad3,5" : @"iPad 4",
                           @"iPad3,6" : @"iPad 4",
                           @"iPad4,1" : @"iPad Air",
                           @"iPad4,2" : @"iPad Air",
                           @"iPad4,3" : @"iPad Air",
                           @"iPad4,4" : @"iPad mini 2",
                           @"iPad4,5" : @"iPad mini 2",
                           @"iPad4,6" : @"iPad mini 2",
                           @"iPad4,7" : @"iPad mini 3",
                           @"iPad4,8" : @"iPad mini 3",
                           @"iPad4,9" : @"iPad mini 3",
                           @"iPad5,1" : @"iPad mini 4",
                           @"iPad5,2" : @"iPad mini 4",
                           @"iPad5,3" : @"iPad Air 2",
                           @"iPad5,4" : @"iPad Air 2",
                           @"iPad6,3" : @"iPad Pro (9.7 inch)",
                           @"iPad6,4" : @"iPad Pro (9.7 inch)",
                           @"iPad6,7" : @"iPad Pro (12.9 inch)",
                           @"iPad6,8" : @"iPad Pro (12.9 inch)",
                           
                           @"i386" : @"Simulator x86",
                           @"x86_64" : @"Simulator x64",
                           };
    
    NSString *deviceType = dict[platform];
    if (!deviceType) {
        deviceType = platform;
    }
    
    return deviceType;
}

//判断是否有汉字
+ (BOOL)hasChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}


@end



@implementation YFHelper (Tool)
/// 拨打电话
+ (void)callWithNumber:(NSString *)phoneNumber {
    
    /// 18.8.22 去除字符串中的空格
    /// 1, 去除首尾空格
    phoneNumber =  [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    /// 2, 去除字符串中的空格
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (!phoneNumber.length) return;
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNumber];
    /// 解决iOS10及其以上系统弹出拨号框延迟的问题
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        /// 10及其以上系统
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        /// 10以下系统
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

+ (UIViewController *)currentViewController {
    return [[self new] topViewController];
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}




#pragma mark -  /*************** 三小时到达的配图 ***************/ 类方法 方便其他控制器调取  废弃
+(void)getCityArrivedImage{
    NSFileManager *userManager = [NSFileManager defaultManager];//每次切换的时候讲图片移除掉 重新添加
    NSError *error;
    if ([userManager fileExistsAtPath:CITY_ARRIVED_PICTURE]) {
        [userManager removeItemAtPath:CITY_ARRIVED_PICTURE error:&error];
    }

    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL  URLWithString:[CacheHelper PreDeliveryImageUrl]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if(finished && image){
            NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
            [imgData writeToFile:CITY_ARRIVED_PICTURE atomically:YES];
        }
    }];
}
#pragma mark - 获取折扣率的值
+(CGFloat)getDiscountRate{
    //折扣率   [CacheHelper discountRate]
    CGFloat discountRate = [CacheHelper isLogin]?[[YFUserDefaults objectForKey:@"DiscountRate"] floatValue]:1.f;
    
    if (discountRate <= 0) {
        discountRate = 1;
    }
    
    return discountRate;
}

+(void)setIsBackFromDetailPage:(BOOL)value{
    isBackFromDetailPage = value;
}
+(BOOL)getIsBackFromDetailPage;{
    return isBackFromDetailPage;
}


+(void)setIsLoadingNetWoring:(BOOL)value{
    isLoadingNetWorking = value;
}
+(BOOL)getIsLoadingNetWoring;{
    return isLoadingNetWorking;
}
+(void)setWelFareImages:(NSArray *)arr{
    welfareImages = arr;
}
+(NSArray *)getWelfareImages{
    if (welfareImages==nil) {
        return [NSArray new];
    }
    return welfareImages;
}


//俱乐部 的高度 四大模块的高度
+(CGFloat)getClubContentHeight{
    CGFloat nav = is58InchScreen?88:64;
    CGFloat bottomH = is58InchScreen?80:50;
    
    CGFloat h = SCREEN_HEIGHT-nav-90-50-bottomH;
    return h;
}
//处理这种sb时间结构 处理带T的
+(NSString *)getNewTimeStr:(NSString *)time {
    
    if ([time containsString:@"T"]) {
        NSArray *arr = [time componentsSeparatedByString:@"T"];
        NSString * ymd = @"";
        NSString * hms = @"";
        NSString * timestr = @"";

        if (arr.count>1) {
            ymd = arr.firstObject;
            hms = arr[1];
        }
        timestr = [NSString stringWithFormat:@"%@ %@",ymd,hms];
        return timestr;
    }
    return @"";
}
//时间转成时间戳
+(NSInteger)timeTotimeStr:(NSString *)formatTime andFormatter:(NSString *)format setcurry:(BOOL)isorno{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:format]; //(@"yyyy-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSInteger timeSp;
    if (isorno) {
        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        timeSp = (long)[datenow timeIntervalSince1970];
//        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    }else{
        NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
        timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    }
    //时间转时间戳的方法:
    return timeSp;
}

//时间戳 --- 转时间

+(NSString *)timeStrToTime:(NSInteger)timeStr setFormat:(NSString *)format{
    NSTimeInterval interval    = timeStr;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];//yyyy-MM-dd HH:mm:ss
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
    
}


+ (NSString *)getJBLTimeYMD:(NSString *)dateStr {
    if ([dateStr containsString:@"T"]) {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        NSString * ymd = @"";
        NSString * timestr = @"";
        
        if (arr.count>1) {
            ymd = arr.firstObject;
            ymd = [ymd stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        }
        timestr = [NSString stringWithFormat:@"%@",ymd];
        return timestr;
    }
    return @"";
}
/// 2018-08-12T17:24:12.273   "2019-04-19T14:30:00.6128515+08:00";
+ (NSString *)getJBLTimeYMD_HM:(NSString *)dateStr {
    if ([dateStr containsString:@"T"]) {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        NSString * ymd = @"";
        NSString * hm = @"";
        NSString * timestr = @"";
        
        if (arr.count>1) {
            ymd = arr.firstObject;
            ymd = [ymd stringByReplacingOccurrencesOfString:@"-" withString:@"."];
            hm = arr[1];
            NSArray *humArray = [hm componentsSeparatedByString:@":"];
            if (humArray.count>1) {
                hm = [NSString stringWithFormat:@"%@:%@",humArray[0],humArray[1]];
            }
        }
        timestr = [NSString stringWithFormat:@"%@ %@",ymd,hm];
        return timestr;
    }
    return @"";
}

//判断是否在时间段
+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startTime withExpireTime:(NSString *)expireTime {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"HH:mm:ss"];
    NSString * todayStr=[dateFormat stringFromDate:today];//将日期转换成字符串
    today=[ dateFormat dateFromString:todayStr];//转换成NSDate类型。日期置为方法默认日期
    //startTime格式为 02:22   expireTime格式为 12:44
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

//中文表示方法  几年几月几日
+ (NSString *)getJBLTimeYMDChinaYMD:(NSString *)dateStr {
    if ([dateStr containsString:@"T"]) {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        NSString * ymd = @"";
        NSString * timestr = @"";
        
        if (arr.count>1) {
            ymd = arr.firstObject;
            
           NSArray *ymdArr = [ymd componentsSeparatedByString:@"-"];
            if (ymdArr.count==3) {
                ymd = [NSString stringWithFormat:@"%@年%@月%@日",ymdArr[0],ymdArr[1],ymdArr[2]];
            }
        }
        timestr = [NSString stringWithFormat:@"%@",ymd];
        return timestr;
    }
    return @"";
}

//中文表示方法  几月几日
+ (NSString *)getJBLTimeYMDChinaMD:(NSString *)dateStr {
    if ([dateStr containsString:@"T"]) {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        NSString * ymd = @"";
        NSString * timestr = @"";
        
        if (arr.count>1) {
            ymd = arr.firstObject;
            
            NSArray *ymdArr = [ymd componentsSeparatedByString:@"-"];
            if (ymdArr.count==3) {
                ymd = [NSString stringWithFormat:@"%@月%@日",ymdArr[1],ymdArr[2]];
            }
        }
        timestr = [NSString stringWithFormat:@"%@",ymd];
        return timestr;
    }
    return @"";
}

//中文表示方法  几年几月几日  几时几分
+ (NSString *)getJBLTimeYMDChinaYMDHM:(NSString *)dateStr {
    if ([dateStr containsString:@"T"]) {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        NSString * ymd = @"";
        NSString * timestr = @"";
        NSString * hm = @"";

        if (arr.count>1) {
            ymd = arr.firstObject;
            
            NSArray *ymdArr = [ymd componentsSeparatedByString:@"-"];
            if (ymdArr.count==3) {
                ymd = [NSString stringWithFormat:@"%@年%@月%@日",ymdArr[0],ymdArr[1],ymdArr[2]];
            }
            
            hm = [arr[1] substringToIndex:5];
            
        }
        
        
        timestr = [NSString stringWithFormat:@"%@ %@",ymd,hm];
        return timestr;
    }
    return @"";
}



//中文表示方法  .年.月.日
+ (NSString *)getJBLTimeYMDChinaDianYMD:(NSString *)dateStr {
    if ([dateStr containsString:@"T"]) {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        NSString * ymd = @"";
        NSString * timestr = @"";
        
        if (arr.count>1) {
            ymd = arr.firstObject;
            
            NSArray *ymdArr = [ymd componentsSeparatedByString:@"-"];
            if (ymdArr.count==3) {
                ymd = [NSString stringWithFormat:@"%@.%@.%@",ymdArr[0],ymdArr[1],ymdArr[2]];
            }
        }
        timestr = [NSString stringWithFormat:@"%@",ymd];
        return timestr;
    }
    return @"";
}
//中文表示方法  。年。月，日  。时。分
+ (NSString *)getJBLTimeYMDChinaDianMinuteYMDHM:(NSString *)dateStr {
    if ([dateStr containsString:@"T"]) {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        NSString * ymd = @"";
        NSString * timestr = @"";
        NSString * hm = @"";
        
        if (arr.count>1) {
            ymd = arr.firstObject;
            
            NSArray *ymdArr = [ymd componentsSeparatedByString:@"-"];
            if (ymdArr.count==3) {
                ymd = [NSString stringWithFormat:@"%@.%@.%@",ymdArr[0],ymdArr[1],ymdArr[2]];
            }
            
            hm = [arr[1] substringToIndex:5];
            
        }
        
        
        timestr = [NSString stringWithFormat:@"%@ %@",ymd,hm];
        return timestr;
    }
    return @"";
}

// 2019.7.19 19:20:22
+ (NSString *)getJBLTimeYMDChinaDianMinuteYMDHMS:(NSString *)dateStr {
    if ([dateStr containsString:@"T"]) {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        NSString * ymd = @"";
        NSString * timestr = @"";
        NSString * hm = @"";
        
        if (arr.count>1) {
            ymd = arr.firstObject;
            
            NSArray *ymdArr = [ymd componentsSeparatedByString:@"-"];
            if (ymdArr.count==3) {
                ymd = [NSString stringWithFormat:@"%@.%@.%@",ymdArr[0],ymdArr[1],ymdArr[2]];
            }
            
            hm = [arr[1] substringToIndex:8];
            
        }
        
        
        timestr = [NSString stringWithFormat:@"%@ %@",ymd,hm];
        return timestr;
    }
    return @"";
}

+ (NSInteger)getTotalTimeForSeconds:(NSString *)startTime endTime:(NSString *)endTime {
    
    /// CurrentTime  2018-08-14T13:45:42.01
    NSArray *array1 = [startTime componentsSeparatedByString:@"."];
    if (array1.count) {
        startTime = array1[0];
        NSArray *array2 = [startTime componentsSeparatedByString:@"T"];
        if (array2.count>1) {
            startTime = [NSString stringWithFormat:@"%@ %@",array2[0], array2[1]];
        }
    }
    
    NSArray *array3 = [endTime componentsSeparatedByString:@"."];
    if (array1.count) {
        endTime = array3[0];
        NSArray *array4 = [endTime componentsSeparatedByString:@"T"];
        if (array4.count>1) {
            endTime = [NSString stringWithFormat:@"%@ %@",array4[0], array4[1]];
        }
    }
    
    //按照日期格式创建日期格式句柄
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    //将日期字符串转换成Date类型
    NSDate *startDate = [dateFormatter dateFromString:startTime];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    //将日期转换成时间戳
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [endDate timeIntervalSince1970]*1;
    NSTimeInterval seconds = end - start;
    return seconds;
}

/// 2019-07-29T21:27:56 转换成 NSDate
+ (NSDate *)JBL_T_TimeToFullDate:(NSString *)datetime {
    NSArray *arr = [datetime componentsSeparatedByString:@"T"];
    if (arr.count != 2) return nil;
    
    NSString *dateTime = [NSString stringWithFormat:@"%@ %@",arr.firstObject, arr.lastObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:dateTime];
    return date;
}



//z转中文
+(NSString *)changeChineseToEnglish:(NSString *)ursStr{
    
    NSString *url ;
    if ([YFHelper hasChinese:ursStr]) {
        
        url = [ursStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        url = ursStr;
    }
    
    return url;
}


/*uiview界面内的下拉刷新 状态栏*/
+(MJRefreshGifHeader *)setMjHeaderGift:(id)value setMotherGategro:(id)value1{
    NSString *sel = @"";
    sel = [value isEqualToString:@""]?@"loadNewData":value;
    SEL selector = NSSelectorFromString(sel);
    NSMutableArray *images = [NSMutableArray new];
    for (int i = 0; i <= 23; ++i) {
        NSString *imageName = [NSString stringWithFormat:@"pull_down__000%.2d.png",i];
        [images addObject:UIImageWithName(imageName)];
    }
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:value1 refreshingAction:selector];
    [header setImages:images forState:MJRefreshStateIdle];
    [header setImages:images forState:MJRefreshStatePulling];
    [header setImages:images forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.numberOfLines = 0;
    header.stateLabel.textColor = UIColorMake(203, 203, 203);
    //    header.stateLabel.textAlignment = NSTextAlignmentLeft;
    [header setTitle:@"20分钟喝上放心酒\n下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"20分钟喝上放心酒\n刷新中..." forState:MJRefreshStatePulling];
    [header setTitle:@"20分钟喝上放心酒\n刷新结束" forState:MJRefreshStateRefreshing];
    
    return header;
}

+(BOOL)isUrl:(NSString *)url1 {//判断是否为url
    
    if(url1 == nil) {
        return NO;
    }
    
    NSString *url;
    if (url1.length>4 && [[url1 substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    }else{
        url = url1;
    }
    NSString *urlRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}

/*
 *完善储存的不足
 */

//保存城市名字
+(void)saveCityName:(NSString *)value{
    [YFUserDefaults setObject:value forKey:@"CITY_KEY"];
}

+(NSString *)getCityName{
    id data = [YFUserDefaults objectForKey:@"CITY_KEY"];
    if (data==nil) {
        return @"";
    }
    return (NSString *)data;
}

+ (void)setIsOpenBrandClub:(BOOL)value {
    [YFUserDefaults setBool:value forKey:@"IsOpenBrandClub_Key"];
}

+ (BOOL)IsOpenBrandClub {
    BOOL data = [YFUserDefaults boolForKey:@"IsOpenBrandClub_Key"];
    return data;
}

+ (void)setBrandClubImageUrl:(NSString *)imageUrl {
    [YFUserDefaults setObject:imageUrl forKey:@"BrandClubImageUrl_Key"];
}

+ (NSString *)brandClubImageUrl {
    return [YFUserDefaults objectForKey:@"BrandClubImageUrl_Key"];
}

+ (void)setClubJumpNavigationUrl:(NSString *)navigationUrl {
    [YFUserDefaults setObject:navigationUrl forKey:@"ClbuJumpNavigationUrl_Key"];
}

+ (NSString *)clubJumpNavigationUrl {
    return [YFUserDefaults objectForKey:@"ClbuJumpNavigationUrl_Key"];
}

//+(void)setMallidjungelShowOrHide{
//    NSString *str = [YFUserDefaults objectForKey:@"haveWelfareView"];
//    NSString *nowStr = [NSString stringWithFormat:@"%@%@",str,GlobalData.mallIDStr];
//}
//
//+(NSString *)jungelShowOrHide{
//    NSString *str = [YFUserDefaults objectForKey:@"haveWelfareView"];
//    return str;
//
//}

+ (void)configureLabel:(UILabel *)priceLabel
                 price:(NSString *)price
              leftSize:(int)leftSize
               midSize:(int)middleSize
             rightSize:(int)rightSize {
    
    NSString *showPrice = price;
    NSString *floStr;
    NSRange range = [showPrice rangeOfString:@"."];
    floStr = [showPrice substringFromIndex:range.location];
    NSRange floRange = [showPrice rangeOfString:floStr];
    
    priceLabel.font = UIBoldFontMake(middleSize);
    
    NSMutableAttributedString *showPriceAttString = [[NSMutableAttributedString alloc] initWithString:showPrice];
    [showPriceAttString addAttributes:@{NSFontAttributeName:UIBoldFontMake(rightSize)} range:floRange];
    
    NSRange leftRange = [showPrice rangeOfString:@"￥"];
    [showPriceAttString addAttributes:@{NSFontAttributeName:UIBoldFontMake(leftSize)} range:leftRange];
    
    priceLabel.attributedText = showPriceAttString;
    
}

+(NSString *)fourGoFiveReceive:(NSString *)value{
    
    NSString *countStr = value;
    
    if (value.length>=5) {
        NSString *numberStr = [NSString stringWithFormat:@"%@.%@",[countStr substringToIndex:1],[countStr substringFromIndex:1]];
        countStr = [NSString stringWithFormat:@"%.1f万",numberStr.floatValue];
        return countStr;
    }
    
    return countStr;
}


BOOL IsBlankString(NSString *checkedString) {
    return !checkedString || [checkedString yf_isBlank];
}



+ (UIImage *)userIcon {
    /// 刷新顶部navigationBar
    NSString *header = [CacheHelper getHeadPic];
    if(header && ![header isEqualToString:@""]){
        NSData *data = [Utils base64DataFromString:header];
        UIImage *image = [UIImage imageWithData:data];
        return image;
    } else {
        return UIImageWithName(@"gcc_icon_jiubei.jpg");
    }
}


@end















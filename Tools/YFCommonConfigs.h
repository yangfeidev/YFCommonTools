//
//  YFCommonConfigs.h
//
//  Created by YangFei on 2017/1/20.
//  Copyright © 2017年 Social. All rights reserved.
//

#ifndef YFCommonConfigs_h
#define YFCommonConfigs_h

#import <sys/time.h>
#import <pthread.h>
#import <objc/runtime.h>


/// Category
#import "UIControl+YFAdd.h"
#import "NSString+YFAdd.h"
#import "UIView+YFAdd.h"
#import "NSDate+YFAdd.h"
#import "UIImage+YFAdd.h"
#import "UILabel+YFAdd.h"
#import "UIGestureRecognizer+YFAdd.h"
#import "UINavigationController+YFAdd.h"
#import "NSDictionary+YFAdd.h"
#import "UITabBar+YFAdd.h"
#import "UIColor+YFAdd.h"
#import "YYModel.h"
#import "UIView+Toast.h"
#import "UITableView+YFAdd.h"
#import "UITextField+YFAdd.h"
#import "NSMutableAttributedString+YFAdd.h"
#import "JPUSHService.h"
#import "MJRefresh.h"
#import "NSData+YFAdd.h"
#import "CALayer+YFAdd.h"
#import "NSObject+YFAdd.h"
#import "UICollectionView+YFAdd.h"


/// Tools
#import "YFAlertTool.h"
#import "YFHelper.h"
#import "MJAlertView.h"

#import "PopAlertView.h"
#import "YFPageControl.h"
#import "MallNoStockAlertView.h"
#import "CommonTipViewCell.h"


/// NotificationName Const
#import "YFConstant.h"


#pragma mark - /**************** UI ****************/

/** 字体*/
#define UIFontMake(size) [UIFont systemFontOfSize:size]
#define UIFontHetti_SCMake(size)  [UIFont fontWithName:@"Heiti SC" size:size]

#define UIBoldFontMake(size) [UIFont boldSystemFontOfSize:size]

/** 颜色*/
#define UIColorMake(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define UIRGBAColorMake(r,g,b,a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define UIRGB16ColorMake(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0    \
                                                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0       \
                                                     blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorClear                [UIColor clearColor]
#define UIColorWhite                [UIColor whiteColor]



#define UIColorBlack                [UIColor blackColor]
#define UIColorGray                 [UIColor grayColor]
#define UIColorRed                  [UIColor redColor]
#define UIColorGreen                [UIColor greenColor]
#define UIColorBlue                 [UIColor blueColor]
#define UIColorYellow               [UIColor yellowColor]
#define UIColorOrange               [UIColor orangeColor]
#define UIColorCyan                 [UIColor cyanColor]
#define UIColorLightGray            [UIColor lightGrayColor]
#define UIColorDarkGray             [UIColor darkGrayColor]

#pragma mark - /**************** 适配 ****************/

/** 获取硬件信息*/
//#define YFScreen_W   ([UIScreen mainScreen].bounds.size.width)
//#define YFScreen_H   ([UIScreen mainScreen].bounds.size.height)
//#define YFCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/** 适配*/
#ifndef YFSystemVersion
#define YFSystemVersion  ([UIDevice currentDevice].systemVersion.doubleValue)
#endif


/** 设备屏幕尺寸*/
#define IS_65INCH_SCREEN    [YFHelper is65InchScreen]
#define IS_61INCH_SCREEN    [YFHelper is61InchScreen]
#define IS_58INCH_SCREEN    [YFHelper is58InchScreen]
#define IS_55INCH_SCREEN    [YFHelper is55InchScreen]
#define IS_47INCH_SCREEN    [YFHelper is47InchScreen]
#define IS_40INCH_SCREEN    [YFHelper is40InchScreen]
#define IS_35INCH_SCREEN    [YFHelper is35InchScreen]
/// 是否是刘海屏
#define IS_NOTCHED_SCREEN   [YFHelper isNotchedScreen]

// 状态栏高度
#define STATUS_BAR_HEIGHT (IS_NOTCHED_SCREEN ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (IS_NOTCHED_SCREEN ? 88.f : 64.f)

/// 刘海平顶部间隔
#define NotchedTopMargin       (IS_NOTCHED_SCREEN ? 24 : 0)

#define NotchedBottomMargin    (IS_NOTCHED_SCREEN ? 34 : 0)


/// 控件高度
#define YFNavigationBarHeight  (IS_NOTCHED_SCREEN ? 88:64)
#define YFTabBarHeight         (IS_NOTCHED_SCREEN ? 83:49)
#define YFStatusBarHeight      (20)

#define ScreenScale ([[UIScreen mainScreen] scale])


/** YF */
#define YFiPhone4_OR_4s           (SCREEN_HEIGHT == 480)
#define YFiPhone5_OR_5c_OR_5s     (SCREEN_HEIGHT == 568)
#define YFiPhone6_OR_6s           (SCREEN_HEIGHT == 667)
#define YFiPhone6Plus_OR_6sPlus   (SCREEN_HEIGHT == 736)
#define YFiPhoneX                 (SCREEN_HEIGHT == 812)
#define YFiPad                    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - /**************** 常用代码 ****************/
/** 加载本地文件*/
#define YFLoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define YFLoadArray(file,type) [UIImage arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define YFLoadDict(file,type)  [UIImage dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]


/** 数据存储*/
#define YFUserDefaults         [NSUserDefaults standardUserDefaults]
#define YFCacheDir             [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define YFDocumentDir          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define YFTempDir              NSTemporaryDirectory()

#pragma mark - /**************** 单例 ****************/

#define   YFUserDefaults            [NSUserDefaults standardUserDefaults]
#define   YFNotificationDefault     [NSNotificationCenter defaultCenter]
/** 提示消息 */
#define   YFAlertMessage(msg)       [YFAlertTool alertMessage:msg];


#pragma mark - /*************** 各种图片 **************/
/// 默认图
#define MallDefaultPic  [UIImage imageNamed:@"DefaultPic"]
#define CITY_ARRIVED_PICTURE [NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),@"citypicture"]
#define MallCategoryDefaultPic  [UIImage imageNamed:@"gcc_icon_jiubei.jpg"]
#define NSURLWithString(urlString)  [NSURL URLWithString:urlString]

//通知
#define RELOAR_DISCOUNTRATE @"RELOAR_DISCOUNTRATE"

//刷新首页的通知
#define ReLoadTabBarDidClickNotification @"ReLoadTabBarDidClickNotification"

#define  YFScreen_Center    [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)]


#pragma mark - /********  闭包   ********/
typedef void (^FBlock)(CGFloat item);
typedef void (^DoubleParBlock)(int item1, id item2);
typedef void (^IBlock)(id item);
typedef void (^INTBlock)(NSInteger item);
typedef void(^BBlock)(BOOL item);
typedef void (^INTTWOBlock)(id item,id item1,id item2);
typedef void (^FNumberBlock)(CGFloat item,CGFloat item1,CGFloat item2,CGFloat item3,CGFloat item4);
typedef void (^INTFOURBlock)(id item,id item1,id item2,id item3);
typedef void (^VBlock)(void);


#pragma mark - /**************** Clang ****************/
#define ArgumentToString(macro) #macro
#define ClangWarningConcat(warning_name) ArgumentToString(clang diagnostic ignored warning_name)

// 参数可直接传入 clang 的 warning 名，warning 列表参考：http://fuckingclangwarnings.com/
#define BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(ClangWarningConcat(#warningName))
#define EndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define BeginIgnorePerformSelectorLeaksWarning BeginIgnoreClangWarning(-Warc-performSelector-leaks)
#define EndIgnorePerformSelectorLeaksWarning EndIgnoreClangWarning

#define BeginIgnoreAvailabilityWarning BeginIgnoreClangWarning(-Wpartial-availability)
#define EndIgnoreAvailabilityWarning EndIgnoreClangWarning

#define BeginIgnoreDeprecatedWarning BeginIgnoreClangWarning(-Wdeprecated-declarations)
#define EndIgnoreDeprecatedWarning EndIgnoreClangWarning


#pragma mark - /**************** 函数 ****************/
/** 主线程执行方法 */
CG_INLINE void
dispatch_async_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/** 延迟执行方法 */
CG_INLINE void
dispatch_after_time_on_main_queue(NSInteger second, void (^block)(void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

CG_INLINE void
dispatch_after_on_background_queue(NSInteger second, void (^block)(void)) {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
    dispatch_queue_t queue = dispatch_queue_create("com.jbl.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_after(time, queue, ^{
        block();
    });
}


#define YFGlobalQueue  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


/** 交换方法 */
CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}
/* 传入size，返回一个 (x,y) 为 (0,0) 的 CGRect */
CG_INLINE CGRect
CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}


/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}



#pragma mark - CGFloat

/**
 *  某些地方可能会将 CGFLOAT_MIN 作为一个数值参与计算（但其实 CGFLOAT_MIN 更应该被视为一个标志位而不是数值），可能导致一些精度问题，所以提供这个方法快速将 CGFLOAT_MIN 转换为 0
 *  issue: https://github.com/QMUI/QMUI_iOS/issues/203
 */
CG_INLINE CGFloat
removeFloatMin(CGFloat floatValue) {
    return floatValue == CGFLOAT_MIN ? 0 : floatValue;
}
/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE CGFloat
flatSpecificScale(CGFloat floatValue, CGFloat scale) {
    floatValue = removeFloatMin(floatValue);
    scale = scale == 0 ? ScreenScale : scale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}
/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CG_INLINE CGFloat
flat(CGFloat floatValue) {
    return flatSpecificScale(floatValue, 0);
}
/// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
CG_INLINE CGRect
CGRectFlatted(CGRect rect) {
    return CGRectMake(flat(rect.origin.x), flat(rect.origin.y), flat(rect.size.width), flat(rect.size.height));
}
/// 为一个CGRect叠加scale计算
CG_INLINE CGRect
CGRectApplyScale(CGRect rect, CGFloat scale) {
    return CGRectFlatted(CGRectMake(CGRectGetMinX(rect) * scale, CGRectGetMinY(rect) * scale, CGRectGetWidth(rect) * scale, CGRectGetHeight(rect) * scale));
}






//// ******************** 酒便利相关  *********************  ///

//支付相关
#define KONLINEPAY      true    // 在线支付开关       ////   默认不用改
#define KALIPAY         true    // 支付宝开关         ////   默认不用改
#define KUNPAY          false   // 银联支付开关       ////   默认不用改


#define KPOSTCLIENTPLAT     @"IOS"
#define KAPPDOWNURL         @"https://itunes.apple.com/us/app/jiu-bian-li/id741897886?mt=8"
#define KVCODETIME          60
#define KAPPSHAREURL        [MicroMall_BaseUrl stringByAppendingString:@"Client_download.aspx?id=139"]


#define MallMainStroyboard                           [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil]

#define MallInstantiateViewControllerWithIdentifier(identifier)  \
[MallMainStroyboard instantiateViewControllerWithIdentifier:identifier]

#define MallNavigationController                     (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController
#define YFPushViewControllerWithAnimation(__vc__)    [self.navigationController pushViewController:__vc__ animated:YES]


#define YFStringIsEquals(string, anotherString)       [string isEqualToString:anotherString]

#define UIImageWithName(imageName)  [UIImage imageNamed:imageName]


#define UIButtonNormalBackgroundImage(btn, imageName) \
[btn setBackgroundImage:UIImageWithName(imageName) forState:UIControlStateNormal]

#define UIButtonNormalTitleColor(btn, color) \
[btn setTitleColor:color forState:UIControlStateNormal];

#define UIButtonNormalImage(btn, imageName) \
[btn setImage:UIImageWithName(imageName) forState:(UIControlStateNormal)]

#define UIButtonNormalTitle(btn, title) \
[btn setTitle:title forState:UIControlStateNormal]

#define IsAllowNoStockBuy   [CacheHelper isAllowNoStockBuy]

#define GlobalData   [CacheHelper sharedHelper]

/// 当前 选择 的是全国购还是闪电送
#define kCurrentIsNationalSale    (GlobalData.currentIsNationalSale)
/// 当前城市是否 支持 全国购
#define kIsNationalSales          (GlobalData.NationalSales)
/// 当前城市是否 显示 全国购
#define kIsShowNationalSales      (GlobalData.IsShowNationalSales)

#define  WXPaymentMethod       @"WXPaymentMethod"
#define  ALiPaymentMethod      @"ALiPaymentMethod"

#endif /* YFCommonConfigs_h */


#define kDefaultAppKey @"1477170912061278#kefuchannelapp34641"
#define kDefaultCustomerName @"kefuchannelimid_785547"
#define kDefaultCustomerNickname @"访客昵称"
#define kDefaultTenantId @"34641"
#define kDefaultProjectId @"88996"

#define kAppKey @"KF_appkey"
#define kCustomerName @"KF_name"
#define kCustomerNickname @"KF_nickname"
#define kCustomerTenantId @"KF_tenantId"
#define kCustomerProjectId @"KF_projectId"
#define hxPassWord @"123456"



#define KCODECHANGECITY      UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您当前所选城市与首页所选城市不同" delegate:self cancelButtonTitle:nil otherButtonTitles:@"更换地址",@"切换城市",nil]; [alertView show];

#define KCODECACHEMODEALERT(suretitle,cancletitle,msg)  UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:suretitle,cancletitle,nil];alertView.tag=10; [alertView show];


#define KCODEALERTSHOW(msg)      [[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
#define KCODE_ALERT_MSG(msg) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:(msg) delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];alertView.tag=16161616;[alertView show];
#define KCODEADDSHOPINGCART      UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"商品已成功加入购物车" delegate:self cancelButtonTitle:nil otherButtonTitles:@"去购物车",@"继续购物",nil]; [alertView show];

#define KCODEADDSHOPINGPROMOTIONCART    UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"本商品已参加促销优惠活动，是否查看？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"查看促销",@"加入购物车",nil]; [alertView show];

#define KADDTOMYCOLLECTION     UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录后才能使用收藏和分享" delegate:self cancelButtonTitle:nil otherButtonTitles:@"现在登录",@"取消",nil]; [alertView show];

#define KCODEVESIONMESSAGE(msg) UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"软件更新" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即去更新",nil];alertView.tag=1000; [alertView show];

#define KCODEADDSHOPINGPROMOTIONCARTBUYNOW  UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"本商品已参加促销优惠活动，是否查看？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"加入购物车",@"查看促销",nil]; [alertView show];

#define KCODEGOTOSHOPPINGCART   UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录后才能查看购物车！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];alertView.tag=111222;[alertView show];
// 库存不足提示信息
#define KCODE_SHOW_UNDERSTOCK   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"库存不足, 无法添加!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];[alertView show];dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[alertView dismissWithClickedButtonIndex:0 animated:YES];});return;
// 提示信息自动消失
#define KCODE_AUTOMATIC_DISAPPEAR(msg)   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];[alertView show];dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[alertView dismissWithClickedButtonIndex:0 animated:YES];});return;
// 提示信息 消失
#define KCODE_DISAPPEAR(msg)   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];[alertView show];dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[alertView dismissWithClickedButtonIndex:0 animated:YES];});
//
#define KCODE_ALERT_MSG_TITLE(title,msg) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:(title) message:(msg) delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];alertView.tag=16161617;[alertView show];

#define KCODE_ALERT_MSG_TITLE_IKNOW(title,msg) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:(title) message:(msg) delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];alertView.tag=16161618;[alertView show];

#define LianBianGap 24


#define LOGIN_VC_NAME  (@"MallLoginViewController")
#define LOGIN_TAG  111222

#define KCODECELLUNSELECT         [[tableView cellForRowAtIndexPath:indexPath]setSelected:NO];

#define KCODESHOWCODEMSG        [MallBaseModel showMsg:code];

#define CODERGBCOLOR(R,G,B)         [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define CODERGBACOLOR(R,G,B,A)      [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define CODEINIT(class)             [[class alloc]init]
#define CODELOADXIB(xib)            [[[NSBundle mainBundle]loadNibNamed:xib owner:self options:nil]lastObject]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NavigationBar_HEIGHT 44
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/// 9.2号
#define  BLACKBLUE  UIColorFromRGB(0xf0302f)

#define MallGlobalColor     UIColorFromRGB(0xf0302f)

// 搜索框边框颜色
#define SEARCHBORDERCOLOR [UIColor grayColor]

#define kBundleID   NSBundle.mainBundle.bundleIdentifier





#ifdef JBL_Target
    #define KCORPORATIONID      @"1"
    // 高德地图key
    #define Amap_ApiKey @"536ae5c03ea684dd7983632be8d571cb"

    /// 微信小程序 原始id
    #define wxMiniObgect_UserName  @"gh_ae534c6490e5";

    // 微信的APPID
    #define WX_AppID     @"wxa3906a51c1bb3a91"
    #define WX_AppSecret @"95d6ae3a96a034e85668124c0a88298a"

    /// universalLink
    #define UniversalLink  @"https://app.9bianli.com/.well-known/"

    /// 酒便利升级攻略
    #define ShengJiGongLue  [MicroMall_BaseUrl stringByAppendingString:@"html/upgradeStrategy/Index.html"]

    /// 客服云 appkey
    #define KF_Appkey    @"1445190828061782#kefuchannelapp74008"
    #define KF_tenantId  @"74008"
    
    /// 推送相关
    #define JPushKey      @"cb2215306aae11e6d8f80728"
    #define JPushChannel  @"Publish channel"

    /// 酒便利隐私权政策index
    #define  PrivacyPolicyViewIndex     0
    /// app名称
    #define kAppname      @"酒便利"
    #define kShareInfo    @"我正在使用酒便利App客户端呢,20分钟就能喝上放心酒，你也来下载吧!"
    #define kShareTitle   @"20分钟喝上放心酒!"
    #define kPrefixHeader @"jblmall://"
    #define kAppScheme    @"jblmall"
    #define UMENG_APPKEY  @"572868f2e0f55adcef0003e5"

    #define KF_Hidden     (CacheHelper.MallServiceGroupName.length<=0 && CacheHelper.ClubServiceGroupName.length<=0)

/// 酒直达
#elif JZD_Target
    #define KCORPORATIONID      @"100"
    // 高德地图key
    #define Amap_ApiKey @"4980584aa2aadf9414deefe79a0ac892"
//    #define Amap_ApiKey @"536ae5c03ea684dd7983632be8d571cb"
    /// 微信小程序 原始id
    #define wxMiniObgect_UserName  @"gh_3f09bbabcd86";

    // 微信的APPID
    #define WX_AppID     @"wx21290cb664738ee6"
    #define WX_AppSecret @"d78b5a3d95f624c1b90f3be95fab7abd"

    /// universalLink
    #define UniversalLink  @"https://api.9zhida.com/.well-known/"

    /// 酒便利升级攻略
    #define ShengJiGongLue  [MicroMall_BaseUrl stringByAppendingString:@"html/upgradeStrategy/Index.html"]

    /// 客服云 appkey
    #define KF_Appkey    @""
    #define KF_tenantId  @""

    /// 推送相关
    #define JPushKey      @""
    #define JPushChannel  @"Publish channel"

    /// 酒便利隐私权政策index
    #define  PrivacyPolicyViewIndex     0
    /// app名称
    #define kAppname      @"酒直达"
    #define kShareInfo    @"我正在使用酒直达App客户端呢,20分钟就能喝上放心酒，你也来下载吧!"
    #define kShareTitle   @"20分钟喝上放心酒!"
    #define kPrefixHeader @"jzdmall://"
    #define kAppScheme    @"JiuZhiDa"
    #define UMENG_APPKEY  @""

/// 也买网 文件配置
#else

    #define KCORPORATIONID      @"100"
    // 高德地图key
    #define Amap_ApiKey @"84659e2124f46579cea37e02c51da87f"

    /// 微信小程序 原始id
    #define wxMiniObgect_UserName  @"gh_8da254f74078";

    /// 微信的APPID
    #define WX_AppID     @"wxc12db7c2ed8e34d1"
    #define WX_AppSecret @"8138b3d3d8197a93eb42c28867b76fd1"

    /// universalLink
    #define UniversalLink  @"https://app.yesmywine.com/.well-known/"


    /// 也买网升级攻略
    #define ShengJiGongLue  [MicroMall_BaseUrl stringByAppendingString:@"html/upgradeStrategy/Index.html"]

    /// 客服云 appkey
    #define KF_Appkey    @""
    #define KF_tenantId  @""

    /// 推送相关
    #define JPushKey      @""
    #define JPushChannel  @""

    /// 也买酒隐私权政策index
    #define  PrivacyPolicyViewIndex     1

    /// app名称
    #define kAppname      @"也买酒"
    #define kShareInfo    @"我正在使用也买酒App客户端呢, 你也来下载吧!"
    #define kShareTitle   @""
    #define kPrefixHeader @"ymwmall://"
    #define kAppScheme    @"YesMyWine"
    #define UMENG_APPKEY  @"572868f2e0f55adcef0003e5"
#endif

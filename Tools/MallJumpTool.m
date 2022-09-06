//
//  MallJumpTool.m
//  MobileMall
//
//  Created by YangFei on 2018/8/3.
//  Copyright © 2018年 SoftBest1. All rights reserved.
//

#import "MallJumpTool.h"
#import <UIKit/UIKit.h>

#import "YFSectionItemModel.h"
#import "MallSearchViewController.h"
#import "WelfareMallViewController.h"
#import "YFClubViewController.h"
#import "StoreMapListVC.h"
#import "MallPromotionActivityViewController.h"

/// copy
#import "MallwalletViewController.h"
#import "MallAdverProductListViewController.h"
#import "WebViewPage.h"
#import "MallLoginViewController.h"
#import "MallSearchResultViewController.h"
#import "MallRegisterViewController.h"

/// 极光推送
#import "JPUSHService.h"


#import "YFSectionModel.h"
#import "YFSectionItemModel.h"


/// 定位
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


#import <ShareSDK/ShareSDK.h>

//新版界面详情
#import "WineIsConvenDetailPage.h"
#import "WinewareDetailModel.h"

#import "YFSelectAddressNewVC.h"

#import "WXApiRequestHandler.h"

#import "NewOrderListPage.h"

/// 新版俱乐部相关
#import "YFCommonWebViewController.h"
#import "MineClubActivityPage.h"
#import "PrizeRecordViewController.h"
#import "MineCouponViewController.h"

#import "ShareCustom.h"
#import "MallSearchByCouponCodeVC.h"
#import "ClubArticleDetailPageV2.h"

/// 新版俱乐部V2

#import "MineClubDetailPageV2.h"
#import "MineClubMainPageV2.h"

#import "MallCommonAddressesViewController.h"
#import "MallMyCollectionsViewController.h"
#import "MallSendSuggestionViewController.h"
/// 礼包详情
#import "GiftBagViewController.h"
/// Plus会员
#import "PlusMemberController.h"

///  茅台开瓶兑换
#import "TraceabilityCodeListController.h"
#import "FlashBuyWinesPage.h"

#import "FlashBuyWinesabPage.h"

#import "SpecialAreaViewController.h"

#import "IntegralCenterViewController.h"


#import "MyRaffleViewController.h"
#import "ClubMyCapsPageV2.h"
#import "ClubWefareListPage.h"

#import "SingleClubWelfareMainPageV2.h"


/// 追溯码验证
#ifdef JBL_Target
#import "酒便利-Swift.h"
#elif JZD_Target
#import "JiuZhiDa-Swift.h"
#else
#import "YesMyWine-Swift.h"
#endif
@interface MallJumpTool() <MallClickedAddToShoppingCartDelegate>

/// 跳转用的控制器
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UITabBarController *tabBarController;


@property (nonatomic, strong) NSArray *itemCodes;


@end

@implementation MallJumpTool {
    /// 分享相关
    NSString *shareGiftInfo;
    NSString *shareGiftTitle;
    NSString *shareGiftImage;
    NSString *shareGiftUrl;
}

+ (instancetype)sharedTool {
    static MallJumpTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[MallJumpTool alloc] init];
    });
    
    return tool;
}

BeginIgnoreDeprecatedWarning

+ (void)jumpWithNavigationController:(UINavigationController *)nav
                    tabBarController:(UITabBarController *)tabBarController
                   itemNavigationUrl:(NSString *)itemNavigationUrl {
    YFSectionItemModel *itemModel = YFSectionItemModel.new;
    
    itemModel.ItemNavigationUrl = itemNavigationUrl;
    
    [[MallJumpTool sharedTool] initWithNav:nav
                                       TVC:tabBarController
                                 itemModel:itemModel
                                 isWebload:false];
}

+ (void)jumpWithNavigationController:(UINavigationController *)nav
                    tabBarController:(UITabBarController *)tabBarController
                           itemModel:(YFSectionItemModel *)itemModel
                         isWebJSload:(BOOL)isWebJSload {
    [[MallJumpTool sharedTool] initWithNav:nav
                                       TVC:tabBarController
                                 itemModel:itemModel
                                 isWebload:isWebJSload];
}



- (void)initWithNav:(UINavigationController *)navigationController
                TVC:(UITabBarController *)tabBarController
          itemModel:(YFSectionItemModel *)itemModel
          isWebload:(BOOL)isWebJSload {
    self.navigationController = navigationController;
    self.tabBarController = tabBarController;
    
    
    
    //LQ
    [self recordClickHistory:itemModel];
    
    
    
    if (itemModel.ProductVariantID&&itemModel) {
        WineIsConvenDetailPage *detailPage = [WineIsConvenDetailPage new];
        detailPage.productVarientID = itemModel.ProductVariantID;
        detailPage.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailPage animated:YES];
        return;
    }
    NSString *ItemNavigationUrl = itemModel.ItemNavigationUrl;
    
    if (!isWebJSload) {
        if ([ItemNavigationUrl hasPrefix:@"http"]) {
            ItemNavigationUrl = [ItemNavigationUrl yf_decodeURLString];
            if ([self isNeedLogin:ItemNavigationUrl]) {
                MallLoginViewController *vc = MallInstantiateViewControllerWithIdentifier(LOGIN_VC_NAME);
                vc.isAutoBack = YES;
                vc.pushBlock = ^{
                    [self pushToWebWithUrl:ItemNavigationUrl];
                };
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [self pushToWebWithUrl:ItemNavigationUrl];
            }
            return;
        }
    }
    
    
    ItemNavigationUrl = [ItemNavigationUrl stringByReplacingOccurrencesOfString:kPrefixHeader withString:@""];
    
    
    if ([ItemNavigationUrl hasPrefix:@"ProductSearch/"]) {
        NSString *searchKey = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"ProductSearch/" withString:@""];
        searchKey = [searchKey yf_decodeURLString];
        
        SpecialAreaViewController *page = [SpecialAreaViewController new];
        page.hidesBottomBarWhenPushed = true;
        
        /// 买赠, 特价, 整箱 跳转原生页面
        if ([searchKey isEqualToString:@"买赠"]) {
            searchKey = @"mz";
            page.keyword = searchKey;
            [self.navigationController pushViewController:page animated:true];
        } else if ([searchKey isEqualToString:@"特价"]) {
            searchKey = @"tj";
            page.keyword = searchKey;
            [self.navigationController pushViewController:page animated:true];
        } else if ([searchKey isEqualToString:@"整箱"]) {
            searchKey = @"zxg";
            page.keyword = searchKey;
            [self.navigationController pushViewController:page animated:true];
        } else if ([searchKey isEqualToString:@"潮品"]) {
            searchKey = @"cp";
            page.keyword = searchKey;
            [self.navigationController pushViewController:page animated:true];
        } else {
            
            MallSearchResultViewController *searchVC = MallInstantiateViewControllerWithIdentifier(@"MallSearchResultViewController");
            searchVC.hidesBottomBarWhenPushed = YES;
            searchVC.keyWords = searchKey;
            [self.navigationController pushViewController:searchVC animated:YES];
        }
        
        
    } else if ([ItemNavigationUrl hasPrefix:@"Category/"]) {
        NSString *categoryKey = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"Category/" withString:@""];
        categoryKey = [categoryKey yf_decodeURLString];
        [YFUserDefaults setObject:categoryKey forKey:@"HPCategroyJumpKey"];
        
        self.tabBarController.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:NO];
    } else if([ItemNavigationUrl hasPrefix:@"ProductDetail/"]) { /// 商品详情
        NSString *productPar = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"ProductDetail/" withString:@""];
        NSArray *proPar = [productPar componentsSeparatedByString:@"/"];
        if (proPar.count >= 2) {
            NSString *ProductVariantID = proPar[0];
            NSString *PromotionID = proPar[1];
            if (PromotionID.longLongValue > 0) {
                MallPromotionActivityViewController *VC = MallInstantiateViewControllerWithIdentifier(@"MallPromotionActivityViewController");
                VC.promotionID = [PromotionID longLongValue];
                VC.hidesBottomBarWhenPushed = YES;
                VC.delegate = self;
                [self.navigationController pushViewController:VC animated:YES];
            } else {
                WineIsConvenDetailPage *VC = [[WineIsConvenDetailPage alloc] init];
                VC.productVarientID = [ProductVariantID longLongValue];
                VC.promotionID = [PromotionID longLongValue];
                VC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VC animated:YES];
            }
            
        }
    } else if ([ItemNavigationUrl hasPrefix:@"Page/"]){ /// 内部页面
        NSString *pageKey = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"Page/" withString:@""];
        
        if ([pageKey isEqualToString:@"BrandClub"]) {           /// BrandClub      品牌俱乐部
            [self jumpToBrandClub];
            
        } else if ([pageKey isEqualToString:@"UserCenter"]){    /// UserCenter     个人中心
            int index = self.tabBarController.viewControllers.count-1;
            self.tabBarController.selectedIndex = index;
            [self.navigationController popToRootViewControllerAnimated:NO];
        } else if ([pageKey isEqualToString:@"MyOrder"]){       /// MyOrder        我的订单
            
            if (![CacheHelper isLogin]) {
                [self loginWithCallback:^{
                    [self pushToOrderList];
                }];
            } else {
                [self pushToOrderList];
            }
        } else if ([pageKey isEqualToString:@"ShoppingCart"]){  /// ShoppingCart   购物车
            int index = self.tabBarController.viewControllers.count-2;
            self.tabBarController.selectedIndex = index;
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        } else if ([pageKey isEqualToString:@"CustomerPoint"]){ /// CustomerPoint  积分兑换
            
            if (![CacheHelper isLogin]) {
                [self loginWithCallback:^{
                    [self pushToPointExchange];
                }];
            } else {
                [self pushToPointExchange];
            }
            
        } else if ([pageKey isEqualToString:@"Coupon"]) {        /// Coupon    我的优惠券
            
            if (![CacheHelper isLogin]) {
                [self loginWithCallback:^{
                    [self pushToWalletWithOffsetTag:2];
                }];
            } else {
                [self pushToWalletWithOffsetTag:2];
            }
            
        } else if ([pageKey isEqualToString:@"Login"]){         /// Login       登录界面
            MallLoginViewController *vc = MallInstantiateViewControllerWithIdentifier(LOGIN_VC_NAME);
            vc.isAutoBack = YES;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if ([pageKey isEqualToString:@"Stores"]) {       /// Stores      附近门店
            StoreMapListVC *vc = MallInstantiateViewControllerWithIdentifier(@"storeMapList");
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }  else if ([pageKey isEqualToString:@"FlashSale"]) {       /// Stores      限时抢购
            
            FlashBuyWinesabPage *page = [FlashBuyWinesabPage new];
            page.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:page animated:YES];
 
            
        }else if ([pageKey isEqualToString:@"NewFlashSale"]) {       /// NewFlashSale      分时间-限时抢购
            if (![CacheHelper isLogin]) {
                [self loginWithCallback:^{
                    FlashBuyWinesPage *tPage = [FlashBuyWinesPage new];
                    tPage.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:tPage animated:YES];
                }];
            } else {
                FlashBuyWinesPage *tPage = [FlashBuyWinesPage new];
                tPage.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tPage animated:YES];
            }
            
        } else if ([pageKey isEqualToString:@"ShareGift"]) {   /// ShareGift    分享有礼
            if (![CacheHelper isLogin]) {
                [self loginWithCallback:^{
                    [self getShareData];
                    [self shareForGift];
                }];
            } else {
                [self getShareData];
                [self shareForGift];
            }
        } else if ([pageKey isEqualToString:@"CouponCenter"]) { /// 领券中心
            
            /// 领取更多优惠券
            LQManagerPage *page = [LQManagerPage new];
            page.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:page animated:YES];
            
        } else if ([pageKey isEqualToString:@"HomePage"]) { /// 首页
            [self.tabBarController setSelectedIndex:0];
            [self.navigationController popToRootViewControllerAnimated:NO];
        } else if ([pageKey isEqualToString:@"NationalSales"]){
            [YFNotificationDefault postNotificationName:ForceChangeNationalSaleNotification object:nil];
            [self.tabBarController setSelectedIndex:0];
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        } else if ([pageKey isEqualToString:@"Plus"]){
            
            PlusMemberController *pmc = [[PlusMemberController alloc] init];
            pmc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pmc animated:YES];
            
        }
        /// 代驾券列表页
        else if ([pageKey isEqualToString:@"DrivingCarCoupon"]){
            [self pushToDrivingCouponsList];
        }
        
        /// 商品积分活动列表
        else if ([pageKey isEqualToString:@"ProductPointsActivity"]) {
            
            LJGJListPage *page = LJGJListPage.new;
            page.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:page animated:true];

        }
        /// 新积分中心
        else if ([pageKey isEqualToString:@"PointCenter"]) {
            
            if (![CacheHelper isLogin]) {
                [self loginWithCallback:^{
                    IntegralCenterViewController *page = [[IntegralCenterViewController alloc] initWithNibName:@"IntegralCenterViewController" bundle:nil];
                    page.hidesBottomBarWhenPushed = true;
                    [self.navigationController pushViewController:page animated:true];
                }];
            } else {
                IntegralCenterViewController *page = [[IntegralCenterViewController alloc] initWithNibName:@"IntegralCenterViewController" bundle:nil];
                page.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:page animated:true];
            }
            
            

        }
        // 茅台页
        else if ([pageKey isEqualToString:@"MaoTai"]) {
            [self pushToWebWithUrl:[NSString stringWithFormat:@"%@Activity/MaoTai/Index.aspx?bid=[branchid]&t=[timestamp]", MicroMall_BaseUrl]];
        
        }
    } else if ([ItemNavigationUrl hasPrefix:@"Tel/"]) { // 网页拨打电话
        NSString *phoneNum = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"Tel/" withString:@""];
        if (phoneNum.length) {
            [YFHelper callWithNumber:phoneNum];
        }
    } else if ([ItemNavigationUrl hasPrefix:@"tel:"]) { // 网页拨打电话
        NSString *phoneNum = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"tel:" withString:@""];
        if (phoneNum.length) {
            [YFHelper callWithNumber:phoneNum];
        }
    }
    else if ([ItemNavigationUrl hasPrefix:@"BrandClub/"]) { /// 跳转俱乐部详情
        
        if ([ItemNavigationUrl hasSuffix:@"/Article"]||
            [ItemNavigationUrl hasSuffix:@"/Events"]||
            [ItemNavigationUrl hasSuffix:@"/Topic"]||
            [ItemNavigationUrl hasSuffix:@"/Activity"]||
            [ItemNavigationUrl hasSuffix:@"/LuckyDraw"]) {
            
            /// 跳转到某个俱乐部活动列表  BrandClub/1/Activity
            NSString *activeCodeAndBrandId = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"BrandClub/" withString:@""];
            NSArray *acAndbrandIds= [activeCodeAndBrandId componentsSeparatedByString:@"/"];
            NSString *BrandClubID = acAndbrandIds.firstObject;
            if (BrandClubID.integerValue==0) {
                MineClubMainPageV2 *page = [[MineClubMainPageV2 alloc] initWithNibName:@"MineClubMainPageV2" bundle:nil];
                page.secondCode = [NSString stringWithFormat:@"%@",acAndbrandIds.lastObject];
                page.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:page animated:true];
            } else {
                MineClubDetailPageV2 *page = [[MineClubDetailPageV2 alloc] init];
                page.BrandClubID = BrandClubID.integerValue;
                page.secondCode = acAndbrandIds[1];
                page.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:page animated:YES];
            }
            
        } else {
            NSString *BrandClubID = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"BrandClub/" withString:@""];
            
            if (BrandClubID.length==0 || BrandClubID.intValue==0) {
                [self jumpToBrandClub];
            } else {
                MineClubDetailPageV2 *page = [[MineClubDetailPageV2 alloc] init];
                page.BrandClubID = BrandClubID.integerValue;
                page.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:page animated:YES];
            }
        }
    }
    
    //2022.6.13 fei.yang
    //jblmall://MyBrandClub/LuckyDraw  我的抽奖（所有品牌馆的可用抽奖，抽奖列表）
    //jblmall://MyBrandClub/ProductPoint  我的瓶盖（所有品牌馆，品牌馆瓶盖列表）
    //jblmall://MyBrandClub/Welfare        我的福利（福利兑换记录页）
    else if ([ItemNavigationUrl hasPrefix:@"MyBrandClub/"]) {
        NSString *par = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"MyBrandClub/" withString:@""];
        
        if ([par isEqualToString:@"LuckyDraw"]) {
            MyRaffleViewController *page = [[MyRaffleViewController alloc] initWithNibName:@"MyRaffleViewController" bundle:nil];
            page.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:page animated:YES];
            
        } else if ([par isEqualToString:@"ProductPoint"]) {
            
            ClubMyCapsPageV2 *page = [ClubMyCapsPageV2 new];
            page.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:page animated:YES];
            
        } else if ([par isEqualToString:@"Welfare"]) {
            ClubWefareListPage *tPage = [[ClubWefareListPage alloc] init];
            tPage.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tPage animated:YES];
        }
    }
    
    else if ([ItemNavigationUrl hasPrefix:@"BrandClubActivity/"]) { /// 跳转俱乐部活动详情
        NSString *ActivityID = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"BrandClubActivity/" withString:@""];
        [self jumpBrandClubActivityDetail:ActivityID];
    } else if ([ItemNavigationUrl hasPrefix:@"BrandClubLuckdraw/Activity/"]) { /// 进入抽奖界面
        /// BrandClubLuckdraw/Activity/[LuckyDrawActivityCode]/[标题名称]
        if (![CacheHelper isLogin]) {
            [self loginWithCallback:^{
                [self pushToLuckydrowWithNavigationUrl:ItemNavigationUrl];
            }];
        } else {
            [self pushToLuckydrowWithNavigationUrl:ItemNavigationUrl];
        }
        
    } else if ([ItemNavigationUrl hasPrefix:@"BrandClubLuckdraw/Prize/"]) { /// 进入中奖记录
        
        if (![CacheHelper isLogin]) {
            [self loginWithCallback:^{
                [self pushToLuckyRecWithNavigationUrl:ItemNavigationUrl];
            }];
        } else {
            [self pushToLuckyRecWithNavigationUrl:ItemNavigationUrl];
        }
        
    } else if ([ItemNavigationUrl hasPrefix:@"Wallet/"]) { /// 进入我的钱包指定页
        if (![CacheHelper isLogin]) {
            
            [self loginWithCallback:^{
                [self pushToWalletWithNavigationUrl:ItemNavigationUrl];
            }];
        } else {
            [self pushToWalletWithNavigationUrl:ItemNavigationUrl];
        }
        
    } else if ([ItemNavigationUrl hasPrefix:@"ProductSearchByCoupon/"]) {
        NSString *PromotionCouponCode = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"ProductSearchByCoupon/" withString:@""];
        MallSearchByCouponCodeVC *page = [[MallSearchByCouponCodeVC alloc] init];
        page.promotioncouponcode = PromotionCouponCode;
        page.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:page animated:YES];
    } else if ([ItemNavigationUrl hasPrefix:@"BrandClubArticle/"]) {
        NSString *ArticleID = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"BrandClubArticle/" withString:@""];
        ClubArticleDetailPageV2 *page = [ClubArticleDetailPageV2 new];
        page.hidesBottomBarWhenPushed = YES;
        page.ArticleID = ArticleID.intValue;
        [self.navigationController pushViewController:page animated:YES];
    }else if ([ItemNavigationUrl hasPrefix:@"GiftBag/"]) { // 跳转至礼包详情
        NSString *giftbagId = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"GiftBag/" withString:@""];
        GiftBagViewController *gbvc = [[GiftBagViewController alloc] init];
        gbvc.giftbagId = giftbagId;
        gbvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gbvc animated:YES];
        
    } else if ([ItemNavigationUrl hasPrefix:@"PlusProduct/"]) {
        WineIsConvenDetailPage *page = [WineIsConvenDetailPage new];
        NSString *plusProductID = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"PlusProduct/" withString:@""];
        page.productVarientID = plusProductID.longLongValue;
        page.isPlusQG = YES;
        page.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:page animated:YES];
    } else if ([ItemNavigationUrl hasPrefix:@"Decap/"]) { // 茅台开瓶兑换协议
        
        if (!CacheHelper.isLogin) {
            [self loginWithCallback:^{
                [self pushToCodeCheck:ItemNavigationUrl];
            }];
        } else {
            [self pushToCodeCheck:ItemNavigationUrl];
        }
    } else if ([ItemNavigationUrl hasPrefix:@"Url/"]) {
        ItemNavigationUrl = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"Url/" withString:@""];
        
        ItemNavigationUrl = [ItemNavigationUrl yf_decodeURLString];
        
        if ([self isNeedLogin:ItemNavigationUrl]) {
            MallLoginViewController *vc = MallInstantiateViewControllerWithIdentifier(LOGIN_VC_NAME);
            vc.isAutoBack = YES;
            vc.pushBlock = ^{
                [self pushToWebWithUrl:ItemNavigationUrl];
            };
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self pushToWebWithUrl:ItemNavigationUrl];
        }
    } else if ([ItemNavigationUrl hasPrefix:@"My/"]) {
        
        if (!CacheHelper.isLogin) {
            [self loginWithCallback:^{
                [self pushToMyDesPage:ItemNavigationUrl];
            }];
        } else {
            [self pushToMyDesPage:ItemNavigationUrl];
        }
    }
    
    else if ([ItemNavigationUrl hasPrefix:@"App/Family"]){ /// 跳转酒便利家庭购应用
        /// familyMall
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"familyMall://"]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"familyMall://"] options:@{} completionHandler:nil];
        } else {
            [self toWXMiniProgramm:@"gh_e6f3f17d61e8"];
        }
    }
    else if ([ItemNavigationUrl hasPrefix:@"App/Enterprise"]){ /// 跳转酒便利企业购应用
        /// enterpriseMall
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"enterpriseMall://"]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"enterpriseMall://"] options:@{} completionHandler:nil];
        } else {
            [self toWXMiniProgramm:@"gh_8b73b44ee50d"];
        }
    }
    
    /// 跳转到上一页
    else if ([ItemNavigationUrl hasPrefix:@"ControlButton/Turnoff"]) {
        [self.navigationController popViewControllerAnimated:true];
    }
    // 领取领券中心的优惠券
    else if ([ItemNavigationUrl hasPrefix:@"GetPromotionCoupon/"]) {
        
        if (!CacheHelper.isLogin) {
            [self loginWithCallback:^{
                [self to_get_coupon:ItemNavigationUrl];
            }];
        } else {
            [self to_get_coupon:ItemNavigationUrl];
        }
    }
    
    /// 单俱乐部瓶盖可兑换奖品列表
    else if ([ItemNavigationUrl hasPrefix:@"BrandClubGift"]) {
        NSString *BrandClubID = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"BrandClubGift/" withString:@""];
        /// 进入俱乐部福利详情
        SingleClubWelfareMainPageV2 *page = [SingleClubWelfareMainPageV2 new];
        page.BrandClubID = [BrandClubID longLongValue];
        page.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:page animated:YES];
    }

}

- (void)to_get_coupon:(NSString *)ItemNavigationUrl {
    NSString *PromotionCouponCenterCode = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"GetPromotionCoupon/" withString:@""];
    NSDictionary *dict = @{@"GetSource":@"领券中心",
                           @"BranchID":GlobalData.HPBranchID,
                           @"PromotionCouponCenterCode":PromotionCouponCenterCode
                           };
    [self.tabBarController.view yf_showLoading];
    [MallClientManager.sharedManager receiveCoupons:dict Completion:^(NSInteger type, NSString *msg, MallModelCode code, NSError *error) {
        [self.tabBarController.view yf_hideLoading];

        if (code > 0) {
            if (code == 1) {
                [self.navigationController.view makeToast:@"领取成功" duration:2.5 position:YFScreen_Center];
            } else {
                KCODEALERTSHOW(msg);
            }
        }
    }];
}

- (void)toWXMiniProgramm:(NSString *)gh_id {
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = gh_id;  //拉起的小程序的username
    launchMiniProgramReq.path = @"";    ////拉起小程序页面的可带参路径，不填默认拉起小程序首页，对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"。
    launchMiniProgramReq.miniProgramType = MallWXMiniProgramType; //拉起小程序的类型
    [WXApi sendReq:launchMiniProgramReq completion:nil];
}

/// 跳转到 我的 中的相关页面
- (void)pushToMyDesPage:(NSString *)ItemNavigationUrl {
    NSString *pageKey = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"My/" withString:@""];
    if ([pageKey isEqualToString:@"Address"]) { /// 我的地址
        MallCommonAddressesViewController *page = MallInstantiateViewControllerWithIdentifier(@"MallCommonAddressesViewController");
//            VC.isFromMyAddress = YES;
        page.hidesBottomBarWhenPushed = YES;
        /// 点击我的收货地址
//            [YFUserDefaults setBool:YES forKey:@"isPushToMyAddress"];
        [self.navigationController pushViewController:page animated:YES];
    } else if ([pageKey isEqualToString:@"Favorite"]) { /// 我的收藏
        MallMyCollectionsViewController *page = MallInstantiateViewControllerWithIdentifier(@"MallMyCollectionsViewController");;
        page.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:page animated:YES];
    } else if ([pageKey isEqualToString:@"Feedback"]) { /// 意见反馈
        MallSendSuggestionViewController *page = MallInstantiateViewControllerWithIdentifier(@"MallSendSuggestionViewController");
        page.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:page animated:YES];
    }
}



///// 跳转到追溯码验证
- (void)pushToCodeCheck:(NSString *)ItemNavigationUrl {
    
    NSString *info = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"Decap/" withString:@""];
    NSArray *result = [info componentsSeparatedByString:@"/"];
    if (result.count) {
        
        TraceabilityCodeListController *tclc = [[TraceabilityCodeListController alloc]initWithNibName:@"TraceabilityCodeListController" bundle:nil];
        tclc.ProductVariantID = result.firstObject;
        tclc.titleLabel.text = (result.count > 1) ? result[1] : @"";
        tclc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tclc animated:YES];
    }
}

/// 跳转到钱包
- (void)pushToWalletWithNavigationUrl:(NSString *)ItemNavigationUrl {
    int  offsetTag = 0;
    NSString *WalletKey = [ItemNavigationUrl stringByReplacingOccurrencesOfString:@"Wallet/" withString:@""];
    if ([WalletKey isEqualToString:@"Cash"]) { /// 我的钱包（红包）
        offsetTag = 0;
    } else if ([WalletKey isEqualToString:@"BrandClubCash"]) { /// 我的钱包（俱乐部红包）
        offsetTag = 1;
    } else if ([WalletKey isEqualToString:@"Coupon"]) {/// 我的钱包（优惠券）
        offsetTag = 2;
    }
    [self pushToWalletWithOffsetTag:offsetTag];
}

/// 跳转到抽奖
- (void)pushToLuckydrowWithNavigationUrl:(NSString *)ItemNavigationUrl {
    NSString *occurrencesString = @"BrandClubLuckdraw/Activity/";
    NSString *parsStr = [ItemNavigationUrl stringByReplacingOccurrencesOfString:occurrencesString withString:@""];
    NSArray *pars = [parsStr componentsSeparatedByString:@"/"];
    NSString *LuckyDrawActivityCode = @"";
    NSString *title = @"";
    if (pars.count) {
        LuckyDrawActivityCode = pars.firstObject;
        title = (pars.count==2) ? [pars.lastObject stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] : @"";
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@Club/LuckyDraw/LotteryGames.aspx?c=%@&cid=[customerid]&at=[accesstoken]",MicroMall_BaseUrl,LuckyDrawActivityCode];
    
    WebViewPage *webview = [[WebViewPage alloc]initWithNibName:@"WebViewPage" bundle:nil];
    webview.strtitle = title;
    webview.weburl = urlStr;
    webview.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webview animated:YES];
}

/// 跳转到抽奖记录
- (void)pushToLuckyRecWithNavigationUrl:(NSString *)ItemNavigationUrl {
    PrizeRecordViewController *page = [[PrizeRecordViewController alloc] initWithNibName:@"PrizeRecordViewController" bundle:nil];
    page.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:page animated:YES];
}

/// 跳转到我的代驾券页面
- (void)pushToDrivingCouponsList {
    
    DrivingCouponsPage *page = DrivingCouponsPage.new;
    page.hidesBottomBarWhenPushed = true;
    
    if (!CacheHelper.isLogin) {
        [self loginWithCallback:^{
            [self.navigationController pushViewController:page animated:true];
        }];
    } else {
        [self.navigationController pushViewController:page animated:true];
    }
}

- (void)loginWithCallback:(VBlock)callback {
    MallLoginViewController *vc = MallInstantiateViewControllerWithIdentifier(LOGIN_VC_NAME);
    vc.isAutoBack = YES;
    vc.pushBlock = callback;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
/// 酒便利登录
- (void)loginJBLAutoBack {
    MallLoginViewController *vc = MallInstantiateViewControllerWithIdentifier(LOGIN_VC_NAME);
    vc.isAutoBack = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushToWalletWithOffsetTag:(int)offsetTag {
    
    if (offsetTag==2) {
        MineCouponViewController *page = [[MineCouponViewController alloc]initWithNibName:@"MineCouponViewController" bundle:nil];
        page.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:page animated:YES];
        return;
    }
    
    MallwalletViewController *page = MallInstantiateViewControllerWithIdentifier(@"MallwalletViewController");
    page.offsetTag = offsetTag;
    page.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:page animated:YES];
    
}


- (void)jumpToBrandClub {
    
    MineClubMainPageV2 *page = [[MineClubMainPageV2 alloc] initWithNibName:@"MineClubMainPageV2" bundle:nil];
    page.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:page animated:true];
    
}

- (void)jumpBrandClubActivityDetail:(NSString *)ActivityID {
    MineClubActivityPage *tPage = [[MineClubActivityPage alloc] initWithNibName:@"MineClubActivityPage" bundle:nil];
    tPage.ActivityID = ActivityID;
    tPage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tPage animated:YES];
}


- (void)getShareData {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    shareGiftInfo=@"";
    shareGiftTitle=@"";
    shareGiftUrl=@"";
    shareGiftImage=@"";
    NSArray *arrMallConfig = [userDefault objectForKey:[NSString stringWithFormat:@"%@%lld", @"mallConfig",GlobalData.mallID]];
    for (NSDictionary *dic in arrMallConfig) {
        if ([[dic objectForKey:@"Key"] isEqualToString:@"ShareGift_Info"]) {
            shareGiftInfo =[dic objectForKey:@"Value"];
        }
        
        if ([[dic objectForKey:@"Key"] isEqualToString:@"ShareGift_Title"]) {
            shareGiftTitle =[dic objectForKey:@"Value"];
        }
        
        if ([[dic objectForKey:@"Key"] isEqualToString:@"ShareGift_Url"]) {
            shareGiftUrl =[dic objectForKey:@"Value"];
        }
        
        if ([[dic objectForKey:@"Key"] isEqualToString:@"ShareGift_Image"]) {
            shareGiftImage =[dic objectForKey:@"Value"];
        }
    }
}

#pragma mark - Customer Event
- (void)shareForGift {
    if ([shareGiftInfo isEqualToString:@""]) {
        shareGiftInfo = kShareInfo;
    }
    if ([shareGiftTitle isEqualToString:@""]) {
        shareGiftTitle = kShareTitle;
    }
    if ([shareGiftUrl isEqualToString:@""]) {
        shareGiftUrl = [MicroMall_BaseUrl stringByAppendingString:@"Client_download.aspx?id=139"];
        shareGiftImage = [MicroMall_BaseUrl stringByAppendingString:@"WeChat/ShareImage/appShareIcon.png"];
        
    } else {
        NSDate *senddate = [NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        NSString *shareurl =@"";
        NSString *mallid =[NSString stringWithFormat:@"%lld",GlobalData.mallID];
        NSString *userid =[NSString stringWithFormat:@"%lld",[CacheHelper userID] ];
        NSString *content =[shareGiftUrl stringByReplacingOccurrencesOfString:@"[mallid]" withString:mallid];
        NSString *cotent2=[content stringByReplacingOccurrencesOfString:@"[userid]" withString:userid];
        NSString *cotent3=[cotent2 stringByReplacingOccurrencesOfString:@"[platform]" withString:@"IOS"];
        NSString *cotent4 =[cotent3 stringByReplacingOccurrencesOfString:@"[time]" withString:locationString];
        NSString *cotent5 =[cotent4 stringByReplacingOccurrencesOfString:@"[source]" withString:@"0"];
        shareurl =[cotent5 stringByReplacingOccurrencesOfString:@"[version]" withString:KPOSTCLIENTVERSION];
        shareGiftUrl=shareurl;
    }
    if ([shareGiftImage isEqualToString:@""]) {
        shareGiftImage =[NSString stringWithFormat:@"%@WeChat/ShareImage/%lld/ShareWeixin.png",MicroMall_BaseUrl,GlobalData.mallID];
    }
    NSArray *imageArray = @[];
    if (shareGiftImage) {
        imageArray = @[shareGiftImage];
    }
    NSMutableDictionary *publishContent = [NSMutableDictionary dictionary];
    [publishContent SSDKSetupShareParamsByText:shareGiftInfo
                                        images:imageArray
                                           url:[NSURL URLWithString:shareGiftUrl]
                                         title:shareGiftTitle
                                          type:SSDKContentTypeAuto];
    
    
    [ShareCustom shareWithContent:publishContent shareObj:nil];
    
    
}

- (BOOL)isNeedLogin:(NSString *)weburl {
    
    if ([weburl containsString:@"nologin=1"]) return NO;
    
    /// 如果有这四个字段, 需要登录
    BOOL customerid = [weburl containsString:@"[customerid]"];
    BOOL userid = [weburl containsString:@"[userid]"];
    BOOL token = [weburl containsString:@"[token]"];
    BOOL phone = [weburl containsString:@"[phone]"];
    
    return ((customerid||userid||token||phone)&&![CacheHelper isLogin]);
}

- (void)pushToWebWithUrl:(NSString *)weburl {
    
    if ([weburl containsString:@"LBSQrCode"]) { // 跳转至小程序
        NSString *url = [self getCompleteUrl:weburl];
        NSString *path = [NSString stringWithFormat:@"pages/webview/view1?url=%@", url];
        [self pushToWXLaunchMiniProgramWithPath:path];
        return;
    }
    
    
    WebViewPage *webview = [[WebViewPage alloc]initWithNibName:@"WebViewPage" bundle:nil];
    webview.weburl = [weburl yf_decodeURLString];
    webview.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webview animated:YES];
}
/// 跳转到订单列表
- (void)pushToOrderList {
    NewOrderListPage *orderPage = [[NewOrderListPage alloc] initWithNibName:@"NewOrderListPage" bundle:nil];
    orderPage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderPage animated:YES];
}

/// 跳转到积分兑换
- (void)pushToPointExchange {
    WelfareMallViewController *welfareMall = [[WelfareMallViewController alloc] init];
    welfareMall.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:welfareMall animated:YES];
    
}

- (void)pushToWXLaunchMiniProgramWithPath:(NSString *)path {

    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = wxMiniObgect_UserName;  //拉起的小程序的username
    launchMiniProgramReq.path = path;
    launchMiniProgramReq.miniProgramType = MallWXMiniProgramType; //拉起小程序的类型
    [WXApi sendReq:launchMiniProgramReq completion:nil];
}



// 记录点击位置
//PageName=页面名字
//ItemCode=区域ItemCode
//ClickName=item名称
//ClickContent= 123123123
- (void)recordClickHistory:(YFSectionItemModel *)model {
    
    if (![self.itemCodes containsObject:model.C_ItemCode]) return;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setValue:model.C_PageName forKey:@"PageName"];
    [dict setValue:model.C_ItemCode forKey:@"ItemCode"];
    [dict setValue:model.C_ClickName forKey:@"ClickName"];
    [dict setValue:model.C_ClickContent forKey:@"ClickContent"];
    
    [MallClientManager.sharedManager ClickHistory_Insert:dict success:^(NSString * _Nonnull success) {} fail:^(NSString * _Nonnull msg) {}];
}

- (NSArray *)itemCodes {
    if (_itemCodes == nil) {
        _itemCodes = @[
            @"Banner",
            @"Grid",
            @"Image",
            @"Ad1",
            @"Ad2_A",
            @"Ad2_B",
            @"Ad2_C",
            @"Ad2_D",
            @"Ad2_E",
            @"Ad3_A",
            @"Ad3_B",
            @"Ad3_C",
            @"Ad4_A",
            @"Ad4_B",
            @"Ad5_A",
            @"FlashSale_A",
            @"FlashSale_B",
            @"FlashSale_C",
            @"FlashSale_D",
            @"Product_A",
            @"PopAd",
            @"Category",
            
            //个人中心相关
            @"UserCenterBanner",
            @"UserCenterCoupon",
            @"UserCenterGrid",
            @"MyBrandClub",
            @"GuessYouLike",
            
        ];
        
    }
    return _itemCodes;
}




- (NSString *)getCompleteUrl:(NSString *)url {
    
    NSString *completeUrl = url;
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[mallid]" withString:GlobalData.mallIDStr];
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[userid]" withString:[CacheHelper userIDStr]];
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[platform]" withString:@"IOS"];
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[version]" withString:KPOSTCLIENTVERSION];
    /// fei.yang 18.1.24 新加替换字段
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[customerid]" withString:[CacheHelper customerIDStr]];
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[departmentid]" withString:GlobalData.DeparementID];
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[phone]" withString:[CacheHelper mobilePhone]];
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[timestamp]" withString:[NSDate yf_timestamp]];
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[branchid]" withString:[NSString stringWithFormat:@"%@",GlobalData.HPBranchID]];
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[funver]" withString:FunVer];
    
    NSString *token = [NSString stringWithFormat:@"%@",[YFUserDefaults objectForKey:@"token"]];
    if (IsBlankString(token)) {
        token = @"";
    }
    completeUrl = [completeUrl stringByReplacingOccurrencesOfString:@"[token]" withString:token];
    completeUrl = [completeUrl yf_encodeURLString];
    return completeUrl;
}

EndIgnoreDeprecatedWarning



@end

//
//  UITabBar+YFAdd.m
//  MobileMall
//
//  Created by YangFei on 2017/8/14.
//  Copyright © 2017年 SoftBest1. All rights reserved.
//

#import "UITabBar+YFAdd.h"
#define TabbarItemNums   (self.items.count)        //tabbar的数量 如果是5个设置为5.0
#define ShoppingCartIndex   (self.items.count-2)

@implementation UITabBar (YFAdd)


- (void)yf_showNum:(NSInteger)num onItemIndex:(NSInteger)index {
    
    
    if (num <= 0) {
        [self yf_removeBadgeOnItemIndex:index];
        return;
    }
    
    /// 移除之前数字
    [self yf_removeBadgeOnItemIndex:index];
    ///新建显示数字
    UILabel *labelView = [[UILabel alloc] init];
    labelView.tag = 888 + index;
    labelView.layer.cornerRadius = 9;//圆形
    labelView.layer.masksToBounds = YES;
    labelView.backgroundColor = UIColorFromRGB(0xf80200);//颜色：红色
    labelView.text = [NSString stringWithFormat:@"%ld",(long)num];
    labelView.textColor  = UIColorWhite;
    labelView.font = UIBoldFontMake(11);
    labelView.textAlignment = NSTextAlignmentCenter;
    [labelView sizeToFit];
    CGRect tabFrame = self.frame;
    
    ///确定数字
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    NSInteger margin = IS_NOTCHED_SCREEN ? 3:0;
    labelView.frame = CGRectMake(x, y-margin, 18, 18);//圆形大小为18
    [self addSubview:labelView];
    
}


- (void)yf_hideNumOnItemIndex:(NSInteger)index {
    [self yf_removeBadgeOnItemIndex:index];
}

- (void)yf_removeBadgeOnItemIndex:(NSInteger)index {
    /// 按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}


- (void)yf_showShoppingCartNum {
    [self yf_showNum:[CacheHelper shoppingCartCount] onItemIndex:ShoppingCartIndex];
}

- (void)yf_hideShoppingCartNum {
    [self yf_showNum:0 onItemIndex:ShoppingCartIndex];
}

- (void)yf_showShoppingCartNum:(NSInteger)num {
    [self yf_showNum:num onItemIndex:ShoppingCartIndex];
}

- (void)yf_hideAllShoppingCartNum {
    /// 按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888 + 2 || subView.tag == 888+3) {
            [subView removeFromSuperview];
        }
    }
}



/// fei.yang 19.11.7 购物车顶部添加提示条
- (void)yf_configDeliveryPriceView:(CGFloat)price hide:(BOOL)hide {
    
    
    float percentX = (ShoppingCartIndex +0.5) / TabbarItemNums;
    CGFloat x = ceilf(percentX * self.yf_width);
    
    CGFloat bgH = 36;
    CGFloat bgW = 180;
    
    UIView *bgView = [self viewWithTag:101];

    if (!bgView) {
        bgView = [UIView new];
        bgView.tag = 101;
        bgView.frame = CGRectMake(x-bgW/2, -25, bgW, bgH);
        [self addSubview:bgView];
    }
    
    [bgView setHidden:NO];

    NSInteger minDeliveryAmount = [CacheHelper MinDeliveryAmount];
    if (price > minDeliveryAmount || hide) {
        [bgView setHidden:YES];
        return;
    }

    
    UIImageView *imageV = [bgView viewWithTag:102];
    if (!imageV) {
        imageV = [UIImageView new];
        imageV.frame = bgView.bounds;
        imageV.tag = 102;
        imageV.image = UIImageWithName(@"home_cartpriceBG");
        [bgView addSubview:imageV];
    }
    
    UILabel *leftLabel = [bgView viewWithTag:103];
    if (!leftLabel) {
        leftLabel = [UILabel new];
        leftLabel.tag = 103;
        leftLabel.frame = CGRectMake(10, 3, 65, 20);
        leftLabel.font = UIFontMake(14);
        leftLabel.textColor = UIColorWhite;
        [bgView addSubview:leftLabel];
    }
    
    UILabel *rightLabel = [bgView viewWithTag:104];
    if (!rightLabel) {
        rightLabel = [UILabel new];
        rightLabel.tag = 104;
        rightLabel.frame = CGRectMake(65, 4, 130, 20);
        rightLabel.font = UIFontMake(10);
        rightLabel.textColor = UIColorWhite;
        [bgView addSubview:rightLabel];
    }
    
    
    NSString *leftPrice = [NSString stringWithFormat:@"¥%.2f",price];
    leftLabel.text = leftPrice;
    
    NSString *rightPrice = [NSString stringWithFormat:@"¥%.2f",minDeliveryAmount-price];
    
    NSString *rightTitle = [NSString stringWithFormat:@"还差 %@ 免配送费",rightPrice];
    NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc] initWithString:rightTitle];
    [arrStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xfef00f)} range:[rightTitle rangeOfString:rightPrice]];
    rightLabel.attributedText = arrStr;
    
}

- (void)yf_hidePriceTip {
    [self yf_configDeliveryPriceView:0 hide:YES];
}

- (void)yf_showPriceTip:(CGFloat)price {
    if (price <= 0) {
        [self yf_hidePriceTip];
        return;
    }
    [self yf_configDeliveryPriceView:price hide:NO];
}

@end

//
//  UITableView+YFAdd.m
//
//  Created by YangFei on 2018/8/19.
//  Copyright © 2018年 SoftBest1. All rights reserved.
//

#import "UITableView+YFAdd.h"

@implementation UITableView (YFAdd)

- (void)yf_noDataWithTitle:(NSString *)title data:(NSMutableArray *)data {
    [self yf_noDataWithTitle:title imageName:@"" data:data];
}

- (void)yf_noDataWithImageName:(NSString *)imageName data:(NSMutableArray *)data {
    [self yf_noDataWithTitle:@"" imageName:imageName data:data];
}

- (void)yf_noDataWithTitle:(NSString *)title imageName:(NSString *)imageName data:(NSMutableArray *)data {
    
    if (data.count != 0) {
        self.backgroundView = nil;
        return;
    }
 
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    UIImageView *imageView = [UIImageView new];
    if (imageName.length) {
        UIImage *image = UIImageWithName(imageName);
        imageView.image = image;
        imageView.yf_size = CGSizeMake(SCREEN_WIDTH/9*5, SCREEN_WIDTH/9*5);
        imageView.center = self.center;
        imageView.yf_centerY = self.yf_height * (1 - 0.618);
        imageView.yf_centerX = SCREEN_WIDTH/2;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [backView addSubview:imageView];
    }
    
    if (title.length&&![title isEqualToString:@""]) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.yf_size = CGSizeMake(SCREEN_WIDTH, 40);
        if (imageName.length) {
            titleLabel.center = imageView.center;
            titleLabel.yf_y  = imageView.yf_bottom;
        } else {
            titleLabel.center = backView.center;
        }
        
        titleLabel.textColor = UIColorLightGray;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = UIFontMake(16);
        titleLabel.backgroundColor = UIColorClear;
        titleLabel.text = title;
        [backView addSubview:titleLabel];
    }
    
    if (!title.length&&[title isEqualToString:@""]&&!imageName.length) {
        backView = nil;
    }
    
    self.backgroundView = backView;
}

- (void)yf_noDataFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *footerTip = [[UILabel alloc]initWithFrame:footerView.bounds];
    footerTip.textAlignment = NSTextAlignmentCenter;
    footerTip.textColor = UIColorFromRGB(0x888888);
    footerTip.text = @"已加载全部内容~";
    footerTip.font = UIFontMake(14);
    [footerView addSubview:footerTip];
    self.tableFooterView = footerView;
}

- (void)yf_noDataFooterViewWithTitle:(NSString *)title {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *footerTip = [[UILabel alloc]initWithFrame:footerView.bounds];
    footerTip.textAlignment = NSTextAlignmentCenter;
    footerTip.textColor = UIColorFromRGB(0x888888);
    footerTip.text = title;
    footerTip.font = UIFontMake(14);
    [footerView addSubview:footerTip];
    self.tableFooterView = footerView;
}

@end


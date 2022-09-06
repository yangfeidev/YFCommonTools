//
//  MJAlertView.h
//  MobileMall
//
//  Created by fei.yang on 2021/8/16.
//  Copyright © 2021 SoftBest1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MJTag) {
    MJTagDone = 102,
    MJTagClose = 101,
    MJTagSec = 103
};

typedef void (^MJABlock)(MJTag tag);



NS_ASSUME_NONNULL_BEGIN

@interface MJAlertView : UIView

/// 标题
@property (nonatomic, copy) NSString *title;
/// 提示信息
@property (nonatomic, copy) NSString *message;

@property (weak, nonatomic) IBOutlet UILabel *alertMsg;

/// 按钮名称
@property (nonatomic, copy) NSString *btnTitle;
/// 确认按钮下面的按钮
@property (nonatomic, strong) NSString *otherButtonTitle;
@property (nonatomic, copy) MJABlock callback;

/// tag==102 是确认按钮, tag==101 关闭按钮
+ (instancetype)showWithTitle:(NSString *)title message:(NSString *)msg btnTitle:(NSString *)btnTtitle callback:(MJABlock)callback;

+ (instancetype)mj_AlertTitle:(NSString *)title message:(NSString *)msg btnTitle:(NSString *)btnTtitle callback:(MJABlock)callback;
- (void)show;

@end

NS_ASSUME_NONNULL_END

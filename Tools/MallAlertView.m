 //
//  MallAlertView.m
//
//  Created by YangFei on 2018/8/22.
//  Copyright © 2018年 SoftBest1. All rights reserved.
//

#import "MallAlertView.h"

#define AV_Screen_W ([UIScreen mainScreen].bounds.size.width)
#define AV_Screen_H ([UIScreen mainScreen].bounds.size.height)


typedef void(^AlertViewBlock)();


@interface MallAlertView ()
/// 弹窗主内容view
@property (nonatomic,strong) UIView *contentView;
/// 弹窗标题
@property (nonatomic,copy)   NSString *title;
/// 弹窗message
@property (nonatomic,copy)   NSString *message;
/// message label
@property (nonatomic,strong) UILabel  *messageLabel;
/// 左边按钮title
@property (nonatomic,copy)   NSString *leftButtonTitle;
/// 右边按钮title
@property (nonatomic,copy)   NSString *rightButtonTitle;

@property (nonatomic, copy) AlertViewBlock leftBlock;

@property (nonatomic, copy) AlertViewBlock rightBlock;

@end

@implementation MallAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
              leftButtonTitle:(NSString *)leftButtonTitle
                      handler:(void (^)(void))leftAction
             rightButtonTitle:(NSString *)rightButtonTitle
                      handler:(void (^)(void))rightAction {
    
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.leftButtonTitle = leftButtonTitle;
        self.leftBlock = leftAction;
        self.rightButtonTitle = rightButtonTitle;
        self.rightBlock = rightAction;
        [self setUpUI];
    }
    return self;
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
            leftTitle:(NSString *)leftTitle
              handler:(void (^)(void))leftAction
           rightTitle:(NSString *)rightTitle
              handler:(void (^)(void))rightAction {
    
    MallAlertView *alertView = [[self alloc] initWithTitle:title
                                                   message:message
                                           leftButtonTitle:leftTitle
                                                   handler:leftAction
                                          rightButtonTitle:rightTitle
                                                   handler:rightAction];
    [alertView show];
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          buttonTitle:(NSString *)buttonTitle
              handler:(void (^)(void))leftAction {
    
    MallAlertView *alertView = [[self alloc] initWithTitle:title
                                                   message:message
                                           leftButtonTitle:buttonTitle
                                                   handler:leftAction
                                          rightButtonTitle:@""
                                                   handler:nil];
    [alertView show];
}

+ (void)showWithMessage:(NSString *)message
            buttonTitle:(NSString *)buttonTitle
                handler:(void (^)(void))leftAction {
    MallAlertView *alertView = [[self alloc] initWithTitle:@""
                                                   message:message
                                           leftButtonTitle:buttonTitle
                                                   handler:leftAction
                                          rightButtonTitle:@""
                                                   handler:nil];
    [alertView show];
}





- (void)btnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 101:{ /// 左边按钮
            if (self.leftBlock) {
                [self dismiss];
                self.leftBlock();
            }
        }break;
            
        case 102:{ /// 右边按钮
            if (self.rightBlock) {
                [self dismiss];
                self.rightBlock();
            }
        }break;
            
        default:
            break;
    }
}

- (void)animationAlert:(UIView *)view {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    
}
#pragma mark - /**************** 显示弹窗 ****************/

- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
//    [self animationAlert:self];
}

#pragma mark - /****************  移除弹窗 ****************/
- (void)dismiss {
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)setUpUI {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.1f animations:^{
        self.alpha = 1;
    }];
    CGFloat num = 3/4.0;
    CGFloat bottomBtnH = 35;
    CGFloat cornerRadius = 10;
    
    self.contentView = [UIView new];
    self.contentView.frame = CGRectMake((AV_Screen_W - AV_Screen_W*num) / 2,
                                        (AV_Screen_H - AV_Screen_W*num) / 2,
                                        AV_Screen_W*num,
                                        AV_Screen_W*num);
    self.contentView.center = self.center;
    self.contentView.yf_centerY -= 20;
    [self addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = cornerRadius;
    /// 标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.contentView.yf_width, 22)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title.length ? self.title : @"提示";
    [self.contentView addSubview:titleLabel];
    
    UILabel *message = [UILabel new];
    message.text = self.message;
    message.font = UIFontMake(15);
    message.textColor = UIColorFromRGB(0x666666);
    message.frame = CGRectMake(20, 40, self.contentView.yf_width-40, 0);
    message.textAlignment = NSTextAlignmentCenter;
    message.numberOfLines = 0;
    CGFloat messageH = [self.message yf_sizeForFont:message.font
                                               size:CGSizeMake(self.contentView.yf_width-40, MAXFLOAT)
                                               mode:NSLineBreakByWordWrapping].height;
    message.yf_height = (messageH < 60) ? 60 : messageH;
    [self.contentView addSubview:message];
    
    CGFloat ViewHeight = 20 + 22 + 10 + messageH + bottomBtnH;
    ViewHeight = ViewHeight < 150 ? 150:ViewHeight;
    self.contentView.yf_height = ViewHeight;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButtonNormalTitleColor(leftBtn, UIColorFromRGB(0x333333));
    leftBtn.yf_origin = CGPointMake(0, self.contentView.yf_height-bottomBtnH);
    leftBtn.backgroundColor = UIColorFromRGB(0xffd100);
    
    [self.contentView addSubview:leftBtn];
    [leftBtn setTitle:_leftButtonTitle forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 101;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButtonNormalTitleColor(rightBtn, UIColorFromRGB(0x333333));
    rightBtn.backgroundColor = UIColorFromRGB(0xffd100);
    rightBtn.yf_size = CGSizeMake(self.contentView.yf_width/2, bottomBtnH);
    rightBtn.yf_origin = CGPointMake(self.contentView.yf_width/2, self.contentView.yf_height-bottomBtnH);
    [rightBtn setTitle:_rightButtonTitle forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag = 102;
    
    UIView *midLineView = [UIView new];
    midLineView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    midLineView.yf_size = CGSizeMake(1, bottomBtnH);
    midLineView.yf_origin = CGPointMake(self.contentView.yf_width/2, self.contentView.yf_height-bottomBtnH);
    
    UIView *topLineView = [UIView new];
    topLineView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    topLineView.yf_size = CGSizeMake(self.contentView.yf_width, 1);
    topLineView.yf_origin = CGPointMake(0, self.contentView.yf_height-bottomBtnH);
    
    /// 如果只有一个按钮
    if (!self.rightButtonTitle.length && !self.rightBlock) {
        leftBtn.yf_size = CGSizeMake(self.contentView.yf_width, bottomBtnH);
        [leftBtn yf_clipsByRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else {
        leftBtn.yf_size = CGSizeMake(self.contentView.yf_width/2, bottomBtnH);
        [leftBtn yf_clipsByRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        [rightBtn yf_clipsByRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        [self.contentView addSubview:rightBtn];
        [self.contentView addSubview:midLineView];
        [self.contentView addSubview:topLineView];
    }
    
    if (!self.rightButtonTitle.length&&!self.leftButtonTitle.length) {
        rightBtn.hidden = YES;
        leftBtn.hidden = YES;
    }
    
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButtonNormalImage(closeBtn, @"mall_club_guanbi");
    closeBtn.yf_size = CGSizeMake(50, 50);
    closeBtn.center = self.contentView.center;
    closeBtn.yf_centerY = (self.contentView.yf_bottom+40);
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
}


@end

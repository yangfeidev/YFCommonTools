//
//  MJAlertView.m
//  MobileMall
//
//  Created by fei.yang on 2021/8/16.
//  Copyright © 2021 SoftBest1. All rights reserved.
//

#import "MJAlertView.h"

@interface MJAlertView()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *alertTitle;


@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherButtonHeight;
/// 总高度
///
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertViewH;
/// 内容高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleH;

//顶部标题高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTitleH;



@end

@implementation MJAlertView

+ (instancetype)alertView {
    MJAlertView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self)
                                                              owner:self
                                                            options:nil].lastObject;
    view.frame = [UIScreen mainScreen].bounds;
    
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.bgView addGestureRecognizer:[UITapGestureRecognizer yf_gestureRecognizerWithBlock:^{
        [self removeFromSuperview];
    }]];
    
    self.bgView.backgroundColor = [UIColorBlack colorWithAlphaComponent:0.5f];
    self.backgroundColor = [UIColorBlack colorWithAlphaComponent:0.5f];
}


- (instancetype)showWithTitle:(NSString *)title message:(NSString *)msg btnTitle:(NSString *)btnTtitle callback:(MJABlock)callback {
    MJAlertView *alertView = [MJAlertView alertView];
    alertView.title = title;
    alertView.message = msg;
    alertView.btnTitle = btnTtitle;
    alertView.callback = callback;
    [alertView.closeBtn setHidden:[btnTtitle isEqualToString:@"我知道了"]];
    
    
    CGFloat height = [msg yf_SpaceLabelHeightwithSpeace:5.0 font:alertView.alertMsg.font width:284];
    alertView.titleH.constant = height > 30 ? height : 30;
    
    alertView.alertViewH.constant = height+170;
    
    if (IsBlankString(title)) {
        alertView.topTitleH.constant = 10;
        alertView.alertViewH.constant -= 40;
    }
    
    [alertView show];
    return  alertView;
}

+ (instancetype)showWithTitle:(NSString *)title message:(NSString *)msg btnTitle:(NSString *)btnTtitle callback:(MJABlock)callback {
    return  [[self alloc] showWithTitle:title message:msg btnTitle:btnTtitle callback:callback];
}

+ (instancetype)mj_AlertTitle:(NSString *)title message:(NSString *)msg btnTitle:(NSString *)btnTtitle callback:(MJABlock)callback {
    MJAlertView *alertView = [MJAlertView alertView];
    alertView.title = title;
    alertView.message = msg;
    alertView.btnTitle = btnTtitle;
    alertView.callback = callback;
    [alertView.closeBtn setHidden:[btnTtitle isEqualToString:@"我知道了"]];
    
    CGFloat height = [msg yf_SpaceLabelHeightwithSpeace:5.0 font:alertView.alertMsg.font width:284];
    alertView.titleH.constant = height > 30 ? height : 30;

    alertView.alertViewH.constant = height+170;
    
    if (IsBlankString(title)) {
        alertView.topTitleH.constant = 10;
        alertView.alertViewH.constant -= 40;
    }
    
    return  alertView;
}



- (void)setTitle:(NSString *)title {
    _title = title;
    self.alertTitle.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:message];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentCenter; //设置两端对齐显示
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    
    if (IsBlankString(self.title)) {
        [attributedStr addAttributes:@{NSFontAttributeName: UIBoldFontMake(17)} range:NSMakeRange(0, attributedStr.length)];
    }
    
    self.alertMsg.attributedText = attributedStr;

}


- (void)setBtnTitle:(NSString *)btnTitle {
    [self.actionBtn setTitle:(btnTitle ? : @"我知道了") forState:UIControlStateNormal];
}

- (void)setOtherButtonTitle:(NSString *)otherButtonTitle {
    [self.otherButton setTitle:otherButtonTitle forState:(UIControlStateNormal)];
    self.otherButtonHeight.constant = otherButtonTitle ? 30.0 : 0.0;
    self.alertViewH.constant += 30.0;
}

- (IBAction)btnClicked:(UIButton *)sender {
    
    switch (sender.tag) {
            
        case MJTagDone:{ /// 点击黄色按钮
            if (self.callback) {
                self.callback(sender.tag);
            }
        } break;
            
        case MJTagClose:{ /// 点击关闭
            if (self.callback) {
                self.callback(sender.tag);
            }
        } break;
        case MJTagSec:{ /// 不参加秒杀按钮
            if (self.callback) {
                self.callback(sender.tag);
            }
        } break;
        default:
            break;
    }
    
    [self hidden];
}

#pragma mark - /**************** 显示弹窗 ****************/

- (void)show {
    
    if (GlobalData.hasShowNoStockAlert) {
        return;
    }
    
    [[self keyWindow] addSubview:self];
    GlobalData.hasShowMJAlert = true;
}

- (UIWindow *)keyWindow {
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    } else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

#pragma mark - /****************  移除弹窗 ****************/
- (void)hidden {
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    GlobalData.hasShowMJAlert = false;

}

@end

//
//  CKAlert.m
//  GameCenter
//
//  Created by CaydenK on 15/6/23.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "CKAlert.h"
#import <Masonry/Masonry.h>

#define DEFAULT_DURATION 0.5
#define DEFAULT_DELAY 1

#define kH_MARGIN 22
#define kV_MARGIN 13

@interface CKAlert ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *msgLabel;

@end

@implementation CKAlert

+ (CKAlert *)shareInstance{
    static CKAlert *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        instance.backgroundColor = UIColorFromRGBA(BaseColor,0.9);
        [instance addSubview:instance.titleLabel];
        [instance addSubview:instance.msgLabel];
        instance.layer.cornerRadius = 2.f;
//        instance.layer.shadowColor = UIColorFromRGB(0x66cccc).CGColor;
//        instance.layer.shadowOffset = CGSizeMake(5, 5);
//        instance.layer.shadowRadius = 20;
//        instance.layer.shadowOpacity = 0.8;
        
    });
    return instance;
}
+ (CKAlert *)showAlertWithMsg:(NSString *)msg{
    return [self showAlertWithMsg:msg duration:DEFAULT_DURATION delay:DEFAULT_DELAY center:CKAlertCenterUp];
}
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg{
    return [self showAlertWithTitle:title msg:msg duration:DEFAULT_DURATION delay:DEFAULT_DELAY center:CKAlertCenterUp];
}
+ (CKAlert *)showAlertWithMsg:(NSString *)msg duration:(NSTimeInterval)duration{
    return [self showAlertWithMsg:msg duration:duration delay:DEFAULT_DELAY center:CKAlertCenterUp];
}
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg duration:(NSTimeInterval)duration{
    return [self showAlertWithTitle:title msg:msg duration:duration delay:DEFAULT_DELAY center:CKAlertCenterUp];
}
+ (CKAlert *)showAlertWithMsg:(NSString *)msg delay:(NSTimeInterval)delay{
    return [self showAlertWithMsg:msg duration:DEFAULT_DURATION delay:delay center:CKAlertCenterUp];
}
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg delay:(NSTimeInterval)delay{
    return [self showAlertWithTitle:title msg:msg duration:DEFAULT_DURATION delay:delay center:CKAlertCenterUp];
}
+ (CKAlert *)showAlertWithMsg:(NSString *)msg center:(CKAlertCenter)center{
    return [self showAlertWithMsg:msg duration:DEFAULT_DURATION delay:DEFAULT_DELAY center:center];
}
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg center:(CKAlertCenter)center{
    return [self showAlertWithTitle:title msg:msg duration:DEFAULT_DURATION delay:DEFAULT_DELAY center:center];
}
+ (CKAlert *)showAlertWithMsg:(NSString *)msg duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay{
    return [self showAlertWithMsg:msg duration:duration delay:delay center:CKAlertCenterUp];
}
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay{
    return [self showAlertWithTitle:title msg:msg duration:duration delay:delay center:CKAlertCenterUp];
}
+ (CKAlert *)showAlertWithMsg:(NSString *)msg duration:(NSTimeInterval)duration center:(CKAlertCenter)center{
    return [self showAlertWithMsg:msg duration:duration delay:DEFAULT_DELAY center:center];
}
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg duration:(NSTimeInterval)duration center:(CKAlertCenter)center{
    return [self showAlertWithTitle:title msg:msg duration:duration delay:DEFAULT_DELAY center:center];
}
+ (CKAlert *)showAlertWithMsg:(NSString *)msg delay:(NSTimeInterval)delay center:(CKAlertCenter)center{
    return [self showAlertWithMsg:msg duration:DEFAULT_DURATION delay:delay center:center];
}
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg delay:(NSTimeInterval)delay center:(CKAlertCenter)center{
    return [self showAlertWithTitle:title msg:msg duration:DEFAULT_DURATION delay:delay center:center];
}

+ (CKAlert *)showAlertWithMsg:(NSString *)msg duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay center:(CKAlertCenter)center{
    CKAlert *alert = [self shareInstance];
    [alert.layer removeAnimationForKey:@"group"];
    [alert removeFromSuperview];
    
    alert.titleLabel.hidden = YES;
    alert.msgLabel.hidden = NO;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alert];
    [alert mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (center == CKAlertCenterUp) {
            make.top.equalTo(window.mas_top).with.offset(400/3);
        }
        else if (center == CKAlertCenterMiddle){
            make.top.equalTo(window.mas_centerY);
        }
        else if (center == CKAlertCenterDown){
            make.top.equalTo(window.mas_bottom).with.offset(-500/3);
        }
        make.left.greaterThanOrEqualTo(window.mas_left).with.offset(200/3);
        make.right.lessThanOrEqualTo(window.mas_right).with.offset(-200/3);
        make.centerX.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(10);
    }];
    [alert.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kV_MARGIN); //  相对于self.view 顶部 10
        make.bottom.mas_equalTo(-kV_MARGIN);
        make.left.equalTo(alert.mas_left).offset(kH_MARGIN);    //  相对于self.view 左边 10
        make.right.equalTo(alert.mas_right).offset(-kH_MARGIN);  //  相对于self.view 右边 -10
    }];
    alert.msgLabel.text = msg;
    [alert layoutIfNeeded];

    [alert addAnimationWithDuration:duration?:DEFAULT_DURATION delay:delay?:DEFAULT_DELAY];
    return alert;
}
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay center:(CKAlertCenter)center{
    CKAlert *alert = [self shareInstance];
    [alert.layer removeAnimationForKey:@"group"];
    [alert removeFromSuperview];
    
    alert.titleLabel.hidden = NO;
    alert.msgLabel.hidden = NO;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alert];
    
    
    [alert mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (center == CKAlertCenterUp) {
            make.top.equalTo(window).with.offset(400/3);
        }
        else if (center == CKAlertCenterMiddle){
            make.top.equalTo(window.mas_centerY);
        }
        else if (center == CKAlertCenterDown){
            make.top.equalTo(window.mas_bottom).with.offset(-500/3);
        }
        make.left.greaterThanOrEqualTo(window).with.offset(200/3);
        make.right.lessThanOrEqualTo(window).with.offset(-200/3);
        make.centerX.equalTo(window.mas_centerX);
        make.bottom.equalTo(alert.msgLabel).with.offset(10);
    }];
    [alert.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alert).offset(kV_MARGIN);
        make.left.equalTo(alert).offset(kH_MARGIN);
        make.right.equalTo(alert).offset(-kH_MARGIN);
    }];
    [alert.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alert.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(alert).offset(kH_MARGIN);
        make.right.equalTo(alert).offset(-kH_MARGIN);
    }];
    alert.titleLabel.text = title;
    alert.msgLabel.text = msg;
    [alert layoutIfNeeded];

    [alert addAnimationWithDuration:duration?:DEFAULT_DURATION delay:delay?:DEFAULT_DELAY];
    return alert;
}

- (void)addAnimationWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay{
    self.layer.opacity = 0;
    CABasicAnimation *a0 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    //    a0.fromValue = @0;
    a0.byValue = @1;
    a0.toValue = @1;
    a0.duration = duration;
    a0.beginTime = 0;
    
    CABasicAnimation *a1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    a1.byValue = @0;
    a1.toValue = @1;
    a1.duration = delay;
    a1.beginTime = duration;
    
    
    CABasicAnimation *a2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    a2.fromValue = @1;
    a2.toValue = @0;
    a2.duration = duration;
    a2.beginTime = duration+delay;
    
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[a0,a1,a2];
    animation.duration = a0.duration+a0.beginTime+a2.beginTime+a2.duration;
    animation.delegate = self;
    
    [self.layer addAnimation:animation forKey:@"group"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self removeFromSuperview];
    }
}

#pragma mark
#pragma mark - get set
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 400/3*2;
    }
    return _titleLabel;
}
- (UILabel *)msgLabel{
    if (_msgLabel == nil) {
        _msgLabel = [UILabel new];
        _msgLabel.numberOfLines = 0;
        _msgLabel.textColor = [UIColor whiteColor];
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 400/3*2;

    }
    return _msgLabel;
}

@end

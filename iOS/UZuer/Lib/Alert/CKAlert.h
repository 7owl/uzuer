//
//  CKAlert.h
//  GameCenter
//
//  Created by CaydenK on 15/6/23.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  弱提示显示位置
 */
typedef NS_ENUM(NSUInteger, CKAlertCenter){
    /**
     *  上方
     */
    CKAlertCenterUp = 0,    //默认
    /**
     *  中间
     */
    CKAlertCenterMiddle,
    /**
     *  下方
     */
    CKAlertCenterDown,
};

@interface CKAlert : UIView

/**
 *  提示信息 （总持续时间为：duration*2+delay）
 *
 *  @param msg      提示内容
 *  @param duration 动画时间
 *  @param delay    持续时间
 *  @param center   中心位置
 *
 *  @return 提示对象
 */
+ (CKAlert *)showAlertWithMsg:(NSString *)msg;
+ (CKAlert *)showAlertWithMsg:(NSString *)msg duration:(NSTimeInterval)duration;
+ (CKAlert *)showAlertWithMsg:(NSString *)msg delay:(NSTimeInterval)delay;
+ (CKAlert *)showAlertWithMsg:(NSString *)msg center:(CKAlertCenter)center;
+ (CKAlert *)showAlertWithMsg:(NSString *)msg duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay;
+ (CKAlert *)showAlertWithMsg:(NSString *)msg duration:(NSTimeInterval)duration center:(CKAlertCenter)center;
+ (CKAlert *)showAlertWithMsg:(NSString *)msg delay:(NSTimeInterval)delay center:(CKAlertCenter)center;
+ (CKAlert *)showAlertWithMsg:(NSString *)msg duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay center:(CKAlertCenter)center;

/**
 *  提示信息 （总持续时间为：duration*2+delay）
 *
 *  @param title    提示标题
 *  @param msg      提示内容
 *  @param duration 动画时间
 *  @param delay    持续时间
 *  @param center   中心位置
 *
 *  @return 提示对象
 */
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg;
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg duration:(NSTimeInterval)duration;
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg delay:(NSTimeInterval)delay;
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg center:(CKAlertCenter)center;
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay;
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg duration:(NSTimeInterval)duration center:(CKAlertCenter)center;
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg delay:(NSTimeInterval)delay center:(CKAlertCenter)center;
+ (CKAlert *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay center:(CKAlertCenter)center;

@end

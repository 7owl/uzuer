//
//  CKNormalAlert.h
//  GameCenter
//
//  Created by CaydenK on 15/7/28.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  强提示回调种类
 */
typedef NS_ENUM(NSUInteger, CKAlertCallBackType){
    /**
     *  提示取消
     */
    CKAlertCallBackTypeCancel,
    /**
     *  提示确定
     */
    CKAlertCallBackTypeSure,
};

/**
 *  强提醒
 */
@interface CKNormalAlert : UIView


#pragma mark - 新方法 ，不带title
+ (CKNormalAlert *)alertAtWindowWithContent:(NSString *)content cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block;

+ (CKNormalAlert *)alertAtWindowWithContent:(NSString *)content sure:(NSString *)sure cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block;

#pragma mark - 老方法
/**
 *  生成强提示
 *
 *  @param title   标题
 *  @param content 内容
 *  @param sure    确定文字
 *  @param cancel  取消文字
 *  @param block   确定/取消按钮的回调
 *
 *  @return 生成的强提示
 */
+ (CKNormalAlert *)alertWithTitle:(NSString *)title content:(NSString *)content sure:(NSString *)sure cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block;
/**
 *  生成强提示，并添加在window上
 *
 *  @param title   标题
 *  @param content 内容
 *  @param sure    确定文字
 *  @param cancel  取消文字
 *  @param block   确定/取消按钮的回调
 *
 *  @return 生成的强提示
 */
+ (CKNormalAlert *)alertAtWindowWithTitle:(NSString *)title content:(NSString *)content sure:(NSString *)sure cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block;
/**
 *  在特定的视图上添加强提示
 *
 *  @param superView 父视图
 *  @param title   标题
 *  @param content 内容
 *  @param sure    确定文字
 *  @param cancel  取消文字
 *  @param block   确定/取消按钮的回调
 *
 *  @return 生成的强提示
 */
+ (CKNormalAlert *)alertWithSuperView:(UIView *)superView title:(NSString *)title content:(NSString *)content sure:(NSString *)sure cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block;

/**
 *  生成强提示
 *
 *  @param title   标题
 *  @param content 内容
 *  @param block   确定/取消按钮的回调
 *
 *  @return 生成的强提示
 */
+ (CKNormalAlert *)alertWithTitle:(NSString *)title content:(NSString *)content callBack:(void(^)(CKAlertCallBackType type))block;

/**
 *  生成强提示，并添加在window上
 *
 *  @param title   标题
 *  @param content 内容
 *  @param block   确定/取消按钮的回调
 *
 *  @return 生成的强提示
 */
+ (CKNormalAlert *)alertAtWindowWithTitle:(NSString *)title content:(NSString *)content callBack:(void(^)(CKAlertCallBackType type))block;

/**
 *  在特定的视图上添加强提示
 *
 *  @param superView 父视图
 *  @param title   标题
 *  @param content 内容
 *  @param block   确定/取消按钮的回调
 *
 *  @return 生成的强提示
 */
+ (CKNormalAlert *)alertWithSuperView:(UIView *)superView title:(NSString *)title content:(NSString *)content callBack:(void(^)(CKAlertCallBackType type))block;

@end

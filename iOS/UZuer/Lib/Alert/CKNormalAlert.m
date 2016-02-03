//
//  CKNormalAlert.m
//  GameCenter
//
//  Created by CaydenK on 15/7/28.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "CKNormalAlert.h"
#import <Masonry.h>

@interface CKNormalAlert ()

/**
 *  标题Label
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; //去除了title
/**
 *  内容Label
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/**
 *  取消按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
/**
 *  确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

/**
 *  取消按钮事件
 *
 *  @param sender 取消按钮
 */
- (IBAction)cancelButtonAction:(UIButton *)sender;
/**
 *  确定按钮事件
 *
 *  @param sender 确定按钮
 */
- (IBAction)sureButtonAction:(UIButton *)sender;

/**
 *  按钮回调block
 */
@property (nonatomic, copy) void(^block)(CKAlertCallBackType type);

@end

@implementation CKNormalAlert

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
+ (CKNormalAlert *)alertWithTitle:(NSString *)title content:(NSString *)content sure:(NSString *)sure cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block {
    NSAssert(content, @"content can not be nil");
    
    CKNormalAlert *alert = [[NSBundle mainBundle]loadNibNamed:@"CKNormalAlert" owner:nil options:nil].firstObject;
//    alert.titleLabel.text = title;
    alert.contentLabel.text = content;
    if (cancel.length > 0) {
        [alert.cancelButton setTitle:cancel forState:UIControlStateNormal];
    }
    if (sure.length > 0) {
        [alert.sureButton setTitle:sure forState:UIControlStateNormal];
    } else {
        [alert.sureButton removeFromSuperview];
        [alert.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-25);
        }];
    }
    alert.block = block;
    return alert;
}


+ (CKNormalAlert *)alertAtWindowWithContent:(NSString *)content cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block
{
    return [self alertAtWindowWithContent:content sure:nil cancel:cancel callBack:block];
}

+ (CKNormalAlert *)alertAtWindowWithContent:(NSString *)content sure:(NSString *)sure cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block
{
    return [self alertAtWindowWithTitle:nil content:content sure:sure cancel:cancel callBack:block];
}
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
+ (CKNormalAlert *)alertAtWindowWithTitle:(NSString *)title content:(NSString *)content sure:(NSString *)sure cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block {
    CKNormalAlert *alert = [self alertWithTitle:title content:content sure:sure cancel:cancel callBack:block];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    return alert;
}
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
+ (CKNormalAlert *)alertWithSuperView:(UIView *)superView title:(NSString *)title content:(NSString *)content sure:(NSString *)sure cancel:(NSString *)cancel callBack:(void(^)(CKAlertCallBackType type))block {
    CKNormalAlert *alert = [self alertWithTitle:title content:content sure:sure cancel:cancel callBack:block];
    [superView addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    return alert;
}

/**
 *  生成强提示
 *
 *  @param title   标题
 *  @param content 内容
 *  @param block   确定/取消按钮的回调
 *
 *  @return 生成的强提示
 */
+ (CKNormalAlert *)alertWithTitle:(NSString *)title content:(NSString *)content callBack:(void(^)(CKAlertCallBackType type))block {
    CKNormalAlert *alert = [self alertWithTitle:title content:content sure:nil cancel:nil callBack:block];
    return alert;
}

/**
 *  生成强提示，并添加在window上
 *
 *  @param title   标题
 *  @param content 内容
 *  @param block   确定/取消按钮的回调
 *
 *  @return 生成的强提示
 */
+ (CKNormalAlert *)alertAtWindowWithTitle:(NSString *)title content:(NSString *)content callBack:(void(^)(CKAlertCallBackType type))block {
    CKNormalAlert *alert = [self alertAtWindowWithTitle:title content:content sure:nil cancel:nil callBack:block];
    
    return alert;
}

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
+ (CKNormalAlert *)alertWithSuperView:(UIView *)superView title:(NSString *)title content:(NSString *)content callBack:(void(^)(CKAlertCallBackType type))block {
    CKNormalAlert *alert = [self alertWithSuperView:superView title:title content:content sure:nil cancel:nil callBack:block];
    return alert;
}

/**
 *  取消按钮事件
 *
 *  @param sender 取消按钮
 */
- (IBAction)cancelButtonAction:(UIButton *)sender {
    if (self.block) {
        self.block(CKAlertCallBackTypeCancel);
        self.block = nil;
    }
    [self removeFromSuperview];
}
/**
 *  确定按钮事件
 *
 *  @param sender 确定按钮
 */
- (IBAction)sureButtonAction:(UIButton *)sender {
    if (self.block) {
        self.block(CKAlertCallBackTypeSure);
        self.block = nil;
    }
    [self removeFromSuperview];
}
@end

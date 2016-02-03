//
//  UZAliPayManager.h
//  UZuer
//
//  Created by CaydenK on 15/9/15.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "UZWebBridge.h"

@interface Product : NSObject{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;

@end


@class UZRecommendRoom;
@interface UZAliPayManager : NSObject

/**
 *  选择付款方式  押一付三 ，分期付款
 */
+ (void)choosePayWayWithRoom:(UZRecommendRoom *)room currentVC:(UIViewController *)currentVC;

/**
 *  调用支付宝钱包
 *  @params tradeNO 订单号
 */
+ (void)payOrderWithProduct:(Product *)product tradeNO:(NSString *)tradeNO completionBlock:(void(^)(NSDictionary *resultDic))block;

/**
 *  创建订单使用支付宝付款
 */
+ (void)createOrderAndPayWithRoom:(UZRecommendRoom *)room
                     contractType:(ContractType)contractType
                        currentVC:(UIViewController *)currentVC;

+ (void)openURL:(NSURL *)url;


/**
 *  判断成功或者失败
 *  @param status 支付宝状态码
 */
+ (BOOL)isSuccessWithStatus:(NSInteger)status;

@end

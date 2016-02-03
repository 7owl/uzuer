//
//  UZAliPayManager.m
//  UZuer
//
//  Created by CaydenK on 15/9/15.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZAliPayManager.h"
#import "Order.h"
#import "DataSigner.h"
#import "UZWebBridge.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UZCostAcountViewController.h"
#import "UZContractDetailViewController.h"
#import "UZOrder.h"
#import "UZRecommendRoom.h"
#import "UZAuthenticaionNameViewController.h"

@implementation Product

@end

@interface UZAliPayManager ()

@property (nonatomic, copy) void(^block)(NSDictionary *resultDic);

@end

@implementation UZAliPayManager

+ (void)load {
    [super load];
}

+ (UZAliPayManager *)shareManager {
    static UZAliPayManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

//+ (NSString *)generateTradeNO
//{
//    static int kNumber = 15;
//    
//    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//    srand(time(0));
//    for (int i = 0; i < kNumber; i++)
//    {
//        unsigned index = rand() % [sourceStr length];
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//        [resultStr appendString:oneStr];
//    }
//    return resultStr;
//}



+ (void)payOrderWithProduct:(Product *)product tradeNO:(NSString *)tradeNO completionBlock:(void(^)(NSDictionary *resultDic))block {
    [self shareManager].block = block;
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    //TODO:test
//    product.price = 0.01;
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = AlipayPartner;
    NSString *seller = AlipaySeller;
    NSString *privateKey = AlipayPrivateKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = tradeNO; //订单ID（由商家自行制定）
    order.productName = product.subject; //商品标题
    order.productDescription = product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    order.notifyURL = UrlByPath(@"rental/app/notify"); //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"uzuer";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
   
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            ![self shareManager].block?:[self shareManager].block(resultDic);
        }];
    }
}

+ (void)openURL:(NSURL *)url {
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        ![self shareManager].block?:[self shareManager].block(resultDic);
    }];

}

+ (void)choosePayWayWithRoom:(UZRecommendRoom *)room currentVC:(UIViewController *)currentVC
{
    if (UID <= 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
        return;
    }
    if (![UZUserBase shareInstance].email_validate.boolValue || ![UZUserBase shareInstance].identity_valid.boolValue) {
        [CKAlert showAlertWithMsg:@"账号邮箱未认证或者未实名认证"];
        UZAuthenticaionNameViewController * vc = [currentVC.storyboard instantiateViewControllerWithIdentifier:@"UZAuthenticaionNameViewController"];
        [currentVC.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    CKNormalAlert *alert = [CKNormalAlert alertAtWindowWithContent:@"选择付款方式" sure:@"分期付款" cancel:@"支付宝付款" callBack:^(CKAlertCallBackType type) {
        if (type == CKAlertCallBackTypeCancel) {
            //支付宝直接付款
            [self createOrderAndPayWithRoom:room contractType:ContractTypeYa1Fu3 currentVC:currentVC];
        } else {
            //分期付款
            UZCostAcountViewController *costVC = [currentVC.storyboard instantiateViewControllerWithIdentifier:@"UZCostAcountViewController"];
            costVC.room = room;
            [currentVC.navigationController pushViewController:costVC animated:YES];
        }
    }];
    [alert addGestureRecognizer:[UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [alert removeFromSuperview];
    }]];
}

+ (void)createOrderAndPayWithRoom:(UZRecommendRoom *)room
                       contractType:(ContractType)contractType
                          currentVC:(UIViewController *)currentVC
{
    if (![UZUserBase shareInstance].email_validate.boolValue) {
        [CKAlert showAlertWithMsg:@"邮箱未认证，不能租房"];
        return;
    }
    if (![UZUserBase shareInstance].identity_valid.boolValue) {
        [CKAlert showAlertWithMsg:@"实名未认证，不能租房"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [UZWebBridge asyncPOSTSignConstractWithRoomId:[room.id integerValue] constractType:contractType success:^(id responseDict) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        NSInteger code = [responseDict[@"code"] integerValue];
        if (code == 0) {
            //订单生成成功,
            NSArray *data = responseDict[@"data"];
            if (data.count > 0) {
                NSArray *orderlist = [UZOrder modelsWithDictionarys:data];
                NSString *contractUrl = responseDict[@"url"];
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UZContractDetailViewController *vc = [story instantiateViewControllerWithIdentifier:@"UZContractDetailViewController"];
                vc.contractUrl = [NSURL URLWithString:contractUrl];
                vc.dataSource = orderlist;
                [currentVC.navigationController pushViewController:vc animated:YES];
            } else {
                [CKAlert showAlertWithMsg:responseDict[@"订单生成失败"]];
            }
        } else {
            [CKAlert showAlertWithMsg:responseDict[@"msg"] delay:5];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    }];
}

+ (BOOL)isSuccessWithStatus:(NSInteger)status
{
    if (status == 9000) {
        [CKAlert showAlertWithMsg:@"支付成功"];
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)msgWithStatus:(NSInteger)status
{
    NSDictionary *dict = @{@(9000).stringValue:@"操作成功",
                           @(4000).stringValue:@"支付宝系统异常",
                           @(4001).stringValue:@"数据格式不正确",
                           @(4003).stringValue:@"商家绑定的支付宝账户被冻结或不允许支付",
                           @(4004).stringValue:@"商家已解除绑定",
                           @(4005).stringValue:@"商家绑定失败或没有绑定",
                           @(4006).stringValue:@"支付宝订单支付失败",
                           @(4010).stringValue:@"重新绑定账户",
                           @(6000).stringValue:@"支付服务正在进行升级操作",
                           @(6001).stringValue:@"中途取消支付操作"};
    NSString *msg = dict[@(status).stringValue];
    if (msg == nil) {
        msg = @"未知错误";
    }
    return msg;
}


@end

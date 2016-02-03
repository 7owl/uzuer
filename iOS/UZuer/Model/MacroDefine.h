//
//  MacroDefine.h
//  UZApp
//
//  Created by CaydenK on 15/6/10.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#ifndef UZApp_MacroDefine_h
#define UZApp_MacroDefine_h

#import "UIColor+RGB.h"
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import <UINavigationController+FDFullscreenPopGesture.h>
#import <Aspects/Aspects.h>
#import "UZMD5.h"
#import "CKAlert.h"
#import "CKNormalAlert.h"
#import "UIColor+UZExtend.h"
#import "UIView+AwakeNib.h"
#import "UIBarButtonItem+UZExtend.h"
#import "NSArray+UZExtend.h"
#import "NSDictionary+UZExtend.h"
#import "NSString+UZExtend.h"
#import "UZUserBase.h"
#import "UZGlobalModel.h"


//FIXEME:
/*
 *分发环境下，
 *上AppStore/Adhoc打版， AppStore 宏定义 为1，同时修改bundle id 为com.supin.uzuer，
 *企业账户分发时，AppStore 宏定义为0，同时修改bundle id 为com.supin.e.uzuer
 */
#define AppStore 1

/**
 *  用户id
 */
#define UID [[[UZUserBase shareInstance] uid] integerValue]
/**
 *  token
 */
#define TOKEN [[UZUserBase shareInstance] token]
/**
 *  app版本
 */
#define UZAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/**
 *  Bundle Identifier
 */
#define UZAppBundleIdentifier [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
/**
 *  公司服务热线
 */
#define COMPANY_SERVE_TEL [NSURL URLWithString:@"telprompt:400-1123399"]

//DLog输出的移除。自定义的Log函数如下：
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((fmt @"[文件名:%@; 行号:%d]"), ##__VA_ARGS__, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__);
#define DMethod() NSLog(@"%s", __func__)
#else
#define DLog(...)
#define DMethod()
#endif

//是否iOS7/iOS8//iOS9
#define IOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7&&[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]<8)
#define IOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=8&&[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]<9)
#define IOS9 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=9&&[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]<10)


//判断设备
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  友盟统计Key
 */
#define UMAPPKEY @"55bdd9f767e58ec89e002d4d"
/**
 *  百度地图Key
 */
#if AppStore
#define BDMAPKEY @"o8HhbbDPF1uFLIqN1B1HMY44"
#else
#define BDMAPKEY @"Z50FYzDHPGmMWdQ9OTklMrLP"
#endif

//个信
#ifdef DEBUG
#define GX_AppId @"i01zn4qlp6ApDXL1vbDnH2"
#define GX_AppKey @"hpoOPgjGUB6hHkOHDwPLX9"
#define GX_AppSecret @"G3yAZWvw4p75CNqZPaNot7"
#define GX_MasterSecret @"Z6M3UjWaQb6JziYQd4pPN5"
#elif AppStore
#define GX_AppId @"dITaAOEg7x655K5Et6oy92"
#define GX_AppKey @"LaytfeRuLg9FYJ1eWDUfa9"
#define GX_AppSecret @"UCl0YyjV4Z7i2u41gjm0c2"
#define GX_MasterSecret @"ruRECC9bpm5tNAjzThcGX1"
#else
#define GX_AppId @"f3JN2zYXDiATJ3jlUvGWT"
#define GX_AppKey @"ZIv6iK04fuA0jXBqF4mKZ3"
#define GX_AppSecret @"gzFGUr5Vyc8h1fgaxMryE6"
#define GX_MasterSecret @"Am3uOLkIyv6IV9JpF6SEE2"
#endif

//支付宝
#define AlipayPartner @"2088021354265031"
#define AlipaySeller @"supin_support@163.com"
#define AlipayPrivateKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKSniZfKKTqkYuJuxakDuu61F2327SV/FLLVloaZNVY1ABmj8eQoej4oqmTDySZTk1jFEuvonr6O7xbt5OhAK0+xqCBYPoO8bCMkjvfNg/IP3n2P5y8ZbEMYnoQf8I77R1mWTskgPLAHA8oN1FVjwuOCCnFHvQgfb6r72YSiAT3RAgMBAAECgYA4jIGo6/l09ngvpDOmdG2DBhbh4WhY9Gg7czebSosS7Gj4ZWHyJiS1rGm46bTvwMxeNHDnLKE4eQaMLW/sg/1beHGcBwPCECbcfWb9LzSm8D9iTytid+6b82odmiL39syP1sgcXWLyK3hP7MMyvBSDFTSLPM7DHkOeHF4pb1LX8QJBANCgARGeT1+rAP7Q1zAjKlibwHNfb0OntLs4oQrHZUF6w/QhG18nSHyrOv0eMPDCBSPV6pjAh14bZjYCmzCLBIMCQQDKC2R3cb3wpd/nYAOzVMpjy+wfyWFCQs5OxUdCd54sNoMf4aqZGfWArDsdaiBFm6bj36ClUZRObGBvE9rG5ewbAkBQe9nNtThD3RHGPEU4EejtRDELkV64SAOmUqN2KBR9HWJpVThdDiedyOU57yLMTt1yxLz7bxMKECHvZjP+lzMHAkEAvvlJu0T9nguLue2dUdKhgvbrd5gnoDP5QadjFcZu8aeNBYOOdyx8S2WAcusvGdxoQRfNhrW3kvEJrbR8pGgLZQJBAKAI9lmfcZOUR/5FTZ3vUCQ1BSj0EuDvpHInQLW5vvNTF1vpFio58eTB3Wkx52wTyUTMz6wZSd9gBy4f5C6628I="

//科技侠智能锁
#if DEBUG
#define kScienerAppID @"4f30c19ee69b4754a4faae5e943eccff"
#define kScienerAppSecret @"7783783fcb3f91e4cb5049b29ce55aa9"
#define kScienerRedirectURL @"http://api.uzuer.com/thirdparty/sciener/test"
#else
#define kScienerAppID @"9670ce89415d401281d30365ac729fc1"
#define kScienerAppSecret @"4bae91c16b06562f56fa706faa19d39d"
#define kScienerRedirectURL @"http://api.uzuer.com/thirdparty/sciener"
#endif

//微信分享
#define WXAppID @"wx7def8e0f8ad29f96"
#define WXAppSecret @"c82cb85a1bc97dcb3373894122669e66"

#ifdef DEBUG
#define SHURL_ROOM_DETAIL(SEQ) [NSString stringWithFormat:@"http://120.26.115.220:8080/rental/app/getRoomDetailByRoomSeq?roomSeq=%@",SEQ]
#else 
#define SHURL_ROOM_DETAIL(SEQ) [NSString stringWithFormat:@"http://121.40.71.48:8080/rental/app/getRoomDetailByRoomSeq?roomSeq=%@",SEQ]
#endif

//配色方案
#define BaseColor 0xfb8424 //基色
#define blackFontColor 0x222222 //所有黑字体
#define separatorColor 0xcdcdcd //分割线

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#endif

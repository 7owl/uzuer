//
//  UZReachability.h
//  GameCenter
//
//  Created by CaydenK on 15/6/18.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Reachability/Reachability.h>

typedef NS_ENUM(NSUInteger, UZNetworkType) {
    UZNetworkType_None,
    UZNetworkType_2G,
    UZNetworkType_3G,
    UZNetworkType_4G,
    UZNetworkType_5G,
    UZNetworkType_WIFI,
};

extern NSString *const networkMapping[];

@interface UZReachability : Reachability

+ (UZReachability *)shareInstance;
+ (NSString *)networkString;
//+ (UZNetworkType)getNetworkTypeFromStatusBar;

@end

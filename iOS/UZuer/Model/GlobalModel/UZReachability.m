//
//  UZReachability.m
//  GameCenter
//
//  Created by CaydenK on 15/6/18.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZReachability.h"


NSString *const networkMapping[] = {
    [UZNetworkType_None] = @"无网络",
    [UZNetworkType_2G] = @"2G",
    [UZNetworkType_3G] = @"3G",
    [UZNetworkType_4G] = @"4G",
    [UZNetworkType_5G] = @"5G",
    [UZNetworkType_WIFI] = @"WIFI",
};


@implementation UZReachability

+ (UZReachability *)shareInstance{
    static UZReachability *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]initWithHostname:@"www.baidu.com"];
    });
    return instance;
}

- (instancetype)initWithHostname:(NSString*)hostname
{
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [hostname UTF8String]);
    self = [super initWithReachabilityRef:ref];
    if (self) {
        
    }
    return self;
}

+ (NSString *)networkString {
//    return networkMapping[[self getNetworkTypeFromStatusBar]];
    Reachability *reach = [self shareInstance];
    return networkMap([reach currentReachabilityStatus]);
}
//+ (UZNetworkType)getNetworkTypeFromStatusBar {
//    UIApplication *app = [UIApplication sharedApplication];
//    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
//    NSNumber *dataNetworkItemView = nil;
//    for (id subview in subviews) {
//        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])     {
//            dataNetworkItemView = subview;
//            break;
//        }
//    }
//    UZNetworkType nettype = UZNetworkType_None;
//    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
//    nettype = [num intValue];
//    return nettype;
//}



NSString *networkMap(NetworkStatus status){
    switch (status) {
        case NotReachable:
            return @"";
            break;
        case ReachableViaWiFi:
            return @"wifi";
            break;
        case ReachableViaWWAN:
            return @"2G";
            break;
    }
    return nil;
}

@end

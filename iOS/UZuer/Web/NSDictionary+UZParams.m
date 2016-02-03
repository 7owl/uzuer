//
//  NSDictionary+UZParams.m
//  UZuer
//
//  Created by shenxiaofei on 15/8/20.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "NSDictionary+UZParams.h"
#import "UZLocationManager.h"

#define PLATFORM @"2"
#define AUTH_DICT @{@"uid":@(UID).stringValue,@"platform":PLATFORM,@"version":UZAppVersion,@"token":TOKEN,@"packageName":UZAppBundleIdentifier}

@implementation NSDictionary (UZParams)

- (instancetype)authorized
{
    return [self uz_appendDic:@{@"auth":[AUTH_DICT getJson]}];
}

- (instancetype)cityInfo
{
    return [self uz_appendDic:@{@"cityid":[UZLocationManager shareManager].currentArea}];
}

- (NSDictionary *)uz_appendDic:(NSDictionary *)dic
{
    NSMutableDictionary *mutabDic = self.mutableCopy;
    [mutabDic addEntriesFromDictionary:dic];
    return mutabDic.copy;
}

@end

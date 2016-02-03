//
//  UZGlobalModel.m
//  UZuer
//
//  Created by CaydenK on 15/8/27.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZGlobalModel.h"

@implementation UZGlobalModel
{
    NSString *_tempClientid;
    NSString *_tempDeviceToken;
}
@synthesize tempClientid = _tempClientid,tempDeviceToken = _tempDeviceToken;

+ (UZGlobalModel *)shareInstance {
    static UZGlobalModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (NSString *)tempClientid {
    if (_tempClientid == nil) {
        _tempClientid = @"";
    }
    return _tempClientid;
}
- (NSString *)tempDeviceToken {
    if (_tempDeviceToken == nil) {
        _tempDeviceToken = @"";
    }
    return _tempDeviceToken;
}

- (void)setTempClientid:(NSString *)tempClientid {
    _tempClientid = tempClientid;
}
- (void)setTempDeviceToken:(NSString *)tempDeviceToken {
    _tempDeviceToken = tempDeviceToken;
}

@end

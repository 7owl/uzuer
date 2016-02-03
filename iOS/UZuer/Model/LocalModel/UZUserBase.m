//
//  UZUserBase.m
//  UZuer
//
//  Created by CaydenK on 15/8/24.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZUserBase.h"
#import "CKFMDBHelper.h"
#import "UZNotificationsMacro.h"
#import "UZFavorite.h"

@implementation UZUserBase {
    NSString<CKPrimaryKey> *_uid;
    NSString *_token;
}
@dynamic uid,token;


+ (UZUserBase *)shareInstance {
    static UZUserBase *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"lastuid"] integerValue] > 0) {
            UZUserBase *item = [UZUserBase queryWithConditions:^id(CKConditionMaker *maker) {
                return maker.where([NSString stringWithFormat:@"uid = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"lastuid"]]);
            }].firstObject;
            [instance setValuesFromDictionary:[item modelDictionary]];
        }
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 *  清理单例数据
 */
- (void)clearData {
    NSSet *propertySet = [UZUserBase propertySet];
    [UZFavorite deleteWithConditions:^id(CKConditionMaker *maker) {
        return maker.where(@"1 = 1");
    }];
    [propertySet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [self setValue:@"" forKey:obj];
    }];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lastuid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogoutSuccess object:nil];
}


#pragma mark -
#pragma mark - get & set
- (NSString<CKPrimaryKey> *)uid {
    if (_uid == nil) {
        _uid = (NSString<CKPrimaryKey> *)@"";
    }
    return _uid;
}
- (void)setUid:(NSString<CKPrimaryKey> *)uid {
    _uid = uid;
}

- (NSString *)token {
    if (_token == nil) {
        _token = @"";
    }
    return _token;
}
- (void)setToken:(NSString *)token {
    _token = token;
}

@end

//
//  UZFavorite.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/27.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZFavorite.h"
#import "NSObject+CKProperty.h"

@implementation UZFavorite

- (instancetype)init
{
    self = [super init];
    if (self) {
        _uid = UID;
        _createTime = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

+ (UZFavorite *)favoriteWithRecommendRoom:(UZRecommendRoom *)room{
    UZFavorite *favorite = [UZFavorite new];
    NSSet *propertySet = [UZRecommendRoom propertySet];
    [propertySet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [favorite setValue:[room valueForKey:obj] forKey:obj];
    }];
    return favorite;
}

@end

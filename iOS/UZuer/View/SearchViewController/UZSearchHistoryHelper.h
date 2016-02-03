//
//  UZSearchHistoryHelper.h
//  UZuer
//
//  Created by xiaofeishen on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UZSearchHistoryMaxLength 100 //搜索历史保存的长度

@class UZCommunity;
@interface UZSearchHistoryHelper : NSObject
/**
 *  返回历史搜索列表
 */
@property(nonatomic,copy,readonly) NSArray *searchHistory;

- (void)addNewSearchItem:(UZCommunity *)searchItem;

- (void)clean;

@end

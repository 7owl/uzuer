//
//  UZSearchHistoryHelper.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.

#import "UZSearchHistoryHelper.h"

#define UZSearchHistoryCacheFile @"UZSearchHistoryCacheFile"

@interface UZSearchHistoryHelper()
@property(nonatomic,strong) NSMutableArray *historySearchString;
@end
@implementation UZSearchHistoryHelper

#pragma mark - lifeCycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.historySearchString = [NSKeyedUnarchiver unarchiveObjectWithFile:[self cacheFilePath]];
        if (self.historySearchString == nil) {
            self.historySearchString = @[].mutableCopy;
        }
    }
    return self;
}

- (void)dealloc
{
    [self synchronize];
}

- (void)synchronize
{
    [NSKeyedArchiver archiveRootObject:self.historySearchString toFile:[self cacheFilePath]];
}

- (void)addNewSearchItem:(UZCommunity *)searchItem
{
    if ([self.historySearchString containsObject:searchItem]) {
        [self.historySearchString removeObject:searchItem];
    } else if (self.historySearchString.count == UZSearchHistoryMaxLength){
        [self.historySearchString removeLastObject];
    }
    [self.historySearchString insertObject:searchItem atIndex:0];
    [self synchronize];
}

- (void)clean
{
    [self.historySearchString removeAllObjects];
}

#pragma mark - helper
- (NSString *)cacheFilePath
{
    return [[self cacheDocuments] stringByAppendingPathComponent:UZSearchHistoryCacheFile];
}

- (NSString *)cacheDocuments
{
    NSArray *objs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if (objs.count > 0) {
        NSString *cachepath = objs.firstObject;
        return cachepath;
    } else {
        return nil;
    }
}

#pragma mark - getter & setter
- (NSArray *)searchHistory
{
    return self.historySearchString.copy;
}

@end

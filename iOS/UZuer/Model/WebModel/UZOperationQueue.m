//
//  UZOperationQueue.m
//  GameCenter
//
//  Created by CaydenK on 15/6/16.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZOperationQueue.h"

@implementation UZOperationQueue

+ (UZOperationQueue *)shareInstance{
    static UZOperationQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[UZOperationQueue alloc]init];
        [queue setMaxConcurrentOperationCount:3];
    });
    return queue;
}

- (void)addOperations:(NSArray *)ops waitUntilFinished:(BOOL)wait{
    dispatch_async(dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL), ^{
        [super addOperations:ops waitUntilFinished:wait];
    });
}

@end

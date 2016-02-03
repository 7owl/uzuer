//
//  UZOperationQueue.h
//  GameCenter
//
//  Created by CaydenK on 15/6/16.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UZOperationQueue : NSOperationQueue

/**
 *  全局队列单例
 */
+ (UZOperationQueue *)shareInstance;

@end

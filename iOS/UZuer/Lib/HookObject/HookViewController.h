//
//  HookViewController.h
//  GameCenter
//
//  Created by CaydenK on 15/6/4.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HookViewController : NSObject

+ (instancetype)sharedInstance;

@end

@interface UIViewController (Reachability)

- (void)reachabilityChanged:(NSNotification *)noti;

@end
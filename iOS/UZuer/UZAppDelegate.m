//
//  UZAppDelegate.m
//  UZuer
//
//  Created by CaydenK on 15/7/30.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZAppDelegate.h"
#import "UZAliPayManager.h"
#import <UMengSocial/UMSocialSnsService.h>


@interface UZAppDelegate ()

@end

@implementation UZAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.applicationIconBadgeNumber = 0;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    [UMSocialSnsService  applicationDidBecomeActive];

}

- (void)applicationWillTerminate:(UIApplication *)application {
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    application.applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [UZAliPayManager openURL:url];
//    [scinence HandleOpenURL:url];
    [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];

    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //友盟分享APP回调
    [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    return  YES;
}






@end

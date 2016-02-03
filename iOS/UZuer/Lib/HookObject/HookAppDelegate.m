//
//  HookAppDelegate.m
//  GameCenter
//
//  Created by CaydenK on 15/7/3.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "HookAppDelegate.h"
#import "UZAppDelegate.h"
#import <Aspects/Aspects.h>
#import "UZLocationManager.h"
#import "CKManager.h"
#import "GeTuiSdk.h"
#import "UZWebBridge.h"
#import "UZRecommendRoom.h"
#import "UZCommunity.h"
#import "UZFavorite.h"
#import "UZEKey.h"
#import "UZNotificationsMacro.h"

#import <MobClick.h>
#import <UMengSocial/UMSocial.h>
#import <UMengSocial/UMSocialWechatHandler.h>

@interface HookAppDelegate ()<GeTuiSdkDelegate>

@end

@implementation HookAppDelegate

+ (void)load
{
    [super load];
    [HookAppDelegate sharedInstance];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static HookAppDelegate *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HookAppDelegate alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessNotificate:) name:kNotificationLoginSuccess object:nil];
        
        [UZAppDelegate aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            [self delegate:[aspectInfo instance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:[[aspectInfo arguments] lastObject]];
        } error:NULL];
        
        [UZAppDelegate aspect_hookSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            [self delegate:[aspectInfo instance] application:[UIApplication sharedApplication] didRegisterForRemoteNotificationsWithDeviceToken:[[aspectInfo arguments] lastObject]];
        } error:NULL];

        [UZAppDelegate aspect_hookSelector:@selector(application:didReceiveRemoteNotification:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            [self delegate:[aspectInfo instance] application:[UIApplication sharedApplication] didReceiveRemoteNotification:[[aspectInfo arguments] lastObject]];
        } error:NULL];
    }
    return self;
}

#pragma mark - fake methods
- (void)delegate:(UZAppDelegate *)delegate application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //读取定位
    [[UZLocationManager shareManager] startUserLocationService];
    //[1-1]:通过 AppId、 appKey 、appSecret 启动SDK
    [GeTuiSdk startSdkWithAppId:GX_AppId appKey:GX_AppKey appSecret:GX_AppSecret delegate:self];
    //[1-2]:设置是否后台运行开关
    [GeTuiSdk runBackgroundEnable:YES];
    [MobClick setAppVersion:UZAppVersion];
    [MobClick startWithAppkey:UMAPPKEY];
    
    [UMSocialData setAppKey:UMAPPKEY];
    //设置微信AppId
    [UMSocialWechatHandler setWXAppId:WXAppID appSecret:WXAppSecret url:@"http://www.uzuer.com"];

    //注册推送
    //可用type判断推送类型
    NSInteger type;
    if (IOS7) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    }
    else {
        [application registerForRemoteNotifications];
        UIUserNotificationSettings *set=[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeNone | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];//UIUserNotificationType
        [application registerUserNotificationSettings:set];
        type = [application currentUserNotificationSettings].types;
    }
    
    //状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    //创建表
    DLog(@"dbPath:%@",[CKManager shareManager].dbPath);
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:[CKManager shareManager].dbPath]) {
        [UZRecommendRoom createTable];
        [UZUserBase createTable];
        [UZFavorite createTable];
        [UZFavorite createIndex:@"UZFavoriteIndex" unique:YES columns:@"uid",@"id",nil];
//        [UZEKey createTable];
        
    }

    [UZUserBase shareInstance];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //全局配色
    [self configInterface];
}

- (void)delegate:(UZAppDelegate *)delegate application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    DLog(@"deviceToken:%@",token);
    //    deviceToken上传到个推
    [GeTuiSdk registerDeviceToken:token];
    [UZGlobalModel shareInstance].tempDeviceToken = token;
    [self reportSystemInfo];
}

- (void)delegate:(UZAppDelegate *)delegate application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    id aps = userInfo[@"aps"];
    if ([aps isKindOfClass:[NSDictionary class]]) {
        id alert = aps[@"alert"];
        if ([alert isKindOfClass:[NSDictionary class]]) {
            id body = alert[@"body"];
            if ([body isKindOfClass:[NSString class]]) {
                NSDictionary *dict = [body analyseJson];
                [self disposePushWithDict:dict];
            }
        }
    }
}

- (void)configInterface
{
    UINavigationBar *naviBarAppearance = [UINavigationBar appearance];
    [naviBarAppearance setTintColor:[UIColor whiteColor]];
    [naviBarAppearance setBarTintColor:UIColorFromRGB(BaseColor)];
    [naviBarAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)reportSystemInfo {
    if ([[UZUserBase shareInstance].uid integerValue] > 0 && [UZGlobalModel shareInstance].tempClientid.length > 0 && [UZGlobalModel shareInstance].tempDeviceToken.length > 0) {
        [UZWebBridge asyncPOSTGetTenantDetailWithClientID:[UZGlobalModel shareInstance].tempClientid deviceToken:[UZGlobalModel shareInstance].tempDeviceToken  success:^(id responseDict) {
            NSDictionary *auth = responseDict[@"auth"];
            NSDictionary *data = responseDict[@"data"];
            NSDictionary *authorize = responseDict[@"authorize"];
            [[UZUserBase shareInstance] setValuesFromDictionary:auth];
            [[UZUserBase shareInstance] setValuesFromDictionary:data];
            [[UZUserBase shareInstance] setValuesFromDictionary:authorize];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                [[UZUserBase shareInstance] replace];
                [[NSUserDefaults standardUserDefaults] setObject:@(UID).stringValue forKey:@"lastuid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            });
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserInfoUpdated object:nil];
        } failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark - notificate
- (void)loginSuccessNotificate:(NSNotification *)noti
{
    [self reportSystemInfo];
}

#pragma mark -
#pragma mark - GeTuiSdkDelegate
//SDK启动成功返回cid
- (void) GeTuiSdkDidRegisterClient:(NSString *)clientId {
    [UZGlobalModel shareInstance].tempClientid = clientId;
    [self reportSystemInfo];
}

//SDK收到透传消息回调
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId
{
    // [4]: 收到个推消息
    NSData* payload = [GeTuiSdk retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
    }
    
    NSDictionary *dict = [payloadMsg analyseJson];
    [self disposePushWithDict:dict];
}

//SDK遇到错误回调
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    DLog(@"%@",[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]]);
}

- (void)disposePushWithDict:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        NSInteger type = [dict[@"type"] integerValue];
        if (type == 10) {
            //邮箱推送失败
        } else if (type == 11) {
            //邮箱推送成功
            [self mailAuthSuccess];
        } else if (type == 12) {
            //用户认证成功
            [self idAuthSuccess];
        } else if (type == 14) {
            //用户认证失败
        }
    }
}
//邮箱认证成功
- (void)mailAuthSuccess
{
//    if (UID <= 0) {
//        return;
//    }
    [UZUserBase shareInstance].email_validate = @"1";
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAuthUpdated object:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[UZUserBase shareInstance] replace];
    });
}
//身份认证成功
- (void)idAuthSuccess
{
//    if (UID <= 0) {
//        return;
//    }
    [UZUserBase shareInstance].identity_valid = @"1";
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAuthUpdated object:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[UZUserBase shareInstance] replace];
    });
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

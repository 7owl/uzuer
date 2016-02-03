//
//  HookViewController.m
//  GameCenter
//
//  Created by CaydenK on 15/6/4.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "HookViewController.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>
#import "UZReachability.h"
#import "UZNavigationController.h"
#import "UIViewController+UZExtend.h"

@interface HookViewController ()

@property (nonatomic, strong) Reachability *reach;

@end

@implementation HookViewController

+ (void)load
{
    [super load];
    [HookViewController sharedInstance];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static HookViewController *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HookViewController alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /* 方法拦截 */
        [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            [self didLoadView:[aspectInfo instance]];
        } error:NULL];

        [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo){
            [self deallocView:[aspectInfo instance]];
        } error:NULL];
        
        self.reach = [UZReachability shareInstance];
        [self.reach startNotifier];
    }
    return self;
}

#pragma mark - fake methods
- (void)didLoadView:(UIViewController *)viewController
{
    if ([viewController.navigationController isKindOfClass:[UZNavigationController class]]) {
        UZNavigationController *navi = (UZNavigationController *)viewController.navigationController;
        if (navi.viewControllers.firstObject != viewController) {
            [viewController createBackBarItem];
        }
    }
    
    if ([viewController respondsToSelector:@selector(reachabilityChanged:)]) {
        [[NSNotificationCenter defaultCenter] addObserver:viewController selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    }
}

- (void)deallocView:(UIViewController *)viewController
{
    if ([viewController respondsToSelector:@selector(reachabilityChanged:)]) {
        [[NSNotificationCenter defaultCenter]removeObserver:viewController name:kReachabilityChangedNotification object:nil];
    }
}


@end

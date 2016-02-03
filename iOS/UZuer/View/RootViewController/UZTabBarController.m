//
//  UZTabBarController.m
//  UZuer
//
//  Created by CaydenK on 15/7/30.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZTabBarController.h"
#import "UZLoginViewController.h"

@interface UZTabBarController ()
<UITabBarControllerDelegate>
@end

@implementation UZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = UIColorFromRGB(0xfb8424);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLoginViewController) name:@"present_login_view_controller" object:nil];
    
    self.delegate = self;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self presentLoginViewController];
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentLoginViewController {
    [self presentViewController:[UZLoginViewController new] animated:YES completion:^{
        
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSUInteger selectedIndex = [self.viewControllers indexOfObject:viewController];
    if ((selectedIndex == 1 || selectedIndex == 2) && UID == 0) {
        //未登录
        [CKAlert showAlertWithMsg:@"请先登录"];
        self.selectedIndex = 3;
        return NO;
    } else {
        return YES;
    }
}

@end

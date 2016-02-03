//
//  UIViewController+UZExtend.m
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UIViewController+UZExtend.h"

@implementation UIViewController (UZExtend)

- (void)createBackBarItem {
        UIBarButtonItem *backBar = [[UIBarButtonItem alloc]initWithCustomView:(UIButton *)({
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
            [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageNamed:@"details_page_back"] forState:UIControlStateNormal];
            btn;
        })];
        self.navigationItem.leftBarButtonItem = backBar;
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}


@end

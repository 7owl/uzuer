//
//  UIBarButtonItem+UZExtend.m
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UIBarButtonItem+UZExtend.h"

@implementation UIBarButtonItem (UZExtend)

+ (UIBarButtonItem *)barItemWithTitle:(NSString *)title target:(id)target action:(SEL)sel {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:(UIButton *)({
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
    return barItem;
}
+ (UIBarButtonItem *)barItemWithImage:(UIImage *)image target:(id)target action:(SEL)sel {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:(UIButton *)({
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
        [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:image forState:UIControlStateNormal];
        btn;
    })];
    return barItem;
    
    
    
//    UIBarButtonItem *backBar = [[UIBarButtonItem alloc]initWithCustomView:(UIButton *)({
//        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
//        [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//        [btn setImage:[UIImage imageNamed:@"details_page_back"] forState:UIControlStateNormal];
//        btn;
//    })];
//    self.navigationItem.leftBarButtonItem = backBar;

}


@end

//
//  UIBarButtonItem+UZExtend.h
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (UZExtend)

+ (UIBarButtonItem *)barItemWithTitle:(NSString *)title target:(id)target action:(SEL)sel;
+ (UIBarButtonItem *)barItemWithImage:(UIImage *)image target:(id)target action:(SEL)sel;

@end

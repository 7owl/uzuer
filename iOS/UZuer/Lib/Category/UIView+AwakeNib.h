//
//  UIView+AwakeNib.h
//  ShenKHealthy
//
//  Created by xiaofeishen on 15/7/22.
//  Copyright (c) 2015年 shenxiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AwakeNib)

+ (instancetype)uz_initFromNibName:(NSString *)nibName;

+ (instancetype)uz_viewFromNib;

@end

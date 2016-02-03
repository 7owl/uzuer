//
//  UIView+AwakeNib.m
//  ShenKHealthy
//
//  Created by xiaofeishen on 15/7/22.
//  Copyright (c) 2015年 shenxiaofei. All rights reserved.
//

#import "UIView+AwakeNib.h"

@implementation UIView (AwakeNib)

+(instancetype)uz_initFromNibName:(NSString *)nibName
{
    return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:0].firstObject;
}

+ (instancetype)uz_viewFromNib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
}


@end

//
//  UIView+Designed.m
//  ShenKHealthy
//
//  Created by shenxiaofei on 15/7/15.
//  Copyright (c) 2015年 shenxiaofei. All rights reserved.
//

#import "UIView+Designed.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Designed)

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    self.layer.shadowColor = shadowColor.CGColor;
}

- (UIColor *)shadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    self.layer.shadowOffset = shadowOffset;
}

- (CGSize)shadowOffset
{
    return self.layer.shadowOffset;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity
{
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)shadowOpacity
{
    return self.layer.shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowRadius
{
    return self.layer.shadowRadius;
}

@end

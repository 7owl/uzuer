//
//  UIColor+RGB.h
//  CaydenK
//
//  Created by CaydenK on 15/5/8.
//  Copyright (c) 2015年 平台研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGB)

/**
 *  根据0xFFFFFF格式RGB值创建UIColor
 *
 *  @param rgbValue 0xFFFFFF格式RGB值
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue;
/**
 *  根据0xFFFFFF格式RGB值，不透明度创建UIColor
 *
 *  @param rgbValue 0xFFFFFF格式RGB值
 *  @param alpha    不透明度值
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue Alpha:(CGFloat)alpha;
/**
 *  根据0xFFFFFF格式RGB值创建UIColor
 *
 *  @param rgbValue 0xFFFFFF格式RGB值
 *
 *  @return UIColor
 */
UIColor* UIColorFromRGB(NSInteger rgbValue);
/**
 *  根据0xFFFFFF格式RGB值，不透明度创建UIColor
 *
 *  @param rgbValue 0xFFFFFF格式RGB值
 *  @param alpha    不透明度值
 *
 *  @return UIColor
 */
UIColor* UIColorFromRGBA(NSInteger rgbValue, CGFloat alpha);

@end

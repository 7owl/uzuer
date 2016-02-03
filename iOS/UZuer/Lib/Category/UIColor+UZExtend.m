//
//  UIColor+UZExtend.m
//  UZuer
//
//  Created by CaydenK on 15/8/6.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UIColor+UZExtend.h"

@implementation UIColor (UZExtend)


- (UIImage*) colorImage
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 4.0f, 4.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end

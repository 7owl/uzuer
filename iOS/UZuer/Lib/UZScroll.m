//
//  UZScroll.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/30.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZScroll.h"
#import <BaiduMapAPI_Map/BMKMapView.h>

@implementation UZScroll

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    UIView *tempView = view;
    while (tempView != self) {
        if ([tempView isKindOfClass:[BMKMapView class]]) {
            return NO;
        }
        tempView = tempView.superview;
    }
    return YES;
}


@end

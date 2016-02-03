//
//  UIView+Designed.h
//  ShenKHealthy
//
//  Created by shenxiaofei on 15/7/15.
//  Copyright (c) 2015年 shenxiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Designed)

@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,strong) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,strong) IBInspectable UIColor *shadowColor;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable CGFloat shadowOpacity;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;

@end

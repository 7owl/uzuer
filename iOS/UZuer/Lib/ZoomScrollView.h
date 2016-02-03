//
//  ZoomScrollView.h
//  NewPhotoScvDemo
//
//  Created by zj_apple on 15-1-23.
//  Copyright (c) 2015年 zj_apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,strong)UIImage * imageZoom;//1.直接传入图片并显示
@property (nonatomic,strong)NSString * imgURL;//2.从网络下载图片显示（如果没有传入图片，且imgURL有值的话，会自动从网络下载图片显示）

@property (nonatomic,copy)void(^blockImageTap)();

@end

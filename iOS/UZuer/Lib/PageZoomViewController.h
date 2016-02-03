//
//  PageZoomViewController.h
//  NewPhotoScvDemo
//
//  Created by zj_apple on 15-1-23.
//  Copyright (c) 2015年 zj_apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageZoomViewController : UIViewController

/**
 *  可直接显示的图片
 */
@property (nonatomic,strong)NSArray * arrImage;
/**
 *  图片对应的url地址
 */
@property (nonatomic,strong)NSArray * arrImgUrlStr;
/**
 *  应该呈现的图片的排列位置
 */
@property (nonatomic,assign)NSInteger intStartIndex;
@end

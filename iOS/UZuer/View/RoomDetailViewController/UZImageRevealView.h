//
//  UZImageRevealView.h
//  UZuer
//
//  Created by xiaofeishen on 15/8/2.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UZImageRevealViewDelegate <NSObject>

- (void)UZImageRevealViewPhotoClickAtIndex:(NSInteger)index;

@end
/**
 *  图片展示
 */
@class UZRecommendRoom;
@interface UZImageRevealView : UIView
@property (weak, nonatomic) id<UZImageRevealViewDelegate> delegate;
@property (weak, nonatomic) UZRecommendRoom *room;
@end

//
//  UZRoomMapView.h
//  UZuer
//
//  Created by xiaofeishen on 15/8/5.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UZRoomMapViewDelegate <NSObject>

//test
- (void)navi;

@end


@class UZRecommendRoom,BMKMapView;
@interface UZRoomMapView : UIView

@property (strong, nonatomic) IBOutlet BMKMapView *mapV;
@property (weak,nonatomic) UZRecommendRoom *room;
@property (weak, nonatomic) id<UZRoomMapViewDelegate> delegate;

@end

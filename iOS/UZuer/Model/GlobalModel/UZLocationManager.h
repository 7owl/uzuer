//
//  UZLocationManager.h
//  GameCenter
//
//  Created by CaydenK on 15/7/3.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

/**
 *  启动定位时，用户定位/方向改变后通知
 */
extern NSString *kCKLocationHeadingAndLocationUpdatedNotification;
extern NSString *kCKLocationHeadingAndLocationUpdatedFailedNotification;

@interface UZLocationManager : NSObject

/**
 *  单例
 */
+ (UZLocationManager *)shareManager;

/**
 *  读取定位
 */
- (void)startUserLocationService;

/**
 *  当前已获得到的地区
 *
 *  @return 所在地区
 */
- (NSString *)currentArea;
/**
 *  获取当前坐标
 *
 *  @return 坐标
 */
-  (BMKUserLocation *)bmkUserLocation;

/**
 
 *  经纬度转字符串
 *
 *  @param coordinate 经纬度
 *
 *  @return 经纬度转换成的字符串
 */
OBJC_EXTERN NSString *NSStringFromLocationCoordinate(CLLocationCoordinate2D coordinate);
/**
 *  经纬度字符串转换成经纬度
 *
 *  @param coordinateString 经纬度字符串
 *
 *  @return 经纬度
 */
OBJC_EXTERN CLLocationCoordinate2D CLLocationCoordinate2DFromString(NSString *coordinateString);

//禁用alloc，init，new 创建对象，否则编译会报错
//+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
//-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
//+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

@end

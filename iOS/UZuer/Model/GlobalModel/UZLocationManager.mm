//
//  UZLocationManager.m
//  GameCenter
//
//  Created by CaydenK on 15/7/3.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "NSDictionary+CKExternal.h"

NSString *kCKLocationHeadingAndLocationUpdatedNotification = @"CKLocationHeadingAndLocationUpdated";
NSString *kCKLocationHeadingAndLocationUpdatedFailedNotification = @"kCKLocationHeadingAndLocationUpdatedFailedNotification";

@interface UZLocationManager ()<BMKLocationServiceDelegate>
{
    BOOL _isReversingGeocode;
}
@property (nonatomic, strong) BMKMapManager *mapManager;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) NSDictionary *lastAddressDictionary;

@end

@implementation UZLocationManager

+ (UZLocationManager *)shareManager{
    static UZLocationManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mapManager = [[BMKMapManager alloc]init];
        // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
        BOOL ret = [_mapManager start:BDMAPKEY  generalDelegate:nil];
        if (!ret) {
            DLog(@"地图初始化失败");
        }
        _locationManager =[[CLLocationManager alloc] init];
        _locService = [[BMKLocationService alloc]init];
//        [self achieveLocationPower];
    }
    return self;
}

/**
 *  开启定位
 */
- (void)achieveLocationPower{
    // fix ios8 location issue
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
#ifdef __IPHONE_8_0
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_locationManager performSelector:@selector(requestAlwaysAuthorization)];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
        }
        
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [_locationManager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
        }
#endif
    }
}
/**
 *  读取定位
 */
- (void)startUserLocationService{
    //设置定位精确度，默认：kCLLocationAccuracyBest
    _locService.desiredAccuracy = kCLLocationAccuracyBest;
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    _locService.distanceFilter = 1.00;
    
    //初始化BMKLocationService
    self.locService.delegate = self;
    //启动LocationService
    [self.locService startUserLocationService];
}

/**
 *  当前已获得到的地区
 *
 *  @return 所在地区
 */
- (NSString *)currentArea{
    //第一期杭州写死
#if TARGET_IPHONE_SIMULATOR
    return @"杭州";
#else
    if (self.lastAddressDictionary) {
        NSString *area;
//        if ([[self.lastAddressDictionary ckObjectForKey:@"SubLocality"] length] > 0) {
//            area = [self.lastAddressDictionary ckObjectForKey:@"SubLocality"];
//        }
//        else
            if ([[self.lastAddressDictionary ckObjectForKey:@"City"] length] > 0){
            area = [self.lastAddressDictionary ckObjectForKey:@"City"];
        }
        else if ([[self.lastAddressDictionary ckObjectForKey:@"State"] length] > 0){
            area = [self.lastAddressDictionary ckObjectForKey:@"State"];
        }
        else{
            area = @"全国";
        }
        return area;
    }
    return @"杭州";
#endif
}

/**
 *  获取当前坐标
 *
 *  @return 坐标
 */
-  (BMKUserLocation *)bmkUserLocation {
    return self.locService.userLocation;
}

/**
 *  经纬度转字符串
 *
 *  @param coordinate 经纬度
 *
 *  @return 经纬度转换成的字符串
 */
NSString *NSStringFromLocationCoordinate(CLLocationCoordinate2D coordinate) {
    return [NSString stringWithFormat:@"%lf,%lf",coordinate.longitude,coordinate.latitude];
}
/**
 *  经纬度字符串转换成经纬度
 *
 *  @param coordinateString 经纬度字符串
 *
 *  @return 经纬度
 */
CLLocationCoordinate2D CLLocationCoordinate2DFromString(NSString *coordinateString) {
    NSArray *tmpArray = [coordinateString componentsSeparatedByString:@","];
    CLLocationCoordinate2D coordinate;
    coordinate .longitude = [tmpArray.firstObject doubleValue];
    coordinate .latitude = [tmpArray.lastObject doubleValue];
    return coordinate;
}


#pragma mark
#pragma mark - BMKLocationServiceDelegate
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    [self getAddressByLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCKLocationHeadingAndLocationUpdatedNotification object:self userInfo:self.lastAddressDictionary];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [self.locService stopUserLocationService];
    
    [self getAddressByLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCKLocationHeadingAndLocationUpdatedNotification object:self userInfo:self.lastAddressDictionary];
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    DLog(@"%@",error);
    [[NSNotificationCenter defaultCenter] postNotificationName:kCKLocationHeadingAndLocationUpdatedFailedNotification object:nil userInfo:self.lastAddressDictionary];
}

#pragma mark
#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    if (!_isReversingGeocode) {
        _isReversingGeocode = YES;
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *placemark=[placemarks firstObject];
            self.lastAddressDictionary = placemark.addressDictionary;
        }];
    }
}



@end


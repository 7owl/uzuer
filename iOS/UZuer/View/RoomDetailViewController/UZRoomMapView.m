//
//  UZRoomMapView.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/5.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZRoomMapView.h"
#import "UZRecommendRoom.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <Masonry/Masonry.h>

@interface UZRoomMapView ()
<BMKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mapContainView;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *traffic;

@end
@implementation UZRoomMapView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.mapV = [[BMKMapView alloc] init];
    [self.mapContainView addSubview:self.mapV];
    [self.mapV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.mapV.delegate = self;
    
    //遮挡地图上方出现的黑线，（不知道什么原因）
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.mapContainView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)setRoom:(UZRecommendRoom *)room
{
    if (_room != room) {
        _room = room;
        [self updateUI];
    }
}

- (void)updateUI
{
    NSMutableCharacterSet *ignoreSet = [[NSMutableCharacterSet alloc] init];
    [ignoreSet addCharactersInString:@"幢-#"];
    NSRange range = [_room.cityid rangeOfCharacterFromSet:ignoreSet];
    NSString *zhuangAdress = nil; //幢（地址）
    if (range.location != NSNotFound) {
        zhuangAdress = [_room.cityid substringWithRange:NSMakeRange(0, range.location)];
        zhuangAdress = [zhuangAdress stringByAppendingString:@"幢"];
    }
    if (zhuangAdress == nil || [zhuangAdress isEqualToString:@""]) {
        zhuangAdress = @"";
    }
    self.address.text = zhuangAdress;
    self.traffic.text = _room.metro;
    [self.mapV setZoomLevel:15.f];
    [self.mapV setCenterCoordinate:(CLLocationCoordinate2D){[_room.latitude floatValue],[_room.longitude floatValue]}];
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = (CLLocationCoordinate2D){[_room.latitude floatValue],[_room.longitude floatValue]};
    [self.mapV addAnnotation:annotation];
}

#pragma mark - delegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"identifier"];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"identifier"];
        annotationView.canShowCallout = NO; //不显示气泡
    }
    return annotationView;
}

- (IBAction)navi:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navi)]) {
        [self.delegate navi];
    }
}


@end

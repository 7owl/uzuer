//
//  UZMapSearchRoomsViewController.m
//  UZuer
//
//  Created by CaydenK on 15/8/3.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZMapSearchRoomsViewController.h"
#import <Masonry/Masonry.h>
#import <MapKit/MKMapItem.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <CoreLocation/CoreLocation.h>
#import "UZMapAnnotationView.h"
#import "UZSearchViewController.h"
#import "UZWebBridge.h"
#import "UZMapAnnotation.h"
#import "UZCommunity.h"
#import "UZSearchDetailViewController.h"
#import "UZLocationManager.h"

#define kDefaultDistance 5  //设定搜索半径

@interface UZMapSearchRoomsViewController ()
<
BMKMapViewDelegate,
UITextFieldDelegate,
UZSearchViewControllerDelegate,
UIActionSheetDelegate
>

@property (nonatomic, weak) IBOutlet BMKMapView *mapView;
@property (nonatomic, copy) NSMutableArray *dataSource; //成员anonate
@property (nonatomic, weak) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) UZSearchViewController *searchViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (strong, nonatomic) BMKUserLocation *bmkUserLocation; //当前位置
@property (assign, nonatomic) CLLocationCoordinate2D coorReadyToNavigaion; //导航目的地坐标
@end

@implementation UZMapSearchRoomsViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    [self loadSubviews];
    
}


- (void)setNavigationBar {
    self.fd_interactivePopDisabled = YES;
    self.navigationItem.titleView = self.titleView;
    self.textField.tintColor = UIColorFromRGB(BaseColor);
}

- (void)loadSubviews {
    self.mapView.showsUserLocation = YES; //显示用户当前位置
    [[UZLocationManager shareManager] startUserLocationService];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locateSuccess:) name:kCKLocationHeadingAndLocationUpdatedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locateFailed:) name:kCKLocationHeadingAndLocationUpdatedFailedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCKLocationHeadingAndLocationUpdatedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCKLocationHeadingAndLocationUpdatedFailedNotification object:nil];
}

- (void)dealloc
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - service
- (void)loadCommunitys:(CLLocationCoordinate2D)coor
{
    [UZWebBridge asyncPOSTCommunityByDistance:kDefaultDistance coor:coor success:^(NSArray *responseArray) {
        if (responseArray.count == 0) {
            return;
        }
        NSLog(@"%@",responseArray);
        [self.mapView removeAnnotations:self.dataSource];
        [self.dataSource removeAllObjects];
        for (UZCommunity *item in responseArray) {
            UZMapAnnotation *annotation = [self annotationWithCommunity:item];
            [self.dataSource addObject:annotation];
        }
        [self.mapView addAnnotations:self.dataSource];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - notification
- (void)keyboardFrameWillChanged:(NSNotification *)notification
{
    CGRect beginFrame = [notification.userInfo[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect endFrame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat dValue = beginFrame.origin.y - endFrame.origin.y;
    CGFloat keyboardHeight = beginFrame.size.height;
    if (dValue > 0) {
        //键盘升起
        if (self.searchViewController == nil) {
            UZSearchViewController *vc = [[UZSearchViewController alloc] init];
            vc.delegate = self;
            vc.searchMode = SearchModePlain;
            [self addChildViewController:vc];
            self.searchViewController = vc;
        }
        [self.view addSubview:self.searchViewController.view];
        [self.searchViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).offset(-keyboardHeight);
            make.left.right.mas_equalTo(0);
        }];
    }
}

- (void)locateSuccess:(NSNotification *)notification
{
    self.bmkUserLocation = [UZLocationManager shareManager].bmkUserLocation;
    if (self.bmkUserLocation.location != nil) {
        [self.mapView updateLocationData:self.bmkUserLocation];
        [self.mapView setCenterCoordinate:self.bmkUserLocation.location.coordinate animated:NO];
        [self.mapView setZoomLevel:16.f];
    }
}

- (void)locateFailed:(NSNotification *)notification
{
    [CKAlert showAlertWithMsg:@"定位失败"];
}

#pragma mark - action
- (IBAction)cancelInput:(id)sender
{
    [self.textField resignFirstResponder];
}

- (IBAction)moveToUserLocation:(id)sender
{
    [self.mapView setCenterCoordinate:self.bmkUserLocation.location.coordinate animated:YES];
}

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    UZMapAnnotationView *annotationView = (UZMapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"identifier"];
    if (annotationView == nil) {
        annotationView = [[UZMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"identifier"];
        annotationView.canShowCallout = NO; //不显示气泡
    }
    annotationView.annotation = annotation;
    
    return annotationView;
}

//选中pin
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView deselectAnnotation:view.annotation animated:NO];
    if ([view.annotation isKindOfClass:[UZMapAnnotation class]]) {
        UZMapAnnotation *ano = view.annotation;
        UZCommunity *item = ano.item;
        UZSearchDetailViewController *vc = [[UZSearchDetailViewController alloc] init];
        vc.searchTitle = item.comm_name;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//可视区域发生变化
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
   CLLocationCoordinate2D coor = [mapView convertPoint:mapView.center toCoordinateFromView:mapView];
    [self loadCommunitys:coor];
}


#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        self.rightConstraint.constant = 0;
        [self.titleView layoutIfNeeded];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self finishEdit];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchViewController searchWithKeyword:textField.text showToast:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *temp = textField.text;
    if (string.length == 0) {
        temp = [temp substringToIndex:textField.text.length - 1];
    } else {
        temp = [temp stringByReplacingCharactersInRange:range withString:string];
    }
    if (temp.length > 0) {
        [self.searchViewController searchWithKeyword:temp showToast:NO];
    }
    return YES;
}

#pragma mark - UZSearchViewController delegate
- (void)UZSearchViewController:(UZSearchViewController *)vc didSelected:(UZCommunity *)item
{
    [self finishEdit];
    
    [self.mapView removeAnnotations:self.dataSource];
    [self.dataSource removeAllObjects];
    UZMapAnnotation *ano = [self annotationWithCommunity:item];
    [self.mapView addAnnotation:ano];
    [self.mapView setCenterCoordinate:ano.coordinate];
}

#pragma mark - helper
- (void)finishEdit
{
    [self.textField resignFirstResponder];
    [self.searchViewController.view removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        self.rightConstraint.constant = 46;
        [self.titleView layoutIfNeeded];
    }];
}

#pragma mark - getter
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (UZMapAnnotation *)annotationWithCommunity:(UZCommunity *)item
{
    UZMapAnnotation *annotation = [[UZMapAnnotation alloc] init];
    annotation.title = [NSString stringWithFormat:@"%@ %d",item.comm_name,(int)item.room_num];
    annotation.item = item;
    annotation.coordinate = (CLLocationCoordinate2D){item.latitude,item.longitude};
    return annotation;
}

@end



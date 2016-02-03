//
//  UZRoomDetailViewController.m
//  UZuer
//
//  Created by CaydenK on 15/8/1.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZRoomDetailViewController.h"
#import "UZImageRevealView.h"
#import "UIView+AwakeNib.h"
#import <Masonry/Masonry.h>
#import "UZRoomConfigureView.h"
#import "UZRoomMapView.h"
#import "UZWebBridge.h"
#import "UZRecommendRoom.h"
#import "CKAlert.h"
#import "PageZoomViewController.h"
#import "UZScroll.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import "CKNormalAlert.h"
#import "UZLocationManager.h"
#import <MapKit/MapKit.h>
#import "UZAliPayManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <UMengSocial/UMSocial.h>
#import <UMengSocial/UMSocialWechatHandler.h>
#import <UMengSocial/UMSocialData.h>
#import "CKNormalAlert.h"
#import "UZFavorite.h"
#import "UZNotificationsMacro.h"

@interface UZRoomDetailViewController ()
<UZImageRevealViewDelegate,
UZRoomMapViewDelegate>
@property (strong, nonatomic) UZRecommendRoom *roomDetail;
@property (weak, nonatomic) IBOutlet UZScroll *scroll;
@property (weak, nonatomic) UZImageRevealView *imageRevealView;
@property (weak, nonatomic) UZRoomConfigureView *configureView;
@property (weak, nonatomic) UZRoomMapView *mapView;
@end

@implementation UZRoomDetailViewController
{
    BOOL haveWeChat;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.title = @"房源详情";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    haveWeChat=[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin:"]];
    if (haveWeChat) {
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:(UIButton *)({
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            [button setContentEdgeInsets:UIEdgeInsetsMake(11, 22, 11, 0)];
            [button setImage:[UIImage imageNamed:@"details_page_share"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(shareRoom) forControlEvents:UIControlEventTouchUpInside];
            button;
        })];
        self.navigationItem.rightBarButtonItem = rightBtn;
    }

    
    [self loadData];
}

#pragma mark - service
- (void)loadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UZWebBridge asyncPOSTGetRoomDetailWithRoomId:self.roomId success:^(id responseDict) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UZRecommendRoom *room = [[UZRecommendRoom alloc] initWithDictionary:responseDict];
        self.roomDetail = room;
        [self updateUI];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)loadAddToList
{
    if (UID > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [UZWebBridge asyncPOSTAddRoomToFavoriteListWithRoomId:[self.roomDetail.id integerValue] success:^(id responseDict) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            UZFavorite *favorite = [UZFavorite favoriteWithRecommendRoom:self.roomDetail];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [favorite replace];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCollectionSuccess object:nil];
                });
            });
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            UZFavorite *favorite = [UZFavorite favoriteWithRecommendRoom:self.roomDetail];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [favorite replace];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCollectionSuccess object:nil];
                });
            });
        }];
    } else {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
    }
}

- (void)shareRoom {
    CKNormalAlert *alert = [CKNormalAlert alertAtWindowWithTitle:nil content:@"分享到微信好友/朋友圈" sure:@"微信好友" cancel:@"朋友圈" callBack:^(CKAlertCallBackType type) {
        
        NSString *shareType = type==CKAlertCallBackTypeCancel?UMShareToWechatTimeline:UMShareToWechatSession;
        NSString *url = SHURL_ROOM_DETAIL(self.roomDetail.roomSeq);
        UIImage *image = [UIImage imageNamed:@"about_us_logo"];
        NSString *content = [NSString stringWithFormat:@"%@ %@",self.roomDetail.comm_name,self.roomDetail.kind];
        
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"U租房源分享";
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"U租房源分享";
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[shareType] content:content image:image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                [CKAlert showAlertWithMsg:@"分享成功"];
            }
            else if (response.responseCode==UMSResponseCodeCancel){
                //用户取消
                [CKAlert showAlertWithMsg:@"您取消了分享"];
            }
            else if (response.responseCode == UMSResponseCodeGetProfileFailed){
                //授权失败
                [CKAlert showAlertWithMsg:@"授权失败"];
            }
            else{
                [CKAlert showAlertWithMsg:@"分享失败！"];
            }
        }];
        
    }];
    [alert addGestureRecognizer:[UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [alert removeFromSuperview];
    }]];

}

#pragma mark - delegate
- (void)UZImageRevealViewPhotoClickAtIndex:(NSInteger)index
{
    PageZoomViewController * browerVC = [[PageZoomViewController alloc]init];
    NSArray *arrImgURLStr = [self.roomDetail.picture componentsSeparatedByString:@","];
    if (index > arrImgURLStr.count - 1) {
        index = 0;
    }
    browerVC.arrImgUrlStr = arrImgURLStr;
    browerVC.intStartIndex = index;
    [self presentViewController:browerVC animated:NO completion:nil];
}

- (void)navi
{
    CLLocationCoordinate2D location;
    location.longitude = self.roomDetail.longitude.doubleValue;
    location.latitude = self.roomDetail.latitude.doubleValue;
    [self navigationUserOtherMapWithCoor:location];
}

#pragma mark - action
//添加到中意清单
- (IBAction)addToList:(id)sender
{
    [self loadAddToList];
}

- (IBAction)callManager:(id)sender
{
    if (UID > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",self.roomDetail.hm_number]]];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
    }
    
}

//选择付款信息
- (IBAction)selectPayWay:(id)sender {
    [UZAliPayManager choosePayWayWithRoom:self.roomDetail currentVC:self];
}

#pragma mark - helper
- (void)updateUI
{
    [self configInterface];
    self.imageRevealView.room = self.roomDetail;
    self.configureView.room = self.roomDetail;
    self.mapView.room = self.roomDetail;
    
    [self.view layoutIfNeeded];
}

- (void)configInterface
{
    self.scroll.contentInset = UIEdgeInsetsMake(0, 0, 54, 0);
    UZImageRevealView *revealView = [UZImageRevealView uz_viewFromNib];
    revealView.delegate = self;
    self.imageRevealView = revealView;
    
    [self.scroll addSubview:revealView];
    [revealView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWith);
        make.height.mas_greaterThanOrEqualTo(100);
        make.top.left.right.mas_equalTo(0);
    }];
    
    UZRoomConfigureView *configureV = [UZRoomConfigureView uz_viewFromNib];
    self.configureView = configureV;
    [self.scroll addSubview:configureV];
    [configureV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(revealView.mas_bottom).with.offset(0);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWith);
        make.height.mas_greaterThanOrEqualTo(174);
    }];
    
    UZRoomMapView *mapV = [UZRoomMapView uz_viewFromNib];
    self.mapView = mapV;
    mapV.delegate = self;
    [self.scroll addSubview:mapV];
    [mapV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(configureV.mas_bottom).offset(0);
        make.width.mas_equalTo(ScreenWith);
        make.height.mas_greaterThanOrEqualTo(100);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

//使用第三方地图导航
- (void)navigationUserOtherMapWithCoor:(CLLocationCoordinate2D)coor
{
    CLLocationCoordinate2D startCoor = [UZLocationManager shareManager].bmkUserLocation.location.coordinate;
    CLLocationCoordinate2D endCoor = coor;
    //有百度地图调用百度地图
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]) {
        NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=transit",
                               startCoor.latitude, startCoor.longitude, endCoor.latitude, endCoor.longitude, self.roomDetail.room_name];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
    //如果没有，直接使用苹果自带的地图
    else {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
        toLocation.name = self.roomDetail.room_name;
        
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];

    }
}

@end

//
//  UZSearchDetailViewController.m
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZSearchDetailViewController.h"
#import "UZSearchDetailCell.h"
#import "UZSearchOrderView.h"
#import "UZSearchSiftView.h"
#import <Masonry.h>
#import "UZWebBridge.h"
#import "UZRecommendRoom.h"
#import "CKModel.h"
#import "UZFavorite.h"
#import "UZNotificationsMacro.h"
#import <MJRefresh.h>
#import "UZLocationManager.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import "UZRoomDetailViewController.h"
#import "UZAliPayManager.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define CONDITIONTAG -789966

typedef NS_ENUM(NSUInteger, UZConditionType) {
    UZConditionTypeNone = 0,
    UZConditionTypeSift,
    UZConditionTypeOrder,
};

@interface UZSearchDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UZSearchDetailCellDelegate>

@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UIButton *siftButton;
@property (assign, nonatomic) CLLocationCoordinate2D currCoor; //当前位置

/**
 *  排序方式
 */
@property (strong, nonatomic) NSDictionary *orderDict;
/**
 *  筛选方式
 */
@property (strong, nonatomic) NSDictionary *siftDict;
@property (assign, nonatomic) UZConditionType conditionType;

- (IBAction)orderButtonAction:(id)sender;
- (IBAction)siftButtonAction:(id)sender;

@end

@implementation UZSearchDetailViewController

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locateSuccess:) name:kCKLocationHeadingAndLocationUpdatedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locateFailed:) name:kCKLocationHeadingAndLocationUpdatedFailedNotification object:nil];
    [[UZLocationManager shareManager] startUserLocationService];
    self.needRefreshFooter = YES;
    self.needRefreshHeader = YES;
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"UZSearchDetailCell" bundle:nil] forCellReuseIdentifier:@"UZSearchDetailCell"];
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.title = self.searchTitle;
    [self loadDataWithNeedDeleteData:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCKLocationHeadingAndLocationUpdatedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCKLocationHeadingAndLocationUpdatedFailedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)locateSuccess:(NSNotification *)notification
{
    self.currCoor = [UZLocationManager shareManager].bmkUserLocation.location.coordinate;
}

- (void)locateFailed:(NSNotification *)notification
{
    
}

- (void)loadDataWithNeedDeleteData:(BOOL)ifNeed
{
    if (ifNeed) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [UZWebBridge asyncPOSTGetRoomListWithKeyWord:self.searchTitle curPage:self.curPage filter:self.siftDict sort:self.orderDict success:^(id responseDict) {
        
        self.curPage = [responseDict[@"curPage"] integerValue];
        self.totalPage = [responseDict[@"total"] integerValue];
        NSArray* rooms = [UZRecommendRoom modelsWithDictionarys:responseDict[@"data"]];
        if (ifNeed) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.dataSource removeAllObjects];
        }
        if (rooms.count == 0) {
            [CKAlert showAlertWithMsg:@"无符合条件结果"];
        }
        [self.dataSource addObjectsFromArray:rooms];
        
        [self.tableView reloadData];
        [self endRefresh];
    } failure:^(NSError *error) {
        if (ifNeed) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        [self endRefresh];
    }];
}

- (void)pullDownRefresh {
    [super pullDownRefresh];
    self.curPage = 0;
    [self loadDataWithNeedDeleteData:YES];
}

- (void)collectionWithItem:(UZRecommendRoom *)room
{
    [self.tableView setEditing:NO animated:YES];
    if (UID > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [UZWebBridge asyncPOSTAddRoomToFavoriteListWithRoomId:[room.id integerValue] success:^(id responseDict) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            UZFavorite *favorite = [UZFavorite favoriteWithRecommendRoom:room];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [favorite replace];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCollectionSuccess object:nil];
            });
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            UZFavorite *favorite = [UZFavorite favoriteWithRecommendRoom:room];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [favorite replace];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCollectionSuccess object:nil];
            });
        }];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
    }
}

- (void)pullUpRefresh
{
    [super pullUpRefresh];
    self.curPage += 1;
    [self loadDataWithNeedDeleteData:NO];
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UZRecommendRoom *room = self.dataSource[indexPath.row];
    UZSearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UZSearchDetailCell"];
    cell.delegate = self;
    if (self.currCoor.latitude != 0 && self.currCoor.longitude && [room.longitude floatValue] != 0 && [room.latitude floatValue] != 0) {
        BMKMapPoint mp1 = BMKMapPointForCoordinate(self.currCoor);
        BMKMapPoint mp2 = BMKMapPointForCoordinate((CLLocationCoordinate2D){[room.latitude doubleValue],[room.longitude doubleValue]});
        CLLocationDistance distance = BMKMetersBetweenMapPoints(mp1,mp2);
        room.distance = distance;
    }
    cell.room = room;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UZRecommendRoom *room = self.dataSource[indexPath.row];
    UZRoomDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UZRoomDetailViewController"];
    vc.roomId = [room.id integerValue];
    [self.navigationController pushViewController:vc animated:YES];
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//
////iOS7 入口
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //ios7 入口
//        UZRecommendRoom *room = self.dataSource[indexPath.row];
//        [self collectionWithItem:room];
//    }
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"收藏";
//}
//
////iOS8 入口
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        UZRecommendRoom *room = self.dataSource[indexPath.row];
//        [self collectionWithItem:room];
//    }];
//    action.backgroundColor = UIColorFromRGB(BaseColor);
//    return @[action];
//}

#pragma mark - cell delegate
- (void)uzSearchDetailCellCollection:(UZSearchDetailCell *)cell
{
    [self collectionWithItem:cell.room];
}

- (void)uzSearchDetailCellPay:(UZSearchDetailCell *)cell
{
    [UZAliPayManager choosePayWayWithRoom:cell.room currentVC:self];
}

#pragma mark - action
- (IBAction)orderButtonAction:(id)sender {
    if (self.conditionType == UZConditionTypeOrder) {
        return;
    }
    UIView *conditionView = [self.view viewWithTag:CONDITIONTAG];
    [conditionView removeFromSuperview];

    __weak typeof(self) weakSelf = self;
    UZSearchOrderView *orderView = [UZSearchOrderView searchOrderViewWithCurrentCondition:self.orderButton.titleLabel.text collback:^(NSString *orderCondition) {
        weakSelf.conditionType = UZConditionTypeNone;
        
        if (orderCondition && orderCondition.length > 0) {
            [weakSelf.orderButton setTitle:orderCondition forState:UIControlStateNormal];
            if ([orderCondition isEqualToString:@"推荐排序"]) {
                weakSelf.orderDict = @{};
            }
            else if ([orderCondition isEqualToString:@"最新房源"]) {
                weakSelf.orderDict = @{@"createtime":@0};
            }
            else if ([orderCondition isEqualToString:@"距离从近到远"]) {
                weakSelf.orderDict = @{@"distance":@1};
            }
            else if ([orderCondition isEqualToString:@"租金从低到高"]) {
                weakSelf.orderDict = @{@"price":@1};
            }
            else if ([orderCondition isEqualToString:@"租金从高到低"]) {
                weakSelf.orderDict = @{@"price":@0};
            }
            else if ([orderCondition isEqualToString:@"面积从大到小"]) {
                weakSelf.orderDict = @{@"createtime":@0};
            }
            [weakSelf loadDataWithNeedDeleteData:YES];
        }
    }];
    orderView.tag = CONDITIONTAG;
    [self.view addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.orderButton.superview.mas_bottom);
    }];
}

- (IBAction)siftButtonAction:(id)sender {
    if (self.conditionType == UZConditionTypeSift) {
        return;
    }
    UIView *conditionView = [self.view viewWithTag:CONDITIONTAG];
    [conditionView removeFromSuperview];
    
    __weak typeof(self) weakSelf = self;
    UZSearchSiftView *siftView = [UZSearchSiftView  searchSiftViewWithSiftDict:self.siftDict conditionCompletion:^(NSDictionary *dict) {
        weakSelf.siftDict = dict;
        [weakSelf loadDataWithNeedDeleteData:YES];
    }];
    siftView.tag = CONDITIONTAG;
    [self.view addSubview:siftView];
    
    [siftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.siftButton.superview.mas_bottom);
    }];
}

#pragma mark - 
#pragma mark - set
- (void)setSiftDict:(NSDictionary *)siftDict {
    _siftDict = siftDict;
    self.curPage = 0;
}
- (void)setOrderDict:(NSDictionary *)orderDict {
    _orderDict = orderDict;
    self.curPage = 0;
}


@end

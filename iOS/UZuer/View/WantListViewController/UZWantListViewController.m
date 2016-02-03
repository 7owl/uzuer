//
//  UZWantListViewController.m
//  UZuer
//
//  Created by CaydenK on 15/8/7.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZWantListViewController.h"
#import "UZWantListCell.h"
#import "UIView+AwakeNib.h"
#import "UZWantListEmptyView.h"
#import <Masonry/Masonry.h>
#import "UZFavorite.h"
#import "CKFMDBHelper.h"
#import "UZNotificationsMacro.h"
#import "UZRoomDetailViewController.h"
#import "UZAliPayManager.h"

@interface UZWantListViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UZWantListCellDelegate
>
@property(nonatomic,strong) NSMutableArray *dataSource; //数据源
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation UZWantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:kNotificationCollectionSuccess object:nil];
    
    self.navigationItem.title =  @"中意清单";
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)refreshData
{
    NSArray *list = [UZFavorite queryWithConditions:^id(CKConditionMaker *maker) {
        return maker.orderBy(@"createTime",CKOrderByDesc);
    }];
    self.dataSource = list.mutableCopy;
    [self.tableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEmptyViewHidden:(BOOL)hidden
{
    NSInteger tagEmpty = 1001;
    UZWantListEmptyView *emptyView = (UZWantListEmptyView *)[self.view viewWithTag:tagEmpty];
    if (hidden) {
        [emptyView removeFromSuperview];
    } else {
        if (!emptyView) {
            emptyView = [UZWantListEmptyView uz_viewFromNib];
            emptyView.tag = tagEmpty;
            emptyView.SearchRoomClick = ^(id sender){
                self.tabBarController.selectedIndex = 0;
            };
            [self.view addSubview:emptyView];
            [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
        }
    }
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BOOL hidden = self.dataSource.count == 0 ? NO:YES;
    [self setEmptyViewHidden:hidden];
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UZFavorite *item = self.dataSource[indexPath.row];
    UZWantListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WantListCell" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.delegate = self;
    cell.favorite = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UZFavorite *room = self.dataSource[indexPath.row];
    
    UZRoomDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UZRoomDetailViewController"];
    vc.roomId = [room.id integerValue];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//iOS7 入口
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //ios7 入口
        UZFavorite *room = self.dataSource[indexPath.row];
        [self deleteWithRoom:room withIndex:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//iOS8 入口
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        UZFavorite *room = self.dataSource[indexPath.row];
        [self deleteWithRoom:room withIndex:indexPath];
    }];
    action.backgroundColor = UIColorFromRGB(BaseColor);
    return @[action];
}

#pragma mark - cell delegate
- (void)UZWantListCellPay:(UZWantListCell *)cell
{
    UZRecommendRoom *room = [[UZRecommendRoom alloc] init];
    room.id = cell.favorite.id;
    room.price = cell.favorite.price;
    [UZAliPayManager choosePayWayWithRoom:room currentVC:self];
}

#pragma mark - delete item
- (void)deleteWithRoom:(UZFavorite *)room withIndex:(NSIndexPath *)indexPath
{
    [UZFavorite deleteWithConditions:^id(CKConditionMaker *maker) {
        return maker.where([NSString stringWithFormat:@"id == %ld",[room.id integerValue]]);
    }];
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end

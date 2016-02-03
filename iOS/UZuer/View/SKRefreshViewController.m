//
//  SKRefreshViewController.m
//  ShenKHealthy
//
//  Created by xiaofeishen on 15/7/6.
//  Copyright (c) 2015年 shenxiaofei. All rights reserved.
//

#import "SKRefreshViewController.h"
#import <Masonry/Masonry.h>

@interface SKRefreshViewController ()
@property(nonatomic,assign) RefreshType refreshType; //刷新类型
@end

@implementation SKRefreshViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self ConfigData];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self ConfigData];
    }
    return self;
}

- (void)ConfigData
{
    self.curPage = kStartPageIndex;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self configMJRefresh];
}

#pragma mark - MJConfigerProtocol 
- (void)pullDownRefresh{
    self.refreshType = RefreshTypeHeader;
}
- (void)pullUpRefresh{
    self.refreshType = RefreshTypeFooter;
}

#pragma mark - publick method
- (void)endRefresh
{
    if (self.refreshType == RefreshTypeHeader) {
        if (self.tableView.header.state != MJRefreshStateNoMoreData) {
            [self.tableView.header endRefreshing];
        }
    } else {
        //上拉结束
        if (self.tableView.footer.state != MJRefreshStateNoMoreData) {
            [self.tableView.footer endRefreshing];
        }
    } 
}

#pragma mark - private method
- (void)configMJRefresh
{
    if (self.needRefreshHeader) {
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    }
    
    if (self.needRefreshFooter) {
        self.tableView.footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpRefresh)];
    }
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

@end

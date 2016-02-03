//
//  UZSearchViewController.m
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZSearchViewController.h"
#import <Masonry/Masonry.h>
#import "UZWebBridge.h"
#import "UZCommunity.h"
#import "MBProgressHUD.h"

@interface UZSearchViewController ()
<UITableViewDataSource,
UITableViewDelegate>
{
    BOOL _historyListHidden; //yes 历史搜索列表被隐藏 默认no
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UIView *footerCleanView;
@end

@implementation UZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    if (self.searchMode == SearchModeHasHistory) {
        self.dataSource = self.searchHistoryHelper.searchHistory.mutableCopy;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - service
- (void)searchFeaturedListWithKeyword:(NSString *)aKeyword showToast:(BOOL)showToast
{
    if (showToast) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [UZWebBridge asyncPOSTgetFeaturedListWithKeyWord:aKeyword success:^(NSArray *responseArray) {
        [self.dataSource removeAllObjects];
        if (showToast) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (responseArray.count == 0) {
                [CKAlert showAlertWithMsg:@"没有结果"];
            }
        }
        for (UZCommunity *comm in responseArray) {
            [self.dataSource addObject:comm];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if (showToast) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

#pragma mark - action
- (void)cleanHistory:(id)sender
{
    [self.searchHistoryHelper clean];
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UZCommunity *item = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = item.comm_name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(UZSearchViewController:didSelected:)]) {
        UZCommunity *item = self.dataSource[indexPath.row];
        [self.searchHistoryHelper addNewSearchItem:item];
        [self.delegate UZSearchViewController:self didSelected:item];
    }
}

#pragma mark - plublic method
- (void)setHistoryListHidden:(BOOL)hidden
{
    if (!hidden) {
        if (_historyListHidden) {
            _historyListHidden = NO;
            //显示历史搜索列表
            self.dataSource = self.searchHistoryHelper.searchHistory.mutableCopy;
            if (self.dataSource.count > 0) {
                self.tableView.tableFooterView = self.footerCleanView;
            } else {
                self.tableView.tableFooterView = nil;
            }
            self.tableView.tableFooterView = nil;
            [self.tableView reloadData];
        }
    } else {
        if (!_historyListHidden) {
            _historyListHidden = YES;
            [self.dataSource removeAllObjects];
            self.tableView.tableFooterView = nil;
            [self.tableView reloadData];
        }
    }
}

- (void)searchWithKeyword:(NSString *)aKeyword showToast:(BOOL)showToast
{
    if (!aKeyword) {
        return;
    }
    [self searchFeaturedListWithKeyword:aKeyword showToast:showToast];
}

#pragma mark - getter & setter
- (UZSearchHistoryHelper *)searchHistoryHelper
{
    if (_searchHistoryHelper == nil) {
        _searchHistoryHelper = [[UZSearchHistoryHelper alloc] init];
    }
    return _searchHistoryHelper;
}

- (UIView *)footerCleanView
{
    if (_footerCleanView == nil) {
        _footerCleanView = [[UIView alloc] initWithFrame:(CGRect){0,0,ScreenWith,40}];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_footerCleanView addSubview:button];
        [button addTarget:self action:@selector(cleanHistory:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [button setTitleColor:UIColorFromRGB(BaseColor) forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _footerCleanView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end

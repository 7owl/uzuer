//
//  UZContractViewController.m
//  UZuer
//
//  Created by CaydenK on 15/9/13.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZContractViewController.h"
#import "UZContractViewControllerCell.h"
#import "UZWebBridge.h"
#import "UZContract.h"
#import "UZContractDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface UZContractViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation UZContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    [self loadData];
}

- (void)loadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UZWebBridge asyncPOSTContractByTenantIdSuccess:^(id responseDict) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *list = responseDict[@"data"];
        if (list.count > 0) {
            self.dataSource = [UZContract modelsWithDictionarys:list];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UZContract *item = self.dataSource[indexPath.row];
    UZContractViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UZContractViewControllerCell" forIndexPath:indexPath];
    cell.contract = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UZContract *item = self.dataSource[indexPath.row];
    if (item.completedState == ContractStatusInValid) {
        [CKAlert showAlertWithMsg:@"该合同已经失效"];
    } else {
        [self performSegueWithIdentifier:@"toDetail" sender:item];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetail"]) {
        UZContractDetailViewController *vc = segue.destinationViewController;
        vc.contract = sender;
    }
}

@end

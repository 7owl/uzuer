//
//  UZContractDetailViewController.m
//  UZuer
//
//  Created by CaydenK on 15/9/14.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZContractDetailViewController.h"
#import "UZContractDetailImageCell.h"
#import "UZContractDetailItemCell.h"
#import "UZWebBridge.h"
#import "UZContract.h"
#import "UZOrder.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UZContractPreviewViewController.h"
#import "UZAliPayManager.h"

@interface UZContractDetailViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@end

@implementation UZContractDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"合同详情";
    
    if (self.dataSource.count == 0 || self.contractUrl == nil) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self loadlist];
        [self loadContractUrl];
    }
}

/**
 *  获取订单列表
 */
- (void)loadlist
{
    [UZWebBridge asyncPOSTOrderlistByContractId:self.contract.id Success:^(id responseDict) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *list = responseDict[@"data"];
        self.dataSource = [UZOrder modelsWithDictionarys:list];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

/**
 *  获取合同预览地址
 */
- (void)loadContractUrl
{
    [UZWebBridge asyncPOSTPreviewContractWithContractNo:self.contract.contractno success:^(id responseDict) {
        NSString *urltemp = responseDict[@"url"];
        if ([urltemp isKindOfClass:[NSString class]]) {
            self.contractUrl =  [NSURL URLWithString:urltemp];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return self.dataSource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 241;
    }
    return 69;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UZContractDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContractDetailImage" forIndexPath:indexPath];
        if (!cell.hasLoaded && self.contractUrl != nil) {
            cell.hasLoaded = YES;
            [cell.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.contractUrl]];
            [cell.blowupButton addTarget:self action:@selector(blowupButton:) forControlEvents:UIControlEventTouchUpInside];
            cell.blowupButton.hidden = NO;
        }
        return cell;
    }
    else {
        UZOrder *order = self.dataSource[indexPath.row];
        UZContractDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContractDetailItem" forIndexPath:indexPath];
        cell.titleLabel.text = [NSString stringWithFormat:@"订单%d",(int)indexPath.row+1];
        if (indexPath.row == 0) {
            cell.infoLabel.text = [NSString stringWithFormat:@"%@ 押金%@元",order.order_rental_starttime,order.amount];
        } else {
            cell.infoLabel.text = [NSString stringWithFormat:@"%@ %@元",order.order_rental_starttime,order.amount];
        }
        
        cell.payButton.hidden = order.paystate == PayStatusPayed ? YES : NO;
        if (!cell.payButton.hidden) {
            //可支付状态
            [cell.payButton addTarget:self action:@selector(payButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.indexPath = indexPath;
        return cell;
    }
}

#pragma mark - action
//查看合同预览
- (void)blowupButton:(id)sender
{
    if (self.contractUrl == nil || ![self.contractUrl isKindOfClass:[NSURL class]]) {
        [CKAlert showAlertWithMsg:@"合同预览地址还未请求或不存在"];
        return;
    }
    UZContractPreviewViewController *vc = [[UZContractPreviewViewController alloc] init];
    vc.contractUrl = self.contractUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)payButton:(UIButton *)sender
{
    UZContractDetailItemCell *cell = (UZContractDetailItemCell *)sender.superview.superview;
    UZOrder *order = self.dataSource[cell.indexPath.row];
    
    if (order.orderno == nil || [order.orderno isEqualToString:@""]) {
        [CKAlert showAlertWithMsg:@"订单数据异常"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) wself = self;
    
    //生成product 对象
    Product *product = [[Product alloc] init];
    product.price = [order.amount floatValue];
    product.subject = [NSString stringWithFormat:@"租房订单-%@",order.orderno];
    product.body = [NSString stringWithFormat:@"租房订单-%@",order.orderno];
    
    [UZAliPayManager payOrderWithProduct:product tradeNO:order.orderno completionBlock:^(NSDictionary *resultDic) {
        [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];
        //支付宝成功回调
        NSInteger statuts = [resultDic[@"resultStatus"] integerValue];
        BOOL isSuccess = [UZAliPayManager isSuccessWithStatus:statuts];
        if (isSuccess) {
            //更新订单状态
            order.paystate = PayStatusPayed;
            [wself.tableView reloadData];
            //更新合同状态
            if (self.contract) {
                self.contract.status = ContractStatusEffecting;
            }
        }
    }];
}


@end

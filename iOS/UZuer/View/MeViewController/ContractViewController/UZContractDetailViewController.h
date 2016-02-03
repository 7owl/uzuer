//
//  UZContractDetailViewController.h
//  UZuer
//
//  Created by CaydenK on 15/9/14.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UZContract;
@interface UZContractDetailViewController : UITableViewController

/**
 *  数据源（可选）
 */
@property (strong, nonatomic) NSArray *dataSource;
/**
 *  合同网络地址（可选）
 */
@property (strong, nonatomic) NSURL *contractUrl;

/**
 *  从合同列表进入需要赋值（可选）
 */
@property (weak, nonatomic) UZContract *contract;

@end

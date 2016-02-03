//
//  UZContractDetailItemCell.h
//  UZuer
//
//  Created by CaydenK on 15/9/13.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UZContractDetailItemCell : UITableViewCell

/**
 *  订单名称
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  详细信息
 */
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
/**
 *  是否支付状态
 */
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
/**
 *  支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *payButton;

/**
 *  当前cell的indexPath
 */
@property (strong, nonatomic) NSIndexPath *indexPath;

@end

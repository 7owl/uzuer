//
//  UZContractViewControllerCell.m
//  UZuer
//
//  Created by CaydenK on 15/9/13.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZContractViewControllerCell.h"
#import "UZContract.h"

@interface UZContractViewControllerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic, weak) IBOutlet UILabel *contractNoLb;
@property (nonatomic, weak) IBOutlet UILabel *commNameLb;
@property (nonatomic, weak) IBOutlet UILabel *kindLb;
@property (nonatomic, weak) IBOutlet UILabel *dateLb;
@property (nonatomic, weak) IBOutlet UILabel *statusLb;

@end

@implementation UZContractViewControllerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContract:(UZContract *)contract {
    if (_contract != contract) {
        _contract = contract;
        self.contractNoLb.text = _contract.contractno;
        self.commNameLb.text = _contract.comm_name;
        self.kindLb.text = _contract.kind;
        
        switch (_contract.completedState) {
            case ContractStatusInValid:
                self.statusLb.text = @"已失效";
                break;
            case ContractStatusUnEffect:
                self.statusLb.text = @"未生效";
                
                break;
            case ContractStatusEffecting:
                self.statusLb.text = @"生效中";
                break;
            case ContractStatusExpire:
                self.statusLb.text = @"已过期";
                break;
            default:
                break;
        }
        
        if (_contract.completedState == ContractStatusInValid || _contract.completedState == ContractStatusExpire) {
            //合同不能使用
            self.kindLb.textColor = self.commNameLb.textColor = self.contractNoLb.textColor = [UIColor lightGrayColor];
            self.imageV.image = [UIImage imageNamed:@"contract_complete_not_effective"];
        } else {
            self.kindLb.textColor = self.commNameLb.textColor = self.contractNoLb.textColor = UIColorFromRGB(0x222222);
            self.imageV.image = [UIImage imageNamed:@"contract_ongoing"];
        }
        
        NSDateFormatter *formatterToDate = [[NSDateFormatter alloc] init];
        formatterToDate.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        NSDate *signDate = [formatterToDate dateFromString:_contract.sign_time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY年M月d日";
        NSString *dateString = [formatter stringFromDate:signDate];
        self.dateLb.text = dateString;
    }
}

@end

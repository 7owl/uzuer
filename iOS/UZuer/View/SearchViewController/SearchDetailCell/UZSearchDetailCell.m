//
//  UZSearchDetailCell.m
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZSearchDetailCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UZRecommendRoom.h"

@interface UZSearchDetailCell ()
/**
 *  房源缩略图
 */
@property (nonatomic, weak) IBOutlet UIImageView *roomThumbImageView;
/**
 *  小区名称
 */
@property (nonatomic, weak) IBOutlet UILabel *roomAreaLabel;
/**
 *  房源配置（如：1室1厅1卫）
 */
@property (nonatomic, weak) IBOutlet UILabel *roomConfigLabel;
/**
 *  房源摘要信息
 */
@property (nonatomic, weak) IBOutlet UILabel *roomSummaryInfoLabel;
/**
 *  价格
 */
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
/**
 *  距离
 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
/**
 *  icon
 */
@property (weak, nonatomic) IBOutlet UIImageView *locateIcon;
/**
 *  是否支持智能锁
 */
@property (weak, nonatomic) IBOutlet UIView *smartlockView;

@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end

@implementation UZSearchDetailCell

- (void)setRoom:(UZRecommendRoom *)room
{
    if (_room != room) {
        _room = room;
        NSArray *images = [room.picture componentsSeparatedByString:@","];
        if (images.count > 0) {
            [self.roomThumbImageView sd_setImageWithURL:images.firstObject placeholderImage:[UIImage imageNamed:@"placeholder_picture"]];
        }
        self.priceLabel.text = @(room.price).stringValue;
        self.roomAreaLabel.text = room.comm_name;
        self.roomConfigLabel.text = room.kind;
        self.roomSummaryInfoLabel.text = [NSString stringWithFormat:@"%@·%@·%@平米",room.busiCircle,room.rent_type,room.size];
        if (room.distance > 0) {
            self.locateIcon.hidden = NO;
            self.distanceLabel.hidden = NO;
            self.distanceLabel.text = [NSString stringWithFormat:@"距您%.1f公里",room.distance/1000.f];
        } else {
            self.locateIcon.hidden = YES;
            self.distanceLabel.hidden = YES;
        }
        
        self.smartlockView.hidden = !room.smartlock;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if (ScreenWith >= 375) {
        [self.collectionButton setTitle:@"加入收藏" forState:UIControlStateNormal];
        [self.payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pay:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(uzSearchDetailCellPay:)]) {
        [self.delegate uzSearchDetailCellPay:self];
    }
}

- (IBAction)collection:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(uzSearchDetailCellCollection:)]) {
        [self.delegate uzSearchDetailCellCollection:self];
    }
}

@end

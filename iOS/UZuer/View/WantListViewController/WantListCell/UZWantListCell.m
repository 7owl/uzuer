//
//  UZWantListCell.m
//  UZuer
//
//  Created by CaydenK on 15/8/7.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZWantListCell.h"
#import "UIColor+UZExtend.h"
#import "UZFavorite.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UZWantListCell ()

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
@property (nonatomic, weak) IBOutlet UILabel *roomConfig;
/**
 *  房源摘要信息
 */
@property (nonatomic, weak) IBOutlet UILabel *roomSummaryInfoLabel;
/**
 *  价格
 */
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
/**
 *  联系管家按钮
 */
@property (nonatomic, weak) IBOutlet UIButton *callStewardButton;
/**
 *  支付按钮
 */
@property (nonatomic, weak) IBOutlet UIButton *payButton;

/**
 *  是否支持智能锁
 */
@property (weak, nonatomic) IBOutlet UIView *smartlockView;

/**
 *  联系管家按钮事件
 *
 *  @param sender
 */
- (IBAction)callStewardButtonAction:(id)sender;

@end

@implementation UZWantListCell

- (void)awakeFromNib {
    [self.callStewardButton setBackgroundImage:[[UIColorFromRGB(0xfb8424) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateNormal];
    [self.callStewardButton setBackgroundImage:[[UIColorFromRGB(0xd7d7d7) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateHighlighted];
    [self.callStewardButton setBackgroundImage:[[UIColorFromRGB(0xd7d7d7) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateDisabled];
    if (ScreenWith >= 375) {
        [self.callStewardButton setTitle:@"联系管家" forState:UIControlStateNormal];
        [self.payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  联系管家按钮事件
 *
 *  @param sender
 */
- (IBAction)callStewardButtonAction:(id)sender {
   if (UID > 0) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",self.favorite.hm_number]]];
   } else {
       [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
   }
}

- (IBAction)pay:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(UZWantListCellPay:)]) {
        [self.delegate UZWantListCellPay:self];
    }
}

- (void)setFavorite:(UZFavorite *)favorite
{
    if (_favorite != favorite) {
        _favorite = favorite;
        NSArray *images = [_favorite.picture componentsSeparatedByString:@","];
        if (images.count > 0) {
            [self.roomThumbImageView sd_setImageWithURL:images.firstObject placeholderImage:[UIImage imageNamed:@"placeholder_picture"]];
        }
        self.priceLabel.text = @(_favorite.price).stringValue;
        self.roomAreaLabel.text = _favorite.comm_name;
        self.roomConfig.text = _favorite.kind;
        self.roomSummaryInfoLabel.text = [NSString stringWithFormat:@"%@·%@·%@平米",_favorite.busiCircle,_favorite.rent_type,_favorite.size];
        self.smartlockView.hidden = !favorite.smartlock;

    }
}

@end

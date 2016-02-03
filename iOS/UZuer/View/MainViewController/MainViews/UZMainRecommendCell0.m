//
//  UZMainRecommendCell.m
//  UZuer
//
//  Created by CaydenK on 15/7/31.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZMainRecommendCell0.h"
#import "UZRecommendRoom.h"
#import <UIImageView+WebCache.h>

@interface UZMainRecommendCell0 ()

/**
 *  背景区
 */
@property (nonatomic, weak) IBOutlet UIView *backgroundLineView;
/**
 *  图片
 */
@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
/**
 *  价格Label
 */
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
/**
 *  信息Label
 */
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
/**
 *  标签Button
 */
@property (nonatomic, weak) IBOutlet UIButton *tagButton0;
@property (nonatomic, weak) IBOutlet UIButton *tagButton1;
@property (nonatomic, weak) IBOutlet UIButton *tagButton2;




@end

@implementation UZMainRecommendCell0

- (void)awakeFromNib {
    self.backgroundLineView.layer.borderWidth = 1.0/[UIScreen mainScreen].scale;
    self.backgroundLineView.layer.borderColor = UIColorFromRGB(0xcdcdcd).CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setRoom:(UZRecommendRoom *)room {
    _room = room;
    [self bindDataSource];
}
- (void)bindDataSource {
    self.tagButton0.hidden = YES;
    self.tagButton1.hidden = YES;
    self.tagButton2.hidden = YES;
    
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:[self.room.picture componentsSeparatedByString:@","].firstObject] placeholderImage:[UIImage imageNamed:@"placeholder_picture"]];
    self.priceLabel.text = @(self.room.price).stringValue;
    if ([self.room.recommend length] > 0) {
        self.infoLabel.text = self.room.recommend;
    }
    else {
        self.infoLabel.text = [NSString stringWithFormat:@"%@ %@ %@",self.room.address,self.room.comm_name,self.room.kind];
    }
    NSArray *recommendTargetArray = [self.room.recommendTarget componentsSeparatedByString:@","];
    [recommendTargetArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = nil;
        if (idx == 0) {
            btn = self.tagButton0;
        }
        else if (idx == 1) {
            btn = self.tagButton1;
        }
        else if (idx == 2) {
            btn = self.tagButton2;
        }
        btn.hidden = NO;
        [btn setTitle:obj forState:UIControlStateNormal];
    }];
}


@end

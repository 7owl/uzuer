//
//  UZMainMapSectionHeaderView.m
//  UZuer
//
//  Created by CaydenK on 15/7/31.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZMainMapSectionHeaderView.h"
#import <Masonry.h>

@implementation UZMainMapSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier callBack:(void(^)(void))block
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *leftV = [self componentViewWithImage:[UIImage imageNamed:@"home_page_map_search"] title:@"地图搜房"];
        UIView *rightV = [self componentViewWithImage:[UIImage imageNamed:@"home_page_landlord"] title:@"我是房东"];
        [self.contentView addSubview:leftV];
        [self.contentView addSubview:rightV];
        UIView *lineV = [[UIView alloc] init];
        lineV.backgroundColor = [UIColor colorWithRGB:0xf5f5f5];
        [self.contentView addSubview:lineV];
        [leftV mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.top.bottom.mas_equalTo(0);
        }];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1/[UIScreen mainScreen].scale);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.left.equalTo(leftV.mas_right).offset(0);
        }];
        [rightV mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(leftV.mas_right).offset(0);
            make.width.equalTo(leftV.mas_width).offset(0);
            make.top.bottom.right.mas_equalTo(0);
        }];
        
        //action
        [leftV addGestureRecognizer:[[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            !block?:block();
        }]];
        
        [rightV addGestureRecognizer:[[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            [[UIApplication sharedApplication] openURL:COMPANY_SERVE_TEL];
        }]];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
} 

#pragma mark - Get
- (UIView *)componentViewWithImage:(UIImage *)image title:(NSString *)title
{
    UIView *containerView = [[UIView alloc] init];
    UIView *contentView= [[UIView alloc] init];
    [containerView addSubview:contentView];
    UIImageView *iconImageV = [self iconImageViewWithImage:image];
    [contentView addSubview:iconImageV];
    UILabel *label = [self titleLabel:title];
    [contentView addSubview:label];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(10);
        make.top.right.bottom.mas_equalTo(0);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(97, 22));
        make.center.mas_equalTo(CGPointMake(0, 0));
    }];
    return containerView;
}

- (UIImageView *)iconImageViewWithImage:(UIImage *) image {
    return [[UIImageView alloc] initWithImage:image];
}

- (UILabel *)titleLabel:(NSString *)title {
     UILabel *label = [UILabel new];
    label.text = title;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithRGB:0x222222];
    label.backgroundColor = [UIColor clearColor];
    return label;
}



@end

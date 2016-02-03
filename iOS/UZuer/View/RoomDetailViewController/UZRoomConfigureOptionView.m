//
//  UZRoonConfigureOptionView.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/4.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZRoomConfigureOptionView.h"
#import <Masonry/Masonry.h>

@interface UZRoomConfigureOptionView ()
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIView *centerLineV;
@property(nonatomic,strong) UIView *contentV;
@end
@implementation UZRoomConfigureOptionView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.contentV];
    [self.contentV addSubview:self.imageV];
    [self.contentV addSubview:self.titleLabel];
    [self addSubview:self.centerLineV];
    self.centerLineV.hidden = NO;
    
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(77, 23));
        make.center.mas_equalTo(CGPointMake(0, 0));
    }];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.left.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).with.offset(5);
        make.top.bottom.right.mas_equalTo(0);
    }];
    [self.centerLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(80);
        make.center.mas_equalTo(CGPointMake(0, 0));
    }];
}

#pragma mark - getter & setter
- (void)setUnSelImage:(NSString *)unSelImage
{
    if (_unSelImage != unSelImage) {
        _unSelImage = unSelImage;
        self.imageV.image = [UIImage imageNamed:unSelImage];
    }
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (UIImageView *)imageV
{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
}

- (UIView *)centerLineV
{
    if (_centerLineV == nil) {
        _centerLineV = [[UIView alloc] init];
        _centerLineV.backgroundColor = [UIColor lightGrayColor];
    }
    return _centerLineV;
}

- (UIView *)contentV
{
    if (_contentV == nil) {
        _contentV = [[UIView alloc] init];
    }
    return _contentV;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
        if (_selected) {
            self.imageV.image = [UIImage imageNamed:self.selImage];
            self.titleLabel.textColor = UIColorFromRGB(0x222222);
            self.centerLineV.hidden = YES;
        } else {
            self.imageV.image = [UIImage imageNamed:self.unSelImage];
            self.titleLabel.textColor = [UIColor lightGrayColor];
            self.centerLineV.hidden = NO;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

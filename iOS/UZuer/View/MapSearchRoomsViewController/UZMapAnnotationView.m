//
//  UZMapAnnotationView.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/25.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZMapAnnotationView.h"
#import <Masonry/Masonry.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>

@interface UZMapAnnotationView ()
@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) UIImageView *leftImageBgV;
@property(strong, nonatomic) UIImageView *rightImageBgV;
@end
@implementation UZMapAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.centerOffset = CGPointMake(0, -24);
        
        self.leftImageBgV = [[UIImageView alloc] init];
        self.leftImageBgV.image = [UIImage imageNamed:@"map_page_paopao_left"];
        [self addSubview:self.leftImageBgV];
        self.rightImageBgV = [[UIImageView alloc] init];
        self.rightImageBgV.image = [UIImage imageNamed:@"map_page_paopao_right"];;
        [self addSubview:self.rightImageBgV];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:self.titleLabel];
        
        [self makeContraints];
    }
    return self;
}

- (void)setAnnotation:(id<BMKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    self.titleLabel.text = annotation.title;
    
    CGSize size = [self.titleLabel.text boundingRectWithSize:(CGSize){MAXFLOAT,20.f} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    [self setBounds:CGRectMake(0.f, 0.f, size.width + 30.f, 40.f)];
    [self layoutIfNeeded];
}

- (void)makeContraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 8, 0));
    }];
    [self.leftImageBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
    }];
    [self.rightImageBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.left.equalTo(self.leftImageBgV.mas_right).offset(0);
        make.width.equalTo(self.leftImageBgV.mas_width).offset(0);
    }];
}



@end

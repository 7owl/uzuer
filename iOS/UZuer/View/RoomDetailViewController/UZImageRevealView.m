//
//  UZImageRevealView.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/2.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZImageRevealView.h"
#import "UZRecommendRoom.h"
#import "UIImageView+WebCache.h"

@interface UZImageRevealView ()
<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (assign,nonatomic) NSInteger totalPhotos;

@property (weak, nonatomic) IBOutlet UILabel *commNameAndkindLb; //公寓 和 1室0厅1卫
@property (weak, nonatomic) IBOutlet UILabel *rentalTimeLb; //入住时间
@property (weak, nonatomic) IBOutlet UILabel *busiCircleLb; //商圈
@property (weak, nonatomic) IBOutlet UILabel *rentTypeLb; //类型 ，例如整租
@property (weak, nonatomic) IBOutlet UILabel *floorLb; //楼层
@property (weak, nonatomic) IBOutlet UILabel *sizeLb; //面积
@property (weak, nonatomic) IBOutlet UILabel *orientLb; //朝向
@property (weak, nonatomic) IBOutlet UILabel *priceLb;

//标签
@property (weak, nonatomic) IBOutlet UIButton *tag0Btn;
@property (weak, nonatomic) IBOutlet UIButton *tag1Btn;
@property (weak, nonatomic) IBOutlet UIButton *tag2Btn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smartLockWidthConstraint;

@end
@implementation UZImageRevealView

- (void)setRoom:(UZRecommendRoom *)room
{
    if (_room != room) {
        _room = room;
        [self updateUI];
    }
}

- (void)updateUI
{
    self.commNameAndkindLb.text = [NSString stringWithFormat:@"%@ %@",_room.comm_name,_room.kind];
    if ([_room.rental_end_time isEqualToString:@""] || _room.rental_end_time == nil) {
        self.rentalTimeLb.text = [NSString stringWithFormat:@"%@",_room.rental_start_time];
    } else {
        self.rentalTimeLb.text = [NSString stringWithFormat:@"%@ 至 %@",_room.rental_start_time,_room.rental_end_time];
    }
    self.busiCircleLb.text = _room.busiCircle;
    self.rentTypeLb.text = _room.rent_type;
    self.floorLb.text = [NSString stringWithFormat:@"%@层",_room.floor];
    self.sizeLb.text = [NSString stringWithFormat:@"%@ M²",_room.size];
    self.orientLb.text = _room.orient;
    self.priceLb.text = [NSString stringWithFormat:@"%d",(int)_room.price];
    
    
    //设置标签
    self.tag0Btn.hidden = YES,self.tag1Btn.hidden = YES,self.tag2Btn.hidden = YES;
    NSArray *recommendTargetArray = [self.room.recommendTarget componentsSeparatedByString:@","];
    int count = 0;
    for (NSString *obj in recommendTargetArray) {
        if ([obj isEqualToString:@""]) {
            break;
        }
        UIButton *btn = nil;
        switch (count) {
            case 0:
                btn = self.tag0Btn;
                break;
            case 1:
                btn = self.tag1Btn;
                break;
            case 2:
                btn = self.tag2Btn;
                break;
            default:
                break;
        }
        btn.hidden = NO;
        [btn setTitle:obj forState:UIControlStateNormal];
        count++;
    } 
    
    //设置滚动图片
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat ratio = 375.f / 247.f;
    CGFloat imgH = screenW / ratio;
    
    NSArray *pics;
    if (_room.picture.length > 0) {
        pics = [_room.picture componentsSeparatedByString:@","];
    }
    if (pics == nil || pics.count == 0) {
        self.numLabel.hidden = YES;
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"placeholder_picture"]];
        imageV.frame = CGRectMake(0 * screenW, 0, screenW, imgH);
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.tag = 0;
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        imageV.clipsToBounds = YES;
        [self.scroll addSubview:imageV];

    } else {
        self.totalPhotos = pics.count;
        [self setNumber:1];
    }
    
    [pics enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"placeholder_picture"]];
        imageV.frame = CGRectMake(idx * screenW, 0, screenW, imgH);
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.tag = idx;
        imageV.userInteractionEnabled = YES;
        imageV.backgroundColor = UIColorFromRGB(0xf5f5f5);
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        imageV.clipsToBounds = YES;
        [self.scroll addSubview:imageV];
    }];
    self.scroll.contentSize = CGSizeMake(screenW * pics.count, imgH);
    
    self.smartLockWidthConstraint.constant = _room.smartlock?58:0;
}

- (void)setNumber:(NSInteger)page
{
    NSMutableAttributedString *numberString = [[NSMutableAttributedString alloc] init];
    NSAttributedString *num = [[NSAttributedString alloc] initWithString:@(page).stringValue attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSAttributedString *total = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"/%d",(int)self.totalPhotos] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [numberString appendAttributedString:num];
    [numberString appendAttributedString:total];
    
    self.numLabel.attributedText = numberString;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat wTemp = scrollView.frame.size.width;
    [self setNumber:scrollView.contentOffset.x / wTemp + 1];
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    if (_room.picture.length == 0) {
        return;
    }
    UIImageView *imageV = (UIImageView *)tap.view;
    if ([self.delegate respondsToSelector:@selector(UZImageRevealViewPhotoClickAtIndex:)]) {
        [self.delegate UZImageRevealViewPhotoClickAtIndex:imageV.tag];
    }
}




@end

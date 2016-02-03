//
//  UZMainHeaderView.h
//  UZuer
//
//  Created by CaydenK on 15/7/30.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UZMainHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *buttonContainer;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIImageView *arrowDown;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel; //城市
@property (weak, nonatomic) IBOutlet UILabel *enLabel; //拼音
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enLabelCenterX;

+ (instancetype)headerView;

@end

//
//  UZMainHeaderView.m
//  UZuer
//
//  Created by CaydenK on 15/7/30.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZMainHeaderView.h"

@implementation UZMainHeaderView

+ (instancetype)headerView {
    UZMainHeaderView *header = [UZMainHeaderView uz_viewFromNib];
    return header;
}

- (void)awakeFromNib
{
    self.cityLabel.adjustsFontSizeToFitWidth = YES;
    self.enLabel.adjustsFontSizeToFitWidth = YES;
    
}

@end

//
//  UZTabBarItem.m
//  UZuer
//
//  Created by CaydenK on 15/9/14.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZTabBarItem.h"

@implementation UZTabBarItem

-(void)awakeFromNib {
    [super awakeFromNib];
    
    NSInteger tag = self.tag;
    if (tag == 0) {
        self.selectedImage = [UIImage imageNamed:@"icon_home_page_down"];
    }
    else if (tag == 1) {
        self.selectedImage = [UIImage imageNamed:@"icon_home_page_intelligent_lock_down"];
    }
    else if (tag == 2) {
        self.selectedImage = [UIImage imageNamed:@"icon_home_page_listing_down"];
    }
    else if (tag == 3) {
        self.selectedImage = [UIImage imageNamed:@"icon_home_page_my_down"];
    }
}

@end

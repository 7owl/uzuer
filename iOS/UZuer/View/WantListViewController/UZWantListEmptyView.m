//
//  UZWantListEmptyView.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/11.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZWantListEmptyView.h"

@implementation UZWantListEmptyView

- (IBAction)searchRoomClick:(id)sender
{
    if (self.SearchRoomClick) {
        self.SearchRoomClick(sender);
    }
}

@end

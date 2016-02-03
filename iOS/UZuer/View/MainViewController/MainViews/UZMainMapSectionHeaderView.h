//
//  UZMainMapSectionHeaderView.h
//  UZuer
//
//  Created by CaydenK on 15/7/31.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UZMainMapSectionHeaderView : UITableViewHeaderFooterView

/**
 *  @param block    点击地图搜房的回调
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier callBack:(void(^)(void))block;


@end

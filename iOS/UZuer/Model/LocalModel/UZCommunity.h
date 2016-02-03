//
//  UZCommunity.h
//  UZuer
//
//  Created by xiaofeishen on 15/8/26.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "CKModel.h"

/**
 *  小区 -- 实现NSCopying 协议
 */
@interface UZCommunity : CKModel<NSCoding>

@property (nonatomic, copy) NSString *comm_name; //小区名字
@property (nonatomic, assign) CGFloat longitude; //经度
@property (nonatomic, assign) CGFloat latitude; //纬度
@property (nonatomic, assign) NSInteger room_num; //小区拥有的房源数量

@end

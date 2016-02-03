//
//  UZRecommendRoom.h
//  UZuer
//
//  Created by CaydenK on 15/8/15.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "CKModel.h"

@interface UZRecommendRoom : CKModel


@property (nonatomic, copy) NSString *roomSeq; //房源编号
@property (nonatomic, copy) NSString *address; //
@property (nonatomic, copy) NSString *comm_address_code;
@property (nonatomic, assign) NSInteger comm_id; //小区id
@property (nonatomic, copy) NSString *comm_address; //小区地址，如杭州市西湖区
@property (nonatomic, copy) NSString *comm_name; //小区名字
@property (nonatomic, copy) NSString *metro; //交通
@property (nonatomic, copy) NSNumber<CKPrimaryKey>* id;// = 13;
@property (nonatomic, copy) NSString *kind;// = "1室1卫";
@property (nonatomic, copy) NSString *picture;// 缩略图
@property (nonatomic, assign) NSUInteger price; // = 3000;
@property (nonatomic, copy) NSString *recommend; // = g;
@property (nonatomic, copy) NSString *recommendTarget;// = "1,44,55,";
@property (nonatomic, assign) NSInteger room_host;

@property (nonatomic, copy) NSString *rent_type;


@property (nonatomic, copy) NSString *decoration;

@property (nonatomic, copy) NSString *rental_end_time;  //结束
@property (nonatomic, copy) NSString *rental_start_time;  //开始

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *occupancy;

@property (nonatomic, copy) NSString *orient;

@property (nonatomic, copy) NSString *room_name; //房源具体地址

@property (nonatomic, copy) NSString *size;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *cityid;
@property (nonatomic, copy) NSString *floor;
@property (nonatomic, copy) NSString *busiCircle; //商圈

@property (nonatomic, copy) NSString *longitude; //经度
@property (nonatomic, copy) NSString *latitude; //纬度
@property (nonatomic, copy) NSString *hm_number; //管家号码

//房源配置属性
@property (nonatomic, assign) BOOL bed; //床
@property (nonatomic, assign) BOOL wardrobe; //衣柜
@property (nonatomic, assign) BOOL air_conditioning; //空调
@property (nonatomic, assign) BOOL tv; //电视
@property (nonatomic, assign) BOOL gasstove; //燃气灶
@property (nonatomic, assign) BOOL microwaveOven; //微波炉
@property (nonatomic, assign) BOOL refrigerator; //冰箱
@property (nonatomic, assign) BOOL heater; //热水器
@property (nonatomic, assign) BOOL washing; //洗衣机

/**
 *  是否支持自助看房
 */
@property (nonatomic, assign) BOOL smartlock;
//----------------




//临时属性
@property (nonatomic, assign) double distance; //单位米

//--多余的属性
//@property (nonatomic, assign) NSInteger bashroom; //浴室
//@property (nonatomic, assign) NSInteger kitchen;
//@property (nonatomic, assign) NSInteger balcony;
//

@end

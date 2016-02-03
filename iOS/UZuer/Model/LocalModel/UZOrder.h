//
//  UZOrder.h
//  UZuer
//
//  Created by CaydenK on 15/9/22.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "CKModel.h"

typedef NS_ENUM(NSInteger, PayStatus){
    PayStatusUnPayed = 0,
    PayStatusPayed
};

@interface UZOrder : CKModel

@property (nonatomic, assign) NSInteger id;//": 392,
@property (nonatomic, copy) NSString *orderno;//": "order011300392",
@property (nonatomic, copy) NSString *createtime;//": "2015-09-22",
@property (nonatomic, assign) NSInteger contract_id;//": 113,
@property (nonatomic, copy) NSString *amount;//": "1",
@property (nonatomic, assign) PayStatus paystate;//": 1,
@property (nonatomic, copy) NSString *paytime;//": "",
@property (nonatomic, copy) NSString *order_rental_starttime;//": "2015-09-22",
@property (nonatomic, copy) NSString *order_rental_endtime;//": "2016-09-22"


@end

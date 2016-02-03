//
//  UZContract.h
//  UZuer
//
//  Created by CaydenK on 15/9/22.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "CKModel.h"

typedef NS_ENUM(NSInteger, ContractStatus){
    ContractStatusInValid = -1, //失效
    ContractStatusUnEffect = 0, //未生效
    ContractStatusEffecting,    //生效中
    ContractStatusExpire  //已过期
};

@interface UZContract : CKModel

@property (nonatomic, assign) NSInteger id; //": 113,
@property (nonatomic, copy) NSString *contractno;//": "contract000800113",
@property (nonatomic, assign) NSInteger host_id;//": 3,
@property (nonatomic, assign) NSInteger tenant_id;//": 48,
@property (nonatomic, assign) NSInteger contract_type_id;//": 1,
@property (nonatomic, assign) NSInteger company_id;//": 3,
@property (nonatomic, assign) NSInteger room_id;//": 8,
@property (nonatomic, copy) NSString *house_commander;//": "",
@property (nonatomic, copy) NSString *sign_time;//": "2015-09-22 03:00:01",
@property (nonatomic, copy) NSString *end_time;//": "2016-09-22 03:00:01",
@property (nonatomic, copy) NSString *signid;//": "14429052901041GM62",
@property (nonatomic, copy) NSString *docid;//": "14429052901043XZ81",
@property (nonatomic, assign) NSInteger status;//": 0,
@property (nonatomic, assign) ContractStatus completedState;//": 0,
@property (nonatomic, copy) NSString *ssq_email;//": "15215731373@nomail.visual",
@property (nonatomic, assign) NSInteger price;//": 1,
@property (nonatomic, copy) NSString *cityid;//": "浙江省杭州市西湖区望月公寓去",
@property (nonatomic, assign) NSInteger size;//": 1,
@property (nonatomic, copy) NSString *first_name;//": "测",
@property (nonatomic, copy) NSString *last_name;//": "试",
@property (nonatomic, copy) NSString *tel_number;//": "15215731373",
@property (nonatomic, copy) NSString *id_card;//": "111111111111111111",
@property (nonatomic, copy) NSString *email;//": "taotao_ma@deefly.cn",
@property (nonatomic, copy) NSString *comm_name;//": "望月公寓",
@property (nonatomic, copy) NSString *kind;//": "2室1厅1厨0卫"

@end

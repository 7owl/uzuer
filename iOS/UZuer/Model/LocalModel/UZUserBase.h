//
//  UZUserBase.h
//  UZuer
//
//  Created by CaydenK on 15/8/24.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "CKModel.h"

@interface UZUserBase : CKModel

+ (UZUserBase *)shareInstance;

@property (atomic,copy) NSString<CKPrimaryKey>* uid;
@property (atomic,copy) NSString *token;//": "e2f715b51539c7fd02a3b5ccf4993649",
@property (atomic,copy) NSString *username;//": "18368190120",
@property (atomic,copy) NSString *pwd;//": "",
@property (atomic,copy) NSString *first_name;//": "马",
@property (atomic,copy) NSString *last_name;//": "涛涛",
@property (atomic,copy) NSString *tel_number;//": "18368190120",
@property (atomic,copy) NSString *email;//": "11@qq.com",
@property (atomic,copy) NSString *email_validate;//":
@property (atomic,copy) NSString *id_card;//": "111111111111111111",
@property (atomic,copy) NSString *native_place;//": "第三方",
@property (atomic,copy) NSString *work_unit;//": "是",
@property (atomic,copy) NSString *work_place;//": "啊打发",
@property (atomic,copy) NSString *work_place_number;//": "0000-00000000"
@property (atomic,copy) NSString *identity_valid;//

@property (atomic,copy) NSString *openid;//
@property (atomic,copy) NSString *access_token;//
@property (atomic,copy) NSString *refresh_token;//
@property (atomic,copy) NSString *scope;//
@property (atomic,copy) NSString *expires_in;//

/**
 *  清理单例数据
 */
- (void)clearData;

@end

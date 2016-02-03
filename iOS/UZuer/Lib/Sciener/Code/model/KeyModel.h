//
//  KeyModel.h
//  ScienerDemo
//
//  Created by 谢元潮 on 14-10-31.
//  Copyright (c) 2014年 谢元潮. All rights reserved.
//
#import "CKModel.h"

@interface KeyModel : CKModel


@property (nonatomic) int16_t day1PsIndex;
@property (nonatomic) int16_t day2PsIndex;
@property (nonatomic) int16_t day3PsIndex;
@property (nonatomic) int16_t day4PsIndex;
@property (nonatomic) int16_t day5PsIndex;
@property (nonatomic) int16_t day6PsIndex;
@property (nonatomic) int16_t day7PsIndex;
@property (nonatomic) int16_t day10mPsIndex;
@property (nonatomic, retain) NSString * deletePs;
@property (nonatomic, retain) NSString * deletePsTmp;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * doorName;
@property (nonatomic, retain) NSString * key;
@property (nonatomic) NSTimeInterval endDate;
@property (nonatomic) BOOL hasbackup;
@property (nonatomic) int32_t unlockFlag;
@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isShared;
//11.2
@property (nonatomic) int32_t kid;
@property (nonatomic, retain) NSString * lockmac;
@property (nonatomic, retain) NSString * lockName;
@property (nonatomic, retain) NSString * adminKeyboardPs;
@property (nonatomic, retain) NSString * adminKeyboardPsTmp;
@property (nonatomic, retain) NSString * password;
@property (nonatomic) NSTimeInterval startDate;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * version;
@property (nonatomic) int16_t roomid;
@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSData * aseKey;
@property (nonatomic, retain) NSString * mac;

@property (nonatomic, assign) NSInteger sciener_is_freeze;

@end

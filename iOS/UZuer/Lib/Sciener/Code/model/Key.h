//
//  Key.h
//  ScienerDemo
//
//  Created by 谢元潮 on 15/5/20.
//  Copyright (c) 2015年 谢元潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Key : NSManagedObject

@property (nonatomic, retain) NSString * adminKeyboardPs;
@property (nonatomic, retain) NSString * adminKeyboardPsTmp;
@property (nonatomic, retain) NSData * aseKey;
@property (nonatomic) NSTimeInterval date;
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
@property (nonatomic) NSTimeInterval endDate;
@property (nonatomic) BOOL hasbackup;
@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isShared;
@property (nonatomic, retain) NSString * key;
//11.2
@property (nonatomic) int32_t kid;
@property (nonatomic, retain) NSString * lockmac;
@property (nonatomic, retain) NSString * lockName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic) int16_t roomid;
@property (nonatomic) NSTimeInterval startDate;
@property (nonatomic) int32_t unlockFlag;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * version;
@property (nonatomic, retain) NSString * mac;

@end

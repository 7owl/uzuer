//
//  UnlockRecord.h
//  ScienerDemo
//
//  Created by 谢元潮 on 14-10-31.
//  Copyright (c) 2014年 谢元潮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnlockRecord : NSObject

@property (nonatomic, retain) NSString * openid;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic) BOOL success;
@property (nonatomic) int recordID;

-(id)initWithRecordID:(int)recordID openID:(NSString*)openID success:(BOOL)success date:(NSDate*)date;

@end

//
//  UnlockRecord.m
//  ScienerDemo
//
//  Created by 谢元潮 on 14-10-31.
//  Copyright (c) 2014年 谢元潮. All rights reserved.
//

#import "UnlockRecord.h"

@implementation UnlockRecord

-(id)initWithRecordID:(int)recordID openID:(NSString*)openID success:(BOOL)success date:(NSDate*)date
{
    self = [super init];
    
    if (self) {
        
        self.success = success;
        self.date = date;
        self.openid = openID;
        self.recordID = recordID;
        
    }
    return self;
}



@end

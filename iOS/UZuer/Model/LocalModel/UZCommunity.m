//
//  UZCommunity.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/26.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZCommunity.h"

@implementation UZCommunity

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.comm_name forKey:@"comm_name"];
    [aCoder encodeInteger:self.room_num forKey:@"room_num"];
    [aCoder encodeFloat:self.longitude forKey:@"longitude"];
    [aCoder encodeFloat:self.latitude forKey:@"latitude"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.room_num = [aDecoder decodeIntegerForKey:@"room_num"];
        self.longitude = [aDecoder decodeFloatForKey:@"longitude"];
        self.latitude = [aDecoder decodeFloatForKey:@"latitude"];
        self.comm_name = [aDecoder decodeObjectForKey:@"comm_name"];
    }
    return self;
}

@end

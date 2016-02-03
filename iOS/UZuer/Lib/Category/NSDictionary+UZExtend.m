//
//  NSDictionary+UZExtend.m
//  UZuer
//
//  Created by CaydenK on 15/8/15.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "NSDictionary+UZExtend.h"

@implementation NSDictionary (UZExtend)

- (NSString *)getJson
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        DLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end

//
//  NSString+UZExtend.m
//  UZuer
//
//  Created by CaydenK on 15/8/15.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "NSString+UZExtend.h"

@implementation NSString (UZExtend)

/**
 *  解析json
 *
 *  @return json字符串解析
 */
- (id)analyseJson{
    NSData *buffer=[self dataUsingEncoding:NSUTF8StringEncoding];
    id item;
    if (buffer) {
       item=[NSJSONSerialization JSONObjectWithData:buffer options:kNilOptions error:nil];
    }
    return item;
}

@end

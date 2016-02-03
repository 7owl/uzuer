//
//  NSString+WebImage.m
//  Eleven
//  大小图片地址互相转换
//  Created by CaydenK on 14-7-25.
//  Copyright (c) 2014年 ElevenTeam. All rights reserved.
//

#import "NSString+WebImage.h"

@implementation NSString (WebImage)


/**
 *  小图转换成大图的URL
 *
 *  @return 大图url
 */
- (NSString *)convertToLargeFromThumb{
    if ([self length]==0) {
        return @"";
    }
    //先根据 "." 分解成数组
    NSArray *subStrs=[self componentsSeparatedByString:@"."];
    //数组除了最后一个元素外，所有内容先拼接起来
    NSString *large=@"";
    for (int i=0; i<[subStrs count]-1; i++) {
        large=[large stringByAppendingString:[NSString stringWithFormat:@"%@.",[subStrs objectAtIndex:i]]];
    }
    large = [large substringToIndex:large.length-1];
    //加上_large标识
    large=[large stringByAppendingString:@"_large."];
    //加上后缀名
    large=[large stringByAppendingString:[subStrs lastObject]];
    return large;
}
/**
 *  大图转换成小图的URL
 *
 *  @return 小图url
 */
- (NSString *)convertToThumbFromLarge{
    if ([self length]==0) {
        return @"";
    }
    NSRange largeRange=[self rangeOfString:@"_large"];
    if (largeRange.length>0) {
        return [self stringByReplacingCharactersInRange:largeRange withString:@""];
    }
    return self;
}

@end

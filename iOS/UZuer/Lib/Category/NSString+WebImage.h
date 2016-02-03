//
//  NSString+WebImage.h
//  Eleven
//  大小图片地址互相转换
//  Created by CaydenK on 14-7-25.
//  Copyright (c) 2014年 ElevenTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WebImage)


/**
 *  小图转换成大图的URL
 *
 *  @return 大图url
 */
- (NSString *)convertToLargeFromThumb;
/**
 *  大图转换成小图的URL
 *
 *  @return 小图url
 */
- (NSString *)convertToThumbFromLarge;

@end

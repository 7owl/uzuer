//
//  MD5.h
//  GameCenter
//
//  Created by CaydenK on 15/6/23.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UZMD5 : NSObject

+(NSString*)md5:(NSString*)str;

@end

@interface NSString (UZMD5)

- (NSString *)md5;

@end
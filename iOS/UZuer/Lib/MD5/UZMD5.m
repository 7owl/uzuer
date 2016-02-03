//
//  MD5.m
//  GameCenter
//
//  Created by CaydenK on 15/6/23.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UZMD5

+(NSString*)md5:(NSString*)str {
    const char*cStr =[str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSString *md5Str=[NSString stringWithFormat:
                      @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ];
    return md5Str;
}

@end

@implementation NSString (UZMD5)

- (NSString *)md5{
    return [UZMD5 md5:self];
}

@end
//
//  NSDictionary+UZParams.h
//  UZuer
//
//  Created by shenxiaofei on 15/8/20.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (UZParams)

/**
*  添加auth（认证信息）
*/
- (instancetype)authorized;
/**
 *  添加cityid（城市）
 */
- (instancetype)cityInfo;

@end

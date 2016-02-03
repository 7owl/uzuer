//
//  UZGlobalModel.h
//  UZuer
//
//  Created by CaydenK on 15/8/27.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UZGlobalModel : NSObject

+ (UZGlobalModel *)shareInstance;

/**
 *  个推id缓存
 */
@property (atomic, copy) NSString *tempClientid;
/**
 *  apnsID
 */
@property (atomic, copy) NSString *tempDeviceToken;

@end

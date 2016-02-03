//
//  UserInfo.h
//  BTstackCocoa
//
//  Created by wan on 13-3-6.
//
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

//0，已冻结；1，正常；2，冻结中；3，解除冻结中；4，已分享秘钥；5，删除中；
#define STATE_TYPE_BLOCKED 0
#define STATE_TYPE_NORMAL 1
#define STATE_TYPE_BLOCKING 2
#define STATE_TYPE_UNLOCKING 3
#define STATE_TYPE_SHARED 4
#define STATE_TYPE_DELETING 5



@property (nonatomic, retain) NSString *openid;//用户唯一码
@property (nonatomic, retain) NSString *status;//状态
@property (nonatomic, retain) NSString *kid;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSString *roomid;

@property (nonatomic, retain) NSString *headurl;
@property (nonatomic, retain) NSString *nickname;
@end

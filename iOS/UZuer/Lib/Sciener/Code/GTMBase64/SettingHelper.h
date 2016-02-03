//
//  SettingHelper.h
//  BTstackCocoa
//
//  Created by wan on 13-2-28.
//
//

#import <Foundation/Foundation.h>
#import "APService.h"
#import <MapKit/MapKit.h>


@interface SettingHelper : NSObject

//默认 aeskey
+(NSData*)getDefaultAesKey;

+(void)setDefaultAesKey:(NSData*)object;


//是否是定制app
+(void)setIsDingZhi:(BOOL)obj;
+(BOOL)isDingZhi;

//定制app的版本号
+(void)setDingZhiProtocol:(NSString*)obj;
+(NSString*)getDingZhiProtocol;


+(void)setFlagSendKbpSendSMS:(BOOL)sendsms;
+(BOOL)isFlagSendKbpSendSMS;

+(void)setUserSaveInDB:(BOOL)object;
+(BOOL)isUserSaveInDB;


//+(void)setUnlockFlagUpdated:(BOOL)object;
//+(BOOL)isUnlockFlagUpdated;


//+(void)setPhoneGpsNew:(CLLocation*)object;
//+(CLLocation*)getPhoneGpsNew;

+(void)setPhoneGpsDateNew:(NSDate*)object;
+(NSDate*)getPhoneGpsDateNew;

//+(void)setPhoneGpsOld:(CLLocation*)object;
//+(CLLocation*)getPhoneGpsOld;

+(void)setPhoneGpsDateOld:(NSDate*)object;
+(NSDate*)getPhoneGpsDateOld;

+(void)setPhoneGpsDistance:(float)object;
+(float)getPhoneGpsDistance;



+(void)setDeleteNormalUserSelf:(NSArray*)deleteFailed cleanup:(BOOL)cleanup;
+(NSArray *)getDeleteNormalUserSelf;

+(NSArray *)getDeleteUserFeedBack;
+(void)setDeleteUserFeedBack:(NSArray*)deleteFailed cleanup:(BOOL)cleanup;

+(void)setWeiboBinded:(BOOL)login;

+(BOOL)isWeiboBinded;

+(void)setQQBinded:(BOOL)login;

+(BOOL)isQQBinded;

+(void)setQQId:(NSString*)object;

+(NSString*)getQQId;

+(void)setQQAccount:(NSString*)object;

+(NSString*)getQQAccount;

+(void)setQQProfile:(NSString*)object;

+(NSString*)getQQProfile;

+(void)setWeiboAccount:(NSString*)object;

+(NSString*)getWeiboAccount;

+(void)setWeiboProfile:(NSString*)object;

+(NSString*)getWeiboProfile;

//plat3id weibo
+(void)setWeiboId:(NSString*)object;

+(NSString*)getWeiboId;

+(void)setToken:(NSString*)object;

+(NSString*)getToken;

+(void)setUniqueid:(NSString*)object;

+(NSString*)getUniqueid;

+(id)getScienerPassword;

+(void)setScienerPassword:(NSData*)object;


/**头像地址
 */
+(NSString*)getHeadUrl;
+(void)setHeadUrl:(NSString*)object;

/**email
 */
+(void)setEmail:(NSString*)object;

+(NSString*)getEmail;

/**phone number
 */
+(void)setPhoneNumber:(NSString*)object;

+(NSString*)getPhoneNumber;

/**昵称
 */
+(void)setNickName:(NSString*)object;

+(NSString*)getNickName;
//+(void)setScienerAccount:(NSString*)object;
//
//+(NSString*)getScienerAccount;

/**
 *uid
 */
+(void)setUID:(NSString*)object;
+(NSString*)getUID;

+(void)setUUID:(NSString*)object;
+(NSString*)getUUID;

+(void)setBg:(int)bg;
+(int)getBg;

+(BOOL)isBootFirst;
+(BOOL)isSleeppingTime;

+(void)setSleepTimeEnd:(int)date;
+(void)setSleepTimeStart:(int)date;

+(int)getSleepTimeEnd;
+(int)getSleepTimeStart;

+(void)setLogin:(BOOL)login;
+(BOOL)isLogin;

+(void)setDelay:(NSString*)object;
+(NSString*)getDelay;

+(void)setPsProtect:(NSNumber*)object;
+(NSNumber*)getPsProtect;

+(void)setPsProtectOpen:(BOOL*)object;
+(BOOL*)isPsProtectOpen;

+(void)setMsgViber:(BOOL)object;
+(BOOL)getMsgViber;

//+(void)BlockAccount:(BOOL)object;
//+(BOOL)IsBlockAccount;

+(void)setMsgSound:(BOOL)object;
+(BOOL)getMsgSound;

+(void)setOperatorViber:(BOOL)object;
+(BOOL)getOperatorViber;

+(void)setOperatorSound:(BOOL)object;
+(BOOL)getOperatorSound;

+(void)setLocalAddress:(NSString*)object;
+(NSString*)getLocalAddress;

+(void)setLockNeedToUnbind:(NSString*)object;
+(NSString*)getLockNeedToUnbind;

+(BOOL)getHasUpdateFlatForm;
+(void)setHasUpdateFlatForm:(BOOL)object;

+(void)setLastMsgID:(NSString*)object;
+(NSString*)getLastMsgID;

/**最近一次发送更新key状态的时间
 */
+(void)setLastKeyUpdateDate:(NSDate*)object;
+(NSDate*)getLastKeyUpdateDate;


/**最近一次发送检测更新app的时间
 */
+(NSDate*)getLastAppUpdateDate;
+(void)setLastAppUpdateDate:(NSDate*)object;


/**最近一次更新好友头像的时间
 */
+(NSDate*)getLastHeadPicUpdateDate;
+(void)setLastHeadPicUpdateDate:(NSDate*)object;


/**最近一次显示手势密码
 */
+(NSDate*)getLastShowPattern;
+(void)setLastShowPattern:(NSDate*)object;


/**最近一次更新用户自己头像的时间
 */
+(NSDate*)getLastUserHeadPicUpdateDate;
+(void)setLastUserHeadPicUpdateDate:(NSDate*)object;

@end

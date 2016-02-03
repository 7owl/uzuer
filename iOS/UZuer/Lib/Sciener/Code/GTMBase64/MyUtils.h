//
//  Utils.h
//  BTstackCocoa
//
//  Created by wan on 13-1-31.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Key.h"
#import "UserInfo.h"
#import "Command.h"
#import "LockFound.h"

@interface MyUtils : NSObject

#define DateFormateStringDefault @"yyyy-MM-dd HH:mm:ss"

#define DISTANCE_DEFAULT_FOR_SAVE 2.5f               // 默认保存的开锁距离
// 260->200->170
// 越远越小，越近越大
//#define RSSI_SETTING_MAX -45
//#define RSSI_SETTING_MIN -100
//
//#define RSSI_SETTING_CLOSE -50
//#define RSSI_SETTING_MIDDLE -70
//#define RSSI_SETTING_FAR -80


#define RSSI_SETTING_MAX -65    //对应最近距离0.5m
#define RSSI_SETTING_MIN -140

//#define RSSI_SETTING_CLOSE -60
#define RSSI_SETTING_MIDDLE_0 -85
#define RSSI_SETTING_MIDDLE_1 -100
//#define RSSI_SETTING_FAR -120

+(long long)fileSizeAtPath:(NSString*)filePath;

+(int)loadFileContentsIntoTextView:(NSString *)filePath fileBytes:(Byte*)fileBytes;

+(NSString*)DecodeSharedKeyValue:(NSString*)edateStr;
+(NSString*)EncodeSharedKeyValue:(NSString*)edate;
        
+(NSData *)EncodeScienerPS:(NSString *)str;
+(NSData *)EncodeScienerPSBytes:(Byte *)password length:(int)length;
+(NSString *)DecodeScienerPS:(NSData *)data;
+(NSData *)DecodeScienerPSToData:(NSData *)data;


+(void)refreshLockAfterLogin;

+(BOOL)isIpad;
+(BOOL)isPlatformOK;

+(double)systemVersion;

+(BOOL)isString:(NSString*)source contain:(NSString*)subStr;

+(int)getRssiFromUnlockDistance:(double)unlockdistance;

+(double)getUnlockDistanceFromRssi:(int)rssi;

+(int)GetDayFromDate:(NSDate *)date;

+(int)GetHourFromDate:(NSDate *)date;

+(int)GetMintureFromDate:(NSDate *)date;

+(int)GetSecondFromDate:(NSDate *)date;

+(int)GetMonthFromDate:(NSDate *)date;

+(int)GetYearFromDate:(NSDate *)date;

+(NSString*)GetCurrentTimeInLong;

+(NSString*)GetDateInLong:(NSDate*)date;

//+(NSString*)EncodeDigestForDeleteNormalUser_lock:(NSString*)lock
//                                          userid:(NSString*)userid
//                                        password:(NSString*)password
//                                          webacc:(NSString*)webacc
//                                        uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
//+(NSString*)EncodeDigestForDeleteSharedKey_lock:(NSString*)lock skid:(NSString*)skid
//                                       userid:(NSString*)userid password:(NSString*)password
//                                       webacc:(NSString*)webacc
//                                     uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
//+(NSString*)EncodeDigestForSendSharedKey_lock:(NSString*)lock mac:(NSString*)mac
//                                       userid:(NSString*)userid password:(NSString*)password webacc:(NSString*)webacc
//                                     uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
//+(NSString*)EncodeDigestForReadLock:(NSString*)userid lock:(NSString*)lock uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
//+(NSString*)EncodeDigestForReadSharedKey:(NSString*)userid password:(NSString*)password uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
//+(NSString*)EncodeDigestForBindLock:(NSString*)lock userid:(NSString*)userid  uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
//+(NSString*)EncodeDigestLock:(NSString*)lock user:(NSString*)user uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
//+(NSString*)EncodeDigestForBlockAccount:(NSString*)tag
//                                 userid:(NSString*)userid
//                               password:(NSString*)password
//                                   lock:(NSString*)lock
//                               uniqueid:(NSString*)uniqueid
//                                   date:(NSString*)date;
//
//+(NSString*)EncodeDigestForBindqqweibo_plat3:(NSString*)plat3
//                                     plat3id:(NSString*)plat3id
//                                    uniqueid:(NSString*)uniqueid
//                                        date:(NSString*)date;
//
//+(NSString*)EncodeDigestForBackUpKey_userid:(NSString*)userid
//                                   password:(NSString*)password
//                                   uniqueid:(NSString*)uniqueid
//                                       date:(NSString*)date;
//
//+(NSString*)EncodeDigestForAppUpdate_version:(NSString*)version
//                                    uniqueid:(NSString*)uniqueid
//                                        date:(NSString*)date;
//
//+(NSString*)EncodeDigestForBlockFeedBack:(NSString*)lock
//                                    user:(NSString*)user
//                                uniqueid:(NSString*)uniqueid
//                                    date:(NSString*)date;
//
//+(NSString*)EncodeDigestForReadUnReadedMsg_userid:(NSString*)userid
//                                         password:(NSString*)password
//                                         uniqueid:(NSString*)uniqueid
//                                          lsmsgid:(NSString*)lsmsgid
//                                             date:(NSString*)date;
//
//+(NSString*)EncodeDigestForReadSharedKey_userid:(NSString*)userid
//                                       password:(NSString*)password
//                                           skid:(NSString*)skid
//                                       uniqueid:(NSString*)uniqueid
//                                           date:(NSString*)date;
//
//+(NSString*)EncodeDigestForDelUserFb_userid:(NSString*)userid
//                                       lock:(NSString*)lock
//                                   uniqueid:(NSString*)uniqueid
//                                       date:(NSString*)date;
//
//+(NSString*)EncodeDigestForDelNormalUserSelf_userid:(NSString*)userid
//                                               lock:(NSString*)lock
//                                           password:(NSString*)password
//                                           uniqueid:(NSString*)uniqueid
//                                               date:(NSString*)date;
//
//+(NSString*)EncodeDigestForGetBindedPlat3_userid:(NSString*)userid
//                                        password:(NSString*)password
//                                        uniqueid:(NSString*)uniqueid
//                                            date:(NSString*)date;
//
//+(NSString*)EncodeDigestForUnBindedPlat3_userid:(NSString*)userid
//                                       password:(NSString*)password
//                                           plat:(NSString*)plat
//                                         platid:(NSString*)platid
//                                       uniqueid:(NSString*)uniqueid
//                                           date:(NSString*)date;
//
//+(NSString*)EncodeDigestForFeedBack:(NSString*)linkman uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
//+(NSString*)EncodeDigestForPlatFormUpdate:(NSString*)userid password:(NSString*)password date:(NSString*)date;
//
//+(NSString*)EncodeDigestUser:(NSString*)user password:(NSString*)password uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
///**
// * 修改昵称
// */
//+(NSString*)EncodeDigestModifyUserid:(NSString*)user password:(NSString*)password nickName:(NSString*)nickName uniqueid:(NSString*)uniqueid date:(NSString*)date;
//
//+(NSString*)EncodeDigestSMS_Tel:(NSString*)tel uniqueid:(NSString*)uniqueid date:(NSString*)date;

+(NSString*)EncodePS:(NSString*)password;

+(BOOL)isAutoUnlock:(NSMutableArray*)array;

+(NSString*)formateDate:(NSDate*)date format:(NSString*)format;

+(NSTimeInterval)formateDateFromString:(NSString*)dateStr format:(NSString*)format;

+(NSDate*)formateDateFromStringToDate:(NSString*)dateStr format:(NSString*)format;

//+(NSString*)formateDateFromString:();

+(long) getLongForBytes:(Byte*)packet;

+(void) printAsString:(uint8_t *)packet;

+(void) printByteByByte:(Byte *)packet withLength:(int)length;
+(NSString *) stringFromBytes:(Byte *)packet withLength:(int)length;

+(Byte)generateRandomByte;//随机数

//+(NSString*)getRandomStr:(int) length;

+(void) arrayCopyWithSrc:(Byte*)src srcPos:(int)srcPos dst:(Byte*)dst dstPos:(int)dstPos length:(int)length;

//+(Byte*)getMacBytes:(NSString*)macStr;

+(void)getMacBytes:(NSString*)macStr withByte:(Byte*)macBytes;

+(void) generateDynamicPassword:(Byte*)bytes length:(int) length;

+(NSString *) generateDynamicPassword:(int) length;

-(void)setJpushTag;
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias;
+(BOOL)checkTag:(NSString *)tagStr;

/**用户名格式要求：中文，数字，大小写字母，'.','@',空格
 */
+(BOOL)checkRegistUserName:(NSString *)tagStr;

+(BOOL)checkBlueToothName:(NSString *)tagStr;

/**数字，字母
 */
+(BOOL)checkBackUpDownloadPs:(NSString *)tagStr;

/**是否是中文
 */
+(BOOL)isChinese:(NSString *)tagStr;

/**判断密码长度 数字和字母 下划线
 */
+(BOOL)checkPassword:(NSString *)tagStr;
+(BOOL)checkV4_Del_Admin_ps:(NSString *)tagStr;
+(BOOL)checkNokeyPassword:(NSString *)tagStr ok4Zero:(BOOL)ok4Zero;

/**是否是email
 */
+(BOOL)checkIsEmail:(NSString *)obj;

/**是否是电话号码
 */
+(BOOL)checkIsPhoneNumber:(NSString *)obj;
        
//- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias;

+(UserInfo*) getUserInfoFromBytes:(Byte*)bytes withLength:(int)length;

+(void) handleCommandResponse:(Command *)command;

+(BOOL)isOutOfRange:(NSString*)str len:(int)maxLength;

+ (NSString *) macaddress;

+ (int)getLengthForString:(NSString*)strtemp;

/**是否可以显示手势密码，5秒中内不用输入
 */
+(BOOL)isReadyForShowPattern;

/**是否可以更新用户头像，一天
 */
+(BOOL)isReadyForUpdateUserHeadPic;

/**时间是否可以再次发送更新key状态指令，开程序就更新
 */
+(BOOL)isReadyForUpdateKeyState;

/**是否可以发送检测更新app指令，半天更新一次
 */
+(BOOL)isReadyForAppupdate;

/**是否可以更新好友头像，有可能用户换头像了，半天更新一次
 */
+(BOOL)isReadyForReloadHeadPic;

+ (NSString*)dateFormateForMsgs:(NSDate*)date;


+(NSArray *)ArraySort4Msg:(NSArray *)msgs;

+(void)deleteFile:(NSString*)filePath;

//+(UIImage *)dealWithUIImage:(UIImage *)image;
+(void)saveImage:(NSMutableData*)data file:(NSString*)myHeadDirectory imgName:(NSString*)name;
+(UIImage *)getImageFormPath:(NSString*)myDirectory name:(NSString*)name;
+(UIImage *)getUserHeadImage:(NSString*)name;

///**3字节失效flag加1
// */
//+(void) upateInvalidFalg:(Byte *)bytes;

//转换
/**十六进制的字符串转换成nsdata
 */
+(NSData*)DataFromHexStr:(NSString *)hexString;

/**十六进制的字节数组转换成int 10进制
 */
+(int)intFromHexBytes:(Byte*)bytes length:(int)dataLen;

/**字符串转换成10进制的int
 */
+(Byte * )int10FromString:(NSString*)password;

/**0到9的随机数
 */
+(int)RandomInt0To9;

/**0到9的数字，长度length
 */
+(int)RandomNumber0To9_length:(int)length;

+(int)IsKeyExist:(id)model;

+(BOOL)IsMacMark_protocolCategory:(int)protocolCategory
                  protocolVersion:(int)protocolVersion
                    applyCatagory:(int)applyCatagory
                          applyID:(int)applyID
                         applyID2:(int)applyID2;


+(NSString * )StringFromDictionary:(NSDictionary*)dictionary;

+(BOOL)isFine4AddAdmin:(NSString*)protocol;


@end

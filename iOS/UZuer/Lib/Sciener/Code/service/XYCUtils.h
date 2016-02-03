//
//  Utils.h
//  BTstackCocoa
//
//  Created by wan on 13-1-31.
//
//

#import <Foundation/Foundation.h>
#import "Key.h"
//#import "UserInfo.h"
//#import "Command.h"

@interface XYCUtils : NSObject

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


+(NSString*)formateDate:(NSDate*)date format:(NSString*)format;

+(BOOL)checkNokeyPassword:(NSString *)tagStr;

+(NSString*)GetCurrentTimeInMillisecond;

+(NSDate*)formateDateFromStringToDate:(NSString*)dateStr format:(NSString*)format;

+(BOOL)checkRegistUserName:(NSString *)tagStr;

+(BOOL)checkNokeyPassword:(NSString *)tagStr ok4Zero:(BOOL)ok4Zero;

+(NSData*)DataFromHexStr:(NSString *)hexString;

+(void) printByteByByte:(Byte *)data withLength:(int)length;

//+(NSString*)GetCurrentTimeInSecond;




@end

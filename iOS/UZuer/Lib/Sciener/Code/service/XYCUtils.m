//
//  Utils.m
//  BTstackCocoa
//
//  Created by wan on 13-1-31.
//
//

#import "XYCUtils.h"
#import "MyLog.h"
#import "Key.h"
//#import "MyMD5.h"
//#import "SecurityUtil.h"
//#import "APService.h"
//#import "SettingHelper.h"
//#import "Command.h"
//#import "BLEAppDelegate.h"
//#import "AudioHelper.h"
//#import "RequestUtils.h"
//#import "RequestService.h"
//#import "CommandUtils.h"
//#import "KeyModel.h"
//#import "DBHelper.h"
//#import "AddLockGuider1ViewController.h"
//#import "AddLockGuider0ViewController.h"
//#import "KeyDetailViewController.h"
//#import "UserManageViewController.h"
//#import "Command.h"
//#import "NoKeyPasswordManageViewController.h"
//#import "CRC8.h"
//#import "MessageModel.h"
//
//#import  "sys/utsname.h"
//
//#include <sys/socket.h> // Per msqr
//#include <sys/sysctl.h>
//#include <net/if.h>
//#include <net/if_dl.h>


#define MAX_POOL_PS_NUMBER 900

@implementation XYCUtils

//bool DEBUG_UTILS = true;

NSMutableArray * Ps900Array = Nil;




+(NSString*)formateDate:(NSDate*)date format:(NSString*)format
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:format];
    
    NSString* dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}


+(BOOL)checkNokeyPassword:(NSString *)tagStr{
    
    //6到10位数字
    NSString * regex = @"^([0-9]){6,10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:tagStr];
    
}


+(NSString*)GetCurrentTimeInMillisecond
{
    
    NSDate* date = [NSDate date];
    
    NSTimeInterval interval=[date timeIntervalSince1970]*1000;
    
    NSString *dateStr = [NSString stringWithFormat:@"%f",interval];
    
    NSArray *macStrArray =[dateStr componentsSeparatedByString:@"."];
    
    return [macStrArray objectAtIndex:0];
    
}

+(NSDate*)formateDateFromStringToDate:(NSString*)dateStr format:(NSString*)format
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:format];
    
    NSDate *date=[formatter dateFromString:dateStr];
    
    
    return date;
    
    
}

/**中文，数字，大小写字母，'.','@',空格
 */
+(BOOL)checkRegistUserName:(NSString *)tagStr{
    
    NSString * regex = @"^([\u4E00-\u9FA50-9a-zA-Z_-]|[.@ ]){1,}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:tagStr];
    
}

+(BOOL)checkNokeyPassword:(NSString *)tagStr ok4Zero:(BOOL)ok4Zero{
    
    if (ok4Zero) {
        
        //只能是大于等于0，小于9的6到10位数字
        NSString * regex = @"^([0-9]){6,10}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        return [pred evaluateWithObject:tagStr];
        
    } else {
        
        //只能是大于0，小于9的6到10位数字
        NSString * regex = @"^([1-9]){6,10}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        return [pred evaluateWithObject:tagStr];
        
    }
    
}

+(NSData*)DataFromHexStr:(NSString *)hexString{
    
    
    Byte bytes[128]={0x00};  ///3ds key的Byte 数组， 128位
    int j=0;
    for(int i = hexString.length-1;i>=0;i--)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48); //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = hex_char1-55; //// A 的Ascll - 65
        else
            int_ch1 = hex_char1-87; //// a 的Ascll - 97
        
        i--;
        
        if (i<0) {
            
            bytes[j] = int_ch1;
            j++;
            break;
        }
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48)*16;   //// 0 的Ascll - 48   //阿拉伯数字
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = (hex_char2-55)*16; //// A 的Ascll - 65     //英文字母
        else
            int_ch2 = (hex_char2-87)*16; //// a 的Ascll - 97     //英文字母
        
        
        int_ch = int_ch1+int_ch2;
        
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    
    //    [MyUtils printByteByByte:bytes withLength:4];
    
    int count = j-1;
    //    Byte bytess[count];
    Byte bytesFinal[128] = {0x00};
    for (int i = 0; i <= count; i++) {
        
        bytesFinal[i] = bytes[count-i];
        //        NSLog(@"j:%i result:%02x",count-i,bytes[count-i]);
        
    }
    //    [MyUtils printByteByByte:bytesFinal withLength:4];
    
    NSData *newData = [[NSData alloc] initWithBytes:bytesFinal length:count+1];
    
    return newData;
    
}

+(void) printByteByByte:(Byte *)data withLength:(int)length{
    NSLog(@"length === %d", length);
    NSLog(@"data === %s", data);
    if (data == NULL) {
        return;
   }
    for (int i = 0; i<length; i++) {
        NSLog(@"index:%d,{%02x}",i,data[i]);
    }
}

//+(NSString*)GetCurrentTimeInSecond
//{
//    
//    NSDate* date = [NSDate date];
//    
//    NSTimeInterval interval=[date timeIntervalSince1970];
//    
//    NSString *dateStr = [NSString stringWithFormat:@"%f",interval];
//    
//    NSArray *macStrArray =[dateStr componentsSeparatedByString:@"."];
//    
//    return [macStrArray objectAtIndex:0];
//    
//}


@end

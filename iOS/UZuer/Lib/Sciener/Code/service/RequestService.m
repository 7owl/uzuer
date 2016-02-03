//
//  RequestService.m
//  BTstackCocoa
//
//  Created by wan on 13-3-7.
//
//

#import "RequestService.h"
#import "XYCUtils.h"
#import "MyLog.h"
#import "Define.h"
#import "UnlockRecord.h"
#import "GTMBase64.h"
#import "CRC8.h"
@implementation RequestService

#define URL @"http://api.sciener.cn"
//#define URL @"http://192.168.199.188:8081/openAPI"

/*
 请求：
 url：%@/v1/room/bindingAdmin
 
 请求参数:
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 &date=1412992342893
 &lock_key=key_value
 &lock_mac=195.134.131.13
 &lock_name=lock0003

 protocol_type
 protocol_version
 scene
 group_id
 org_id
 
 反馈：
    {"room_id":2619}
 
 */

+(int)bindLock:(KeyModel*)keyModel
   accessToken:(NSString*)accessToken
      clientId:(NSString*)clientId
 protocol_type:(NSString*)protocol_type
protocol_version:(NSString*)protocol_version
         scene:(NSString*)scene
      group_id:(NSString*)group_id
        org_id:(NSString*)org_id
{
    NSMutableString * strBuffer = [[NSMutableString alloc]init];
    if (keyModel && keyModel.aseKey) {
        
        Byte * aesKeyBytes = (Byte *)keyModel.aseKey.bytes;
        
        for (int i = 0 ; i < keyModel.aseKey.length ; i++) {
            
            [strBuffer appendFormat:@"%02x,",aesKeyBytes[i]];
            
        }
        if (strBuffer.length>0) {
            [strBuffer deleteCharactersInRange:NSMakeRange(strBuffer.length-1, 1)];
        }
    }
    
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    //10.15
    NSString *newgroup_id = group_id;
    NSString *neworg_id = org_id;
    if ([group_id  isEqual: @"0"]) {
        newgroup_id = @"1";
    }
    if ([org_id  isEqual: @"0"]) {
        neworg_id = @"1";
    }
    NSString * url = [NSString stringWithFormat:@"%@/v1/room/bindingAdmin?client_id=%@&access_token=%@&date=%@&lock_key=%@&lock_mac=%@&lock_name=%@&protocol_type=%@&protocol_version=%@&scene=%@&group_id=%@&org_id=%@&aes_key_str=%@",URL,clientId,accessToken,date,keyModel.key,keyModel.lockmac,keyModel.lockName,protocol_type,protocol_version,scene,newgroup_id,neworg_id,strBuffer];

    [MyLog logFormate:@"绑定管理员url:%@",url];
    NSLog(@"绑定管理员url:%@",url);
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];

    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"绑定管理员 send request failed: %@", error);
        return NET_REQUEST_ERROR_NO_DATA;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"response:%@",response];
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    if (!errcode) {
        
        NSString * roomid = [resultsDictionary objectForKey:@"room_id"];
        NSString * keyid = [resultsDictionary objectForKey:@"key_id"];
        
        keyModel.roomid = roomid.intValue;
        keyModel.kid = keyid.intValue;
        return 0;
    }
    NSLog(@"errmsg = %@", errmsg);
    return errcode.intValue;
    
}


/*
 
 %@/v1/key/send?
 
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 
 &adminid=1841548952
 &room_id=2619
 &date=1411955356111
 &start_date1411955356111
 &end_date1654789012323
 &lock_key=key_value
 &lock_mac=195.134.131.13
 &message=give+you+message

 
 反馈：
 
 {
 " errcode ": 0,
 " errmsg ": "none error message"
 }
 
 */

+(int)SendEKey_roomid:(NSString *)roomid
            startDate:(NSString *)startDate
              endDate:(NSString*)endDate
                  key:(NSString*)key
                  mac:(NSString *)mac
              message:(NSString *)message
             clientid:(NSString*)clientid
          accessToken:(NSString*)accessToken
               openid:(NSString*)openid
{
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/key/send?client_id=%@&access_token=%@&openid=%@&room_id=%@&date=%@&start_date=%@&end_date=%@&lock_key=%@&lock_mac=%@&message=%@",URL,clientid,accessToken,openid,roomid,date,startDate,endDate,key,mac,message];
    
    [MyLog logFormate:@"发送电子钥匙url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return NET_REQUEST_ERROR_NO_DATA;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"response:%@",response];
    NSLog(@"发送电子钥匙response:%@",response);
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    return errcode.intValue;
    
}




/*
 
 请求：
 192.168.1.188:8080/openAPI/v1/key/getKeyList?
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 &date=1411955381498

 
 反馈：
 {
    "list": [
        {
        "date": 1411897677000,
        "end_date": 4102415999000,
        "key_id": 6265,
        "key_status": "110402",
        "room_id": 2619,
        "start_date": 1411897677923
        },
        ...
    ]
 }
 
 */
//获取电子钥匙列表
+(NSMutableArray*)requestEkeys_clientid:(NSString*)clientid
                            accesstoken:(NSString*)accessToken
{

    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/key/list?client_id=%@&access_token=%@&date=%@",URL,clientid,accessToken,date];
    
    [MyLog logFormate:@"ekey列表 url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return Nil;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"获取电子钥匙列表response:%@",response];
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    if (!errcode) {
        
        NSArray * array = [resultsDictionary objectForKey:@"list"];
        NSMutableArray * keyList = [[NSMutableArray alloc]init];
        for (NSDictionary* keyItem in array) {
            NSNumber * start_date = [keyItem objectForKey:@"start_date"];
            NSNumber * end_date = [keyItem objectForKey:@"end_date"];
            NSNumber * key_id = [keyItem objectForKey:@"key_id"];
            NSNumber * room_id = [keyItem objectForKey:@"room_id"];
            NSNumber * date = [keyItem objectForKey:@"date"];
            
            KeyModel * key = [[KeyModel alloc]init];
            key.startDate = start_date.longLongValue/1000;
            key.endDate = end_date.longLongValue/1000;
            key.date = date.longLongValue/1000;
            key.kid = key_id.intValue;
            key.roomid = room_id.intValue;
            key.doorName = [NSString stringWithFormat:@"%@-%@",room_id,key_id];
            [keyList addObject:key];
        }
        return keyList;
        
    }
    
    return Nil;
}


/*
 
 请求:
 192.168.1.188:8080/openAPI/v1/key/download?
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 &date=1411955428013
 &room_id=2619
 &key_id=6267
 
 
 反馈:
 {
    "date": 1411955356000,
    "lock_key": "key_value",
    "lock_mac": "195.134.131.13",
    "room_id": 2619
 }
 
 */
//下载电子钥匙
+(int)downloadEkey_key:(KeyModel*)key
              clientid:(NSString*)clientid
           accesstoken:(NSString*)accessToken
{
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/key/download?client_id=%@&access_token=%@&date=%@&key_id=%i&room_id=%i",URL,clientid,accessToken,date,key.kid,key.roomid];
    
    [MyLog logFormate:@"下载电子钥匙url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return NET_REQUEST_ERROR_NO_DATA;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"下载电子钥匙response:%@",response);
    [MyLog logFormate:@"下载电子钥匙response:%@",response];
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    
    if (!errcode) {
        
        NSString * lock_mac = [resultsDictionary objectForKey:@"lock_mac"];
        NSString * lock_name = [resultsDictionary objectForKey:@"lock_name"];
        NSString * lock_keySource = [resultsDictionary objectForKey:@"lock_key"];
        NSString * lock_key;
#warning 修改
        if (lock_keySource.length != 10 && lock_keySource.length != 9) {
            NSData *data = [lock_keySource dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            data = [GTMBase64 decodeData:data];
            NSString *lock_keymedium = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray * locks = [lock_keymedium componentsSeparatedByString:@","];
            Byte values[locks.count];
            for (int i = 0; i < locks.count; i++) {
                values[i] = [[locks objectAtIndex:i] intValue];
            }
            NSData *data2 =  [NSData dataWithBytes:values length:locks.count];
            Byte *sourceBytes = (Byte *)[data2 bytes];
            Byte encrypt = sourceBytes[data2.length-1];
            Byte finalBytes[data2.length-1];
            for (int i = 0; i<data2.length-1; i++) {
                finalBytes[i+0]=sourceBytes[0+i];
            }
            Byte * bytesDecode = [CRC8 encodeWithDataToCrc:finalBytes off:0 len:data2.length-1 seed:encrypt];
            lock_key =  [[NSString alloc]initWithBytes:bytesDecode length:data2.length-1 encoding:NSUTF8StringEncoding];
            //iOS 需要做一下特殊处理, 跟安卓的不太一样
            if (lock_key.length < 10) {
                for (NSInteger i = lock_key.length; i < 10; i++) {
                    lock_key = [@"0" stringByAppendingString:lock_key];
                }
            }
        }
        
        else {
            lock_key = lock_keySource;
        }
        
        NSNumber * room_id = [resultsDictionary objectForKey:@"room_id"];
        NSNumber * date = [resultsDictionary objectForKey:@"date"];
        NSNumber * unlock_flag = [resultsDictionary objectForKey:@"lock_flag_pos"];
        NSString * aesKeyStr = [resultsDictionary objectForKey:@"aes_key_str"];
        NSArray * array = [aesKeyStr componentsSeparatedByString:@","];
        NSMutableString * aesHexStr = [[NSMutableString alloc]init];
        for (int i = 0; i < array.count; i ++) {
            [aesHexStr appendFormat:@"%@",array[i]];
        }
        NSData * dataAesKey = [XYCUtils DataFromHexStr:aesHexStr];
        key.aseKey = dataAesKey;
        NSLog(@"ekey 的aes key");
        [XYCUtils printByteByByte:key.aseKey.bytes withLength:16];
        
        key.version = [NSString stringWithFormat:@"%@.%@.%@.%@.%@",[resultsDictionary objectForKey:@"protocol_type"],[resultsDictionary objectForKey:@"protocol_version"],[resultsDictionary objectForKey:@"scene"],[resultsDictionary objectForKey:@"group_id"],[resultsDictionary objectForKey:@"org_id"]];
        key.lockmac = lock_mac;
        key.key = lock_key;
        key.roomid = room_id.intValue;
        key.date = date.longLongValue/1000;
        key.lockName = lock_name;
        key.doorName = lock_name;
        key.unlockFlag = unlock_flag.intValue;
//        NSString * keySource = [resultsDictionary objectForKey:@"lockKey"];
//        NSString * keyStr = [SecurityUtil decodeBase64String:keySource];
//        NSData * dynamicNO = [MyUtils EncodeScienerPS:[MyUtils DecodeSharedKeyValue:keyStr]];
        NSLog(@"sDate = %f\neDate = %f\nlock_key = %@\nlock_keySource = %@\n", key.startDate, key.endDate, lock_key, lock_keySource);
        if (key.startDate == 0) {
            key.startDate = [XYCUtils formateDateFromStringToDate:@"200001010000" format:@"yyyyMMddHHmm"].timeIntervalSince1970;
            key.endDate = [XYCUtils formateDateFromStringToDate:@"209912312359" format:@"yyyyMMddHHmm"].timeIntervalSince1970;
        }
      //  else{
         //   key.startDate = sDate.longLongValue/1000;
         //   key.endDate = eDate.longLongValue/1000;
      //  }
        
        return 0;
        
    }
    
    return errcode.intValue;
}

/*
 
 192.168.1.188:8080/openAPI/v1/room/uploadUnlockingRecord?
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 &date=1411955482462
 &room_id=2619
 &success=1
 
 反馈：
 {
 "errcode": 0,
 "errmsg": "none error message"
 }
 */
+(int)uploadUnlockRecord_success:(BOOL)success
                          roomID:(int)roomid
                        clientid:(NSString*)clientid
                     accesstoken:(NSString*)accessToken{
    
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/room/uploadUnlockingRecord?client_id=%@&access_token=%@&date=%@&room_id=%i&success=%i",URL,clientid,accessToken,date,roomid,success];
    
    [MyLog logFormate:@"上传开锁记录url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return NET_REQUEST_ERROR_NO_DATA;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"response:%@",response];
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    
    return errcode.intValue;
    
}



/*
 
 
 192.168.1.188:8080/openAPI/v1/room/getUnlockingRecordsList?
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 &date=1411971767623
 &room_id=2619
 &page_no=1
 
 
 反馈：
 {
 
 "list": 
 [
    {
        "date": 1235545850000,
        "id": 31212,
        "openid": 1841548952,
        "room_id": 2619,
        "success": 1
    }
 ]
 
 }
 
 */
+(NSMutableArray*)requetUnlockRecords_roomID:(int)roomid
                                        page:(int)page
                                    clientid:(NSString*)clientid
                                 accesstoken:(NSString*)accessToken
{
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/room/getUnlockingRecordsList?client_id=%@&access_token=%@&date=%@&page_no=%i&room_id=%i",URL,clientid,accessToken,date,page,roomid];
    
    [MyLog logFormate:@"获取开锁记录url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return Nil;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"response:%@",response];
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    
    if (!errcode) {
        
        NSArray * array = [resultsDictionary objectForKey:@"list"];
        
        NSMutableArray * keyList = [[NSMutableArray alloc]init];
        
        for (NSDictionary* keyItem in array) {
            
            NSNumber * recordid = [keyItem objectForKey:@"id"];
            NSNumber * openid = [keyItem objectForKey:@"openid"];
            NSNumber * success = [keyItem objectForKey:@"success"];
            NSNumber * room_id = [keyItem objectForKey:@"room_id"];
            NSNumber * date = [keyItem objectForKey:@"date"];
            
            UnlockRecord * record = [[UnlockRecord alloc]initWithRecordID:recordid.intValue openID:openid.stringValue success:success.intValue date:[NSDate dateWithTimeIntervalSince1970:date.longLongValue/1000]];
            
            [keyList addObject:record];
            
        }
        
        
        return keyList;
        
    }
    
    return Nil;
    
}

/*
 
 
192.168.1.188:8080/openAPI/v1/room/getUserList?
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 &date=1411955672703
 &room_id=2619
 
 
 反馈：
 {
 "list": [
    {
        "date": 1411897677000,
        "key_id": 6265,
        "key_status": "110402",
        "openid": 1841548952,
        "room_id": 2619
    },
    {
        "date": 1411897677000,
        "key_id": 6266,
        "key_status": "110402",
        "openid": 1841548952,
        "room_id": 2619
    }
 ]
 }

 */
+(NSMutableArray*)requetRoomUsers_roomID:(int)roomid
                                clientid:(NSString*)clientid
                             accesstoken:(NSString*)accessToken
{
    
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/room/getUserList?client_id=%@&access_token=%@&date=%@&room_id=%i",URL,clientid,accessToken,date,roomid];
    
    [MyLog logFormate:@"获取锁用户url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return Nil;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"response:%@",response];
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    
    if (!errcode) {
        
        NSArray * array = [resultsDictionary objectForKey:@"list"];
        
        NSMutableArray * keyList = [[NSMutableArray alloc]init];
        
        for (NSDictionary* keyItem in array) {
            
            NSNumber * key_id = [keyItem objectForKey:@"key_id"];
            NSString * key_status = [keyItem objectForKey:@"key_status"];
            NSNumber * date = [keyItem objectForKey:@"date"];
            NSNumber * openid = [keyItem objectForKey:@"openid"];
            NSNumber * room_id = [keyItem objectForKey:@"room_id"];
            NSNumber * start_date = [keyItem objectForKey:@"start_date"];
            NSNumber * end_date = [keyItem objectForKey:@"end_date"];
            
            UserInfo * user = [[UserInfo alloc]init];
            user.openid = openid.stringValue;
            user.status = key_status;
            user.kid = key_id.stringValue;
            user.date = [NSDate dateWithTimeIntervalSince1970:date.longLongValue/1000];
            user.startDate = [NSDate dateWithTimeIntervalSince1970:start_date.longLongValue/1000];
            user.endDate = [NSDate dateWithTimeIntervalSince1970:end_date.longLongValue/1000];
            user.roomid = room_id.stringValue;
            
            [keyList addObject:user];
        }
        
        return keyList;
        
    }
    
    return Nil;
    
}

/*
 
 请求
192.168.1.188:8080/openAPI/v1/key/freeze?
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 &date=1413013876166
 &room_id=2619
 &key_id=6265
 
 
 反馈
 {"errcode":0,"errmsg":"none error message"}
 
 */
+(int)blockUser_kid:(int)kid
             roomID:(int)roomid
             openid:(NSString*)openid
           clientid:(NSString*)clientid
        accesstoken:(NSString*)accessToken{
    
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/key/freeze?client_id=%@&access_token=%@&openid=%@&date=%@&room_id=%i&key_id=%i",URL,clientid,accessToken,openid,date,roomid,kid];
    
    [MyLog logFormate:@"冻结url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return NET_REQUEST_ERROR_NO_DATA;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"response:%@",response];
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    return errcode.intValue;
    
}
/*
 
 请求
192.168.1.188:8080/openAPI/v1/key/unfreeze?
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 &date=1413014063114
 &room_id=2619
 &key_id=6265
 
 反馈
 {"errcode":0,"errmsg":"none error message"}
 
 */
+(int)unblockUser_kid:(int)kid
               roomID:(int)roomid
               openid:(NSString*)openid
             clientid:(NSString*)clientid
          accesstoken:(NSString*)accessToken{
    
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/key/unfreeze?client_id=%@&access_token=%@&openid=%@&date=%@&room_id=%i&key_id=%i",URL,clientid,accessToken,openid,date,roomid,kid];
    
    [MyLog logFormate:@"解除冻结url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return NET_REQUEST_ERROR_NO_DATA;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"response:%@",response];
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    
    return errcode.intValue;
    
}
/*
 
 请求
 192.168.1.188:8080/openAPI/v1/key/delete?
 client_id=03756eedf35740a1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid=1841548952
 &date=1413014063114
 &room_id=2619
 &key_id=6265
 
 反馈
 {"errcode":0,"errmsg":"none error message"}
 
 */
+(int)deleteUser_kid:(int)kid
              roomID:(int)roomid
              openid:(NSString*)openid
            clientid:(NSString*)clientid
         accesstoken:(NSString*)accessToken{
    
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/key/delete?client_id=%@&access_token=%@&openid=%@&date=%@&room_id=%i&key_id=%i",URL,clientid,accessToken,openid,date,roomid,kid];
    
    [MyLog logFormate:@"delete user url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return NET_REQUEST_ERROR_NO_DATA;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"response:%@",response];
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    
    return errcode.intValue;
    
}

/*
 
 请求
 192.168.1.188:8080/openAPI/v1/user/getUserInfo?
 client_id=03756eedf35740a 1944f5ca1637443db
 &access_token=673274b6d92208d08e4926c74302d795
 &openid =1841548952
 &date=1411955284508
 
 反馈
 {
    "headurl": "http://www.sciener.cn/uploadfiles/images/1034/headiamge.jpg",
    "nickname": "hnye007"
 
 }
 
 */
+(int)requestUserInfo_userinfo:(UserInfo*)user
                      clientid:(NSString*)clientid
                   accesstoken:(NSString*)accessToken{
    
    NSString* date = [XYCUtils GetCurrentTimeInMillisecond];
    NSString * url = [NSString stringWithFormat:@"%@/v1/user/getUserInfo?client_id=%@&access_token=%@&openid=%@&date=%@",URL,clientid,accessToken,user.openid,date];
    
    [MyLog logFormate:@"delete user url:%@", [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    if (data == nil) {
        NSLog(@"send request failed: %@", error);
        return NET_REQUEST_ERROR_NO_DATA;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [MyLog logFormate:@"33333333333333response:%@",response];
    
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* resultsDictionary =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSString * errcode = [resultsDictionary objectForKey:@"errcode"];
    NSString * errmsg = [resultsDictionary objectForKey:@"errmsg"];
    
    NSString * headurl = [resultsDictionary objectForKey:@"headurl"];
    NSString * nickname = [resultsDictionary objectForKey:@"nickname"];
    user.headurl = headurl;
    user.nickname = nickname;
    
    return errcode.intValue;
    
}

@end

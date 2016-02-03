//
//  RequestService.h
//  BTstackCocoa
//
//  Created by wan on 13-3-7.
//
//

#import <Foundation/Foundation.h>
#import "Key.h"
#import "KeyModel.h"
#import "UserInfo.h"

@interface RequestService : NSObject

//+(BOOL)checkNet;


//openid = 用户id
//绑定管理员（/room/bindingAdmin）
+(int)bindLock:(KeyModel*)keyModel
   accessToken:(NSString*)accessToken
      clientId:(NSString*)clientId
 protocol_type:(NSString*)protocol_type
protocol_version:(NSString*)protocol_version
         scene:(NSString*)scene
      group_id:(NSString*)group_id
        org_id:(NSString*)org_id;


//发送电子钥匙
+(int)SendEKey_roomid:(NSString *)roomid
            startDate:(NSString *)startDate
              endDate:(NSString*)endDate
                  key:(NSString*)key
                  mac:(NSString *)mac
              message:(NSString *)message
             clientid:(NSString*)clientid
          accessToken:(NSString*)accessToken
               openid:(NSString*)openid;


//获取电子钥匙列表
+(NSMutableArray*)requestEkeys_clientid:(NSString*)clientid
                            accesstoken:(NSString*)accessToken;


//下载电子钥匙
+(int)downloadEkey_key:(KeyModel*)key
              clientid:(NSString*)clientid
           accesstoken:(NSString*)accessToken;

//上传开锁记录
+(int)uploadUnlockRecord_success:(BOOL)success
                          roomID:(int)roomid
                        clientid:(NSString*)clientid
                     accesstoken:(NSString*)accessToken;

//开锁记录
+(NSMutableArray*)requetUnlockRecords_roomID:(int)roomid
                                        page:(int)page
                                    clientid:(NSString*)clientid
                                 accesstoken:(NSString*)accessToken;

//锁用户
+(NSMutableArray*)requetRoomUsers_roomID:(int)roomid
                                clientid:(NSString*)clientid
                             accesstoken:(NSString*)accessToken;

//解除冻结
+(int)unblockUser_kid:(int)kid
               roomID:(int)roomid
               openid:(NSString*)openid
             clientid:(NSString*)clientid
          accesstoken:(NSString*)accessToken;

//冻结
+(int)blockUser_kid:(int)kid
             roomID:(int)roomid
             openid:(NSString*)openid
           clientid:(NSString*)clientid
        accesstoken:(NSString*)accessToken;

//删除
+(int)deleteUser_kid:(int)kid
              roomID:(int)roomid
              openid:(NSString*)openid
            clientid:(NSString*)clientid
         accesstoken:(NSString*)accessToken;

//获取用户信息
+(int)requestUserInfo_userinfo:(UserInfo*)user
                      clientid:(NSString*)clientid
                   accesstoken:(NSString*)accessToken;
@end

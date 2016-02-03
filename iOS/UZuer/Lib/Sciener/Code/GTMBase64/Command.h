//
//  Command.h
//  BTstackCocoa
//
//  Created by wan on 13-2-22.
//
//

#import <Foundation/Foundation.h>

#define Version_Lock_v1 1
#define Version_Lock_v2 3
#define Version_Lock_v3 4
#define Version_Lock_v4 5
#define Version_Lock_v2_AES 7
#define Version_Lock_v4_1 6
#define Version_Lock_v3_AES 5   // aes加密的command

#define Version_PARK_Lock_v1 0x0a   //车位锁


#define COMM_RESPONSE                       'T'
#define COMM_INITIALIZATION                 'E'

#define COMM_ADMIN_VERIFICATION             'F'
#define COMM_CHECK_UNLOCK_PERMISSION        'G'
#define COMM_SET_MANUAL_LOCK                'M'
#define COMM_MANUAL_LOCK_PASSWAORD          'P'
#define COMM_UPDATE_BLUETOOTH_INFO          'N'
#define COMM_ADD_USER                       'A'
#define COMM_ADD_ADMIN                      'V'
#define COMM_DELETE_USER                    'D'
#define COMM_GET_USER                       'W'
#define COMM_SET_AUTO_LOCK                  'S'
#define COMM_REQUEST_UNLOCK                 'L'
#define COMM_UNLOCK_FEEDBACK                'U'
#define COMM_READ_RECORD_COUNT              'H'
#define COMM_READ_UNLOCK_RECORDS            'R'
#define COMM_CLEAR_RECORDS                  'C'
#define COMM_UNLOCK_COMPLETED               'Y'
#define COMM_SEND_DYNAMIC_PASSWORD          'J'
#define COMM_LOCK_SETTINGS                  'Z'
#define COMM_LOCK_BLUETOOTH_SHUT_DOWN       'B'


//lock v2 , v4.1
#define V2_COMM_LOCK_ADD_ADMIN              'V'
#define V2_COMM_LOCK_CHECK_ADMIN            'A'
#define V2_COMM_LOCK_UNLOCK                 'G'
#define V2_COMM_LOCK_TIME_CALIBRATION       'C'
#define V2_COMM_LOCK_SET_ADMIN_PS           'S'
#define V2_COMM_LOCK_SET_USER_PS            'P'
#define V2_COMM_LOCK_CHECK_USER_TIME        'U'
#define V4_1_COMM_LOCK_RESET                'R'

//lock v4
#define  V4_COMM_LOCK_ADD_ADMIN             'V'
#define  V4_COMM_LOCK_CHECK_ADMIN           'A'
#define  V4_COMM_LOCK_UNLOCK                'G'
#define  V4_COMM_LOCK_TIME_CALIBRATION      'C'
#define  V4_COMM_LOCK_CHECK_USER_TIME       'U'
#define  V4_COMM_LOCK_SET_ADMIN_PS          'S'
#define  V4_COMM_LOCK_SET_ADMIN_DEL_PS      'D'
#define  V4_COMM_LOCK_INIT_PS               'I'
#define  V4_COMM_LOCK_SERIAL_NUMBER         'J'

//park lock v1 功能和v2家用锁基本相同，多了获取锁状态，增加关指令
#define PARK_LOCK_V1_COMM_ADD_ADMIN              'V'
#define PARK_LOCK_V1_COMM_CHECK_ADMIN            'A'
#define PARK_LOCK_V1_COMM_UNLOCK                 'G'
#define PARK_LOCK_V1_COMM_TIME_CALIBRATION       'C'
//#define PARK_LOCK_V1_COMM_SET_ADMIN_PS           'S'
//#define PARK_LOCK_V1_COMM_SET_USER_PS            'P'
#define PARK_LOCK_V1_COMM_CHECK_USER_TIME        'U'
#define PARK_LOCK_V1_COMM_RESET                  'R'
#define PARK_LOCK_V1_COMM_GET_STATE              'B'
#define PARK_LOCK_V1_COMM_LOCK                   'L'
#define PARK_LOCK_V1_COMM_RENAME                 'N'
#define PARK_LOCK_V1_COMM_WARN_RECORD            'W'

#define LOCK_V3_COMM_ADD_ADMIN              'V'
#define LOCK_V3_COMM_CHECK_ADMIN            'A'
#define LOCK_V3_COMM_UNLOCK                 'G'
#define LOCK_V3_COMM_TIME_CALIBRATION       'C'
#define LOCK_V3_COMM_CHECK_USER_TIME        'U'
#define LOCK_V3_COMM_RESET                  'R'
#define LOCK_V3_COMM_GET_STATE              'B'
#define LOCK_V3_COMM_LOCK                   'L'
#define LOCK_V3_COMM_RENAME                 'N'
#define LOCK_V3_COMM_WARN_RECORD            'W'
#define LOCK_V3_COMM_SET_ADMIN_PS           'S'
#define LOCK_V3_COMM_FETCH_AES_KEY          0x19
#define LOCK_V3_COMM_USER_PS_SET_DEL        0x03
#define LOCK_V3_COMM_FETCH_USER_PS_LIST     0x04


@interface Command : NSObject
{
    
@public
    Byte header[2];	// 帧首 		2 字节
//	Byte reserved;	// 预留	 	1 字节    （lcokV1,lockV2,lightV1中表示版本号）
    Byte protocolCategory;  //协议类别  1字节 （lcokV1,lockV2,lightV1中表示版本号）
    Byte protocolVersion;   //协议版本  1字节
    Byte applyCatagory;     //应用类别  1字节     （场景）
    Byte applyID[2];           //应用id    2字节
    Byte applyID2[2];          //应用子id  2字节
	Byte command;	// 命令字 	1 字节
	Byte encrypt;	// 加密字		1 字节
//	Byte length;	// 长度		1 字节
	Byte data[256];	// 数据
	Byte checksum;	// 校验		1 字节
	
    BOOL mIsChecksumValid;

    Byte length;	// 长度		1 字节
//    Byte *commandWithoutChecksum;  //全部指令;
}

-(void)commandWithProtocolCategory:(Byte)protocolCategoryT protocolVersion:(Byte)protocolVersionT applyCatagory:(Byte)applyCatagoryT applyID:(Byte*)applyIDT applyID2:(Byte*)applyID2T;

-(void)commandWithVersion:(Byte)lockVersion;

-(void)command:(Byte*)commandByte withLength:(int)length;
-(void)test;

-(void)setCommand:(Byte)commandToSet;

-(Byte)getCommand;

/**老的加密
 */
-(void)setData:(Byte*)dataToSet withLength:(int)dataLength;

/**aes加密
 */
-(void)setDataAES:(Byte*)dataToSet withLength:(int)dataLength key:(Byte*)pwdKey;

-(Byte*)getData;

-(Byte*)getDataAes_pwdKey:(Byte*)pwdKey;
-(Byte*)getDataAes_pwdKeyStr:(NSString*)pwdKey;

//-(void)buildCommand;
-(void)buildCommand:(Byte*)data withLength:(int)length;
@end

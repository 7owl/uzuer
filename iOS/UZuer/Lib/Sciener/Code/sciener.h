//
//  sciener.h
//  sciener
//
//  当前版本：r1.0.0
//
//  Created by 谢元潮 on 14-4-25.
//  Copyright (c) 2014年 谢元潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>

//TODO 需要删除这个
#define fileServiceString       @"1910"
#define fileSubWriteString      @"fff2"
#define fileSubReadString       @"fff4"
#define fileService             0x1910
#define fileSubWrite            0xfff2
#define fileSubRead             0xfff4

//开放平台接口
//#define requestUrl  @"http://open.sciener.cn"

//错误码
typedef NS_ENUM(NSInteger, ScienerError)
{
    ScienerErrorNormal = -1,
    ScienerErrorNoMemory = -2,                          //存储空间不足, 超出保存用户的最大数量
    ScienerErrorAdminExist = -3,                        //管理员已存在，需要清空才能继续添加
    ScienerErrorTimeOut = -4,                           //ekey过期
    ScienerErrorNoPermisston = -5,                      //身份校验失败
    ScienerErrorInSettingMode = -6,                     //处于设置模式
    ScienerErrorNotSupportV1 = -7,                      //不支持v1版本多锁
    ScienerErrorSetAdminKeyboardPasswordFailed = -8,    //设置管理员无钥匙密码失败
    ScienerErrorUnlockFail = -9,                        //开锁指令失败
    ScienerErrorCalibationTimeFail = -10,               //校准时间失败
    ScienerErrorAesKey = -11,                           //获取aes加密字错误
    ScienerErrorGetKeyboardPasswordFailed = -12,        //获取键盘密码出错
    ScienerErrorKeyboardPasswordOperatFailed = -13,     //键盘密码操作出错
    ScienerErrorGetLockDetail = -14,                    //获取锁信息出错
    ScienerErrorRenameLock = -15,                       //重命名锁失败
    ScienerErrorResetLock = -16,                        //重置锁失败
    ScienerErrorDataCRCError = -17,                     //CRC校验出错
    ScienerErrorUnlockFlagError = -18,                  //开门标志位错误
    ScienerErrorSet900Ps = -19,                         //设置900密码
    ScienerErrorUpdateKeyboardIndex = -20,              //更新键盘密码序列出错
    ScienerErrorAdminCheck = -21,                       //管理员身份检测失败
    ScienerErrorEkeyCheck = -22,                        //ekey身份检测失败
    ScienerErrorDeletePsEqualAdminPs = -23,             //删除密码和管理员密码相同
    ScienerErrorNoAdmin = -24,                          //不存在管理员
    ScienerErrorIsNotSettingMode = -25,        //处于非设置模式
};

typedef NS_ENUM(NSInteger, KeyboardPsType)
{
    KeyboardPsTypeNone = -1,            //不确定类型
    KeyboardPsTypeNormalAll_Date = 1,
    KeyboardPsTypeLimitTimes = 2,
    KeyboardPsTypeLimitDate = 3
};

//一些回调
@protocol ScienerSDKDelegate <NSObject>

//授权回调
-(void)scienerDidLogin:(NSString*)errcode;

//相关回调
-(void)scienerError:(ScienerError)error;

//-(void)gotLockVersion:(int)version;
-(void)gotLockVersion:(NSString*)versionStr;
-(void)addAdminSuccess_password:(NSString*)password key:(NSString*)key aesKey:(NSData*)aesKeyData version:(NSString*)versionStr mac:(NSString*)mac;
-(void)calibationTimeSuccess;
-(void)unlockSuccess;
-(void)setAdminKeyboardPasswordSuccess;
-(void)setAdminDeleteKeyboardPasswordSuccess;
-(void)setUserKeyBoardPasswordSuccess;
-(void)clearUserKeyBoardPasswordSuccess;
-(void)deleteUserKeyBoardPasswordSuccess;
-(void)clearLockSuccess;    //清空锁
-(void)renameLockSuccess;   //重命名
-(void)getKeyboardPs_type:(KeyboardPsType)type password:(NSString*)password times:(int)times startDate:(NSDate*)startDate endDate:(NSDate*)endDate isLast:(BOOL)isLast;   //获取到键盘密码
-(void)getPower:(float)power; //电量
-(void)getLockKeyboardPsIndex:(int)index group:(int)group; //键盘密码序列设置失败，返回正确的序列
-(void)setKeyboardPsSuccess:(float)progress;//初始化键盘密码的进度
/**
 * psArray中按照如下顺序规则返回数据
 * 300个1天密码       (  0~300 1xxxxx)
 * 150个2天密码       (300~450 2xxxxx)
 * 100个3天密码       (450~550 3xxxxx)
 * 100个4天密码       (550~650 4xxxxx)
 *  50个5天密码       (650~700 5xxxxx)
 *  50个6天密码       (700~750 6xxxxx)
 *  50个7天密码       (750~800 7xxxxx)
 * 100个10分钟密码    (800~900 8xxxxx)
 */
-(void)setkeyboardPsFinish:(NSArray*)psArray;


//蓝牙搜索，连接相关回调
-(void)peripheralFound:(CBPeripheral *)peripheral RSSI:(NSNumber*)rssi lockName:(NSString*)lockName mac:(NSString*)mac advertisementData:(NSDictionary *)advertisementData;
-(void)setConnect:(CBPeripheral *)peripheral lockName:(NSString*)lockName;
-(void)setDisconnect:(NSString*)lockName;

@end





//---------------------------接口--------------------------

//以下是接口
@interface Sciener : NSObject<CBPeripheralDelegate>

//TODO 需要删除这个
@property (nonatomic, assign) id <ScienerSDKDelegate> delegate;
@property (nonatomic, copy) NSString * accessToken;
@property (nonatomic, copy) NSString * openID;
@property (nonatomic, copy) NSString * expiresIn;


//TODO 需要删除这个
+ (Sciener *)shared;

/**初始化科技侠类
 * @param appID
 * @param appSecret
 * @param redirectUri
 * @param scienerDelegate
 * @return
 */
-(id)initWithAppId:(NSString *)appID appSecret:(NSString *)appSecret redirectUri:(NSString *)redirectUri delegate:(id<ScienerSDKDelegate>)scienerDelegate;

/**第三方登录
 */
-(void)authorize;

/**处理科技侠登录后的返回
 * @param url
 * @return
 */
-(void)HandleOpenURL:(NSURL *)url;



//-------------蓝牙操作---------------

/** 启动蓝牙
 * @param
 * @return
 */
-(void)setupBlueTooth;

/** 开始扫描附近的蓝牙
 * @param
 * @return
 */
-(void)scan;

/** 停止扫描附近的蓝牙
 * @param
 * @return
 */
-(void)stopScan;

/** 连接蓝牙
 * @param peripheral
 * @return
 */
-(void)connect:(CBPeripheral *)peripheral;

/** 断开蓝牙连接
 * @param peripheral
 * @return
 */
-(void) disconnect:(CBPeripheral *)peripheral;

/** 获取锁版本
 * @param
 * @return
 */
-(void)getLockVersion_advertisementData:(NSDictionary *)advertisementData;

/** 添加管理员
 * @param
 * @return
 */
-(void)addAdmin_advertisementData:(NSDictionary *)advertisementData;

/** 管理员开锁,v2版本的锁
 * @param password
 * @param key
 * @return
 */
-(void)unlockAdmin_password:(NSString*)password key:(NSString*)key aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** eKey开锁
 * @param key
 * @param startDate
 * @param endDate
 * @return
 */
-(void)unlockEKey_key:(NSString*)key startDate:(NSDate*)startDate endDate:(NSDate*)endDate aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** 设置管理员的键盘密码
 * @param keyboardPassword
 * @param key
 * @param password
 * @return
 */
-(void)setAdminKeyBoardPassword:(NSString*)keyboardPassword key:(NSString*)key password:(NSString*)password aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;


/** 设置管理员的删除键盘密码
 * @param delKeyboardPassword
 * @param key
 * @param password
 * @return
 */
-(void)setAdminDeleteKeyBoardPassword:(NSString*)delKeyboardPassword key:(NSString*)key password:(NSString*)password aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** 设置用户的键盘密码
 * @param keyboardPassword
 * @param key
 * @param password
 * @param psType
 * @param startDate
 * @param endDate
 * @param times
 * @return
 */
-(void)setUserKeyBoardPassword:(NSString*)keyboardPassword key:(NSString*)key password:(NSString*)password psType:(KeyboardPsType)psType startDate:(NSDate*)startDate endDate:(NSDate*)endDate times:(int)times aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** 清空用户键盘密码
 * @param password
 * @param key
 * @return
 */
-(void)clearUserKeyboardPs_password:(NSString*)password key:(NSString*)key aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** 获取用户键盘密码
 * @param password
 * @param key
 * @return
 */
-(void)getUserKeyboardPs_password:(NSString*)password key:(NSString*)key aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** 删除用户键盘密码
 * @param password
 * @param key
 * @return
 */
-(void)deleteUserKeyboardPs_password:(NSString*)password key:(NSString*)key keyboardPsDeli:(NSString*)keyboardPsDeli psType:(KeyboardPsType)psType aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** 恢复出厂设置
 * @param password
 * @param key
 * @return
 */
-(void)resetLock_password:(NSString*)password key:(NSString*)key aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** 校准锁的时钟，和当前使用手机时间一致
 * @param password
 * @param key
 * @return
 */
-(void)calibationTime_password:(NSString*)password key:(NSString*)key aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** 初始化用户键盘密码，2s
 * @param password
 * @param key
 * @return
 */
-(void)initUserKeyboardPS_password:(NSString*)password key:(NSString*)key aesKey:(NSData*)aesKey version:(NSString*)version unlockFlag:(int)flag;

@end


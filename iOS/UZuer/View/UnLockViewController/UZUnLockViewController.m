//
//  UZUnLockViewController.m
//  UZuer
//
//  Created by CaydenK on 15/9/14.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZUnLockViewController.h"
#import "sciener.h"
#import "Key.h"
#import "RequestService.h"
#import "DBHelper.h"
#import <Aspects.h>
#import "UZAppDelegate.h"
#import "RequestService.h"
#import "UZWebBridge.h"
#import <MBProgressHUD.h>
#import "RequestService.h"
#import "XYCUtils.h"

static NSString *unlockPwdKey = @"uzunlockpassword";

@interface UZUnLockViewController ()<ScienerSDKDelegate,UIAlertViewDelegate>{
    UIAlertView * alertView;
}

@property (strong, nonatomic) Sciener* science;

//FIXME: 此处本地化不合适，所以移除本地存储有关代码了
@property (strong, nonatomic) NSArray *lockArray;
@property (strong, nonatomic) NSMutableArray *eKeyArray;
@property (strong, nonatomic) KeyModel *currentKey;

@property (assign, nonatomic) NSInteger connectType;
@property (copy, nonatomic) NSString *tempUnlockPassword;

@end

@implementation UZUnLockViewController
@synthesize science;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"智能开锁";
    self.eKeyArray = @[].mutableCopy;
    
    science = [[Sciener alloc]initWithAppId:kScienerAppID appSecret:kScienerAppSecret redirectUri:kScienerRedirectURL delegate:self];
    [science setupBlueTooth];
    [UZAppDelegate aspect_hookSelector:@selector(applicationDidEnterBackground:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        [self delegate:[aspectInfo instance] applicationDidEnterBackground:[[aspectInfo arguments] lastObject]];
    } error:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    science.openID = [UZUserBase shareInstance].openid;
//    science.accessToken = [UZUserBase shareInstance].access_token;
//    science.expiresIn = [UZUserBase shareInstance].expires_in;
    [self loadDataSource];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.currentKey = nil;
    self.lockArray = nil;
    self.eKeyArray = @[].mutableCopy;
}

- (void)loadDataSource {
//    KeyModel *ekey = [KeyModel new];
//    ekey.kid = 31573;
//    ekey.roomid = 3106;
//    int resultCode = [RequestService downloadEkey_key:ekey clientid:kScienerAppID accesstoken:[UZUserBase shareInstance].access_token];
//    self.currentKey = ekey;
//
//    return;
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UZWebBridge asyncPOSTgetLockAndKeyWithSuccess:^(id responseDict) {
        DLog(@"%@",responseDict);
        weakSelf.lockArray = [[responseDict objectForKey:@"data"] analyseJson];
        dispatch_queue_t queue = dispatch_queue_create("com.supin.uzuer.download_ekey_queue", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            [weakSelf.lockArray enumerateObjectsUsingBlock:^(NSDictionary *lockDict, NSUInteger idx, BOOL *stop) {
//                KeyModel *ekey = [[KeyModel alloc] initWithDictionary:lockDict];
                KeyModel *ekey = [KeyModel new];
                ekey.lockName = lockDict[@"lockName"];
                ekey.mac = lockDict[@"lockmac"];
                ekey.lockmac = lockDict[@"lockmac"];

                ekey.desc = lockDict[@"desc1"];
                ekey.kid = [lockDict[@"key_id"] intValue];
                ekey.roomid = [(lockDict[@"roomid"]?:lockDict[@"room_id"]) intValue];
                ekey.sciener_is_freeze = [lockDict[@"sciener_is_freeze"] integerValue];
                
                
                DLog(@"%i,%i",ekey.kid,ekey.roomid);
                
                int resultCode = [RequestService downloadEkey_key:ekey clientid:kScienerAppID accesstoken:[UZUserBase shareInstance].access_token];
                if (!resultCode) {
                    DLog(@"%@",ekey.mac);
                    DLog(@"%@",lockDict);
                    
                    [weakSelf.eKeyArray addObject:ekey];
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [CKAlert showAlertWithMsg:@"下载电子钥匙失败！"];
                    });
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            });
        });
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        DLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)unlockDoorAction:(id)sender{
    self.connectType = 0;
    [science scan];
}

- (IBAction)modifyUnlockPasswordAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"开锁密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    UITextField *unlockPasswordTextField = [alert textFieldAtIndex:0];
    unlockPasswordTextField.placeholder = @"开锁密码";
    unlockPasswordTextField.secureTextEntry = NO;
    unlockPasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
    unlockPasswordTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:unlockPwdKey]?:@"";
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        UITextField *unlockPasswordTextField = [alertView textFieldAtIndex:0];
        if (![XYCUtils checkNokeyPassword:unlockPasswordTextField.text ok4Zero:YES]) {
            [CKAlert showAlertWithMsg:@"密码输入错误"];
            return ;
        }
        self.connectType = 1;
        [self.science scan];
        self.tempUnlockPassword = unlockPasswordTextField.text;
    }
}

- (void)delegate:(UZAppDelegate *)delegate  applicationDidEnterBackground:(UIApplication *)application {
    if (science) {
        [science stopScan];
    }
}

-(void)scienerError:(ScienerError)error
{
    [[[UIAlertView alloc]initWithTitle:@"失败" message:[NSString stringWithFormat:@"scienerError:%li",(long)error] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
}

-(void)calibationTimeSuccess
{
    DLog(@"校准时间成功");
}

-(void)unlockSuccess
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^(void){
        [RequestService uploadUnlockRecord_success:YES roomID:self.currentKey.roomid clientid:kScienerAppID accesstoken:science.accessToken];
    });
}

//蓝牙搜索，连接相关回调
-(void)peripheralFound:(CBPeripheral *)peripheral RSSI:(NSNumber*)rssi lockName:(NSString*)lockName mac:(NSString*)mac advertisementData:(NSDictionary*)advertisementData
{
//    [self.science connect:peripheral];
//    return;
    
    DLog(@"rssi:%@",rssi);
    DLog(@"lockName:%@",lockName);
    DLog(@"mac:%@",mac);
    DLog(@"advertisementData:%@",advertisementData);
    __weak typeof(self) weakSelf = self;
    [self.eKeyArray enumerateObjectsUsingBlock:^(KeyModel *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.lockName isEqualToString:lockName] || [obj.mac isEqualToString:mac]) {
            DLog(@"正确选择钥匙");
            weakSelf.currentKey = obj;
            
            if (weakSelf.currentKey.sciener_is_freeze == 1) {
                [CKAlert showAlertWithMsg:@"本钥匙已被冻结，请联系客服"];
//                [science disconnect:peripheral];
            }
            else {
                [weakSelf.science connect:peripheral];
            }
            *stop = YES;
        }
    }];
}

-(void)setConnect:(CBPeripheral *)peripheral lockName:(NSString*)lockName
{
    if (self.currentKey) {
        if (self.connectType == 0) {
            DLog(@"开锁指令发送");
                [science unlockEKey_key:self.currentKey.key startDate:[NSDate dateWithTimeIntervalSince1970:self.currentKey.startDate] endDate:[NSDate dateWithTimeIntervalSince1970:self.currentKey.endDate] aesKey:self.currentKey.aseKey version:self.currentKey.version unlockFlag:self.currentKey.unlockFlag];
                [CKAlert showAlertWithMsg:@"开锁成功！"];
        }
        else if (self.connectType == 1) {
            [self.science setUserKeyBoardPassword:self.tempUnlockPassword
                                              key:self.currentKey.key
                                         password:self.currentKey.password
                                           psType:3 //期限密码
                                        startDate:[NSDate dateWithTimeIntervalSince1970:self.currentKey.startDate]
                                          endDate:[NSDate dateWithTimeIntervalSince1970:self.currentKey.endDate]
                                            times:0
                                           aesKey:self.currentKey.aseKey
                                          version:self.currentKey.version
                                       unlockFlag:self.currentKey.unlockFlag];
            [CKAlert showAlertWithMsg:@"设置密码成功！"];
            [[NSUserDefaults standardUserDefaults] setValue:self.tempUnlockPassword forKey:unlockPwdKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}
-(void)setDisconnect:(NSString*)lockName
{
    if (self.connectType == 0) {
        [CKAlert showAlertWithMsg:@"未连接到锁，开锁失败！"];
    }
    else {
        [CKAlert showAlertWithMsg:@"未连接到锁，设置密码失败！"];
    }
}

//FIXME: 所有回调必须写全，不然会Crash
//授权回调
-(void)scienerDidLogin:(NSString*)errcode{}

//-(void)gotLockVersion:(int)version;
-(void)gotLockVersion:(NSString*)versionStr{}
-(void)addAdminSuccess_password:(NSString*)password key:(NSString*)key aesKey:(NSData*)aesKeyData version:(NSString*)versionStr mac:(NSString*)mac{}
-(void)setAdminKeyboardPasswordSuccess{}
-(void)setAdminDeleteKeyboardPasswordSuccess{}
-(void)setUserKeyBoardPasswordSuccess{}
-(void)clearUserKeyBoardPasswordSuccess{}
-(void)deleteUserKeyBoardPasswordSuccess{}
-(void)clearLockSuccess{}    //清空锁
-(void)renameLockSuccess{}   //重命名
-(void)getKeyboardPs_type:(KeyboardPsType)type password:(NSString*)password times:(int)times startDate:(NSDate*)startDate endDate:(NSDate*)endDate isLast:(BOOL)isLast{}  //获取到键盘密码
-(void)getPower:(float)power{}//电量
-(void)getLockKeyboardPsIndex:(int)index group:(int)group{} //键盘密码序列设置失败，返回正确的序列
-(void)setKeyboardPsSuccess:(float)progress {}//初始化键盘密码的进度
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
-(void)setkeyboardPsFinish:(NSArray*)psArray {}


@end

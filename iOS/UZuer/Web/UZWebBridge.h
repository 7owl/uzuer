//
//  UZWebBridge.h
//  GameCenter
//
//  Created by CaydenK on 15/6/11.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UZWebRequest.h"
#import <MapKit/MKUserLocation.h>

//合同类型
typedef NS_ENUM(NSInteger,ContractType){
    ContractTypeYa1Fu3 = 1,
    ContractTypeFenQi = 2
};

#pragma mark
#pragma mark - 后台接口
/**
 *  网络请求成功的回调
 *
 *  @param responseDict 请求成功后的数据
 */
typedef void(^UZWebRequestObj)(id responseDict);
/**
 *  网络请求成功的回调
 *
 *  @param responseArray 请求成功后的数据
 */
typedef void(^UZWebRequestArray)(NSArray *responseArray);
/**
 *  网络请求失败的回调
 *
 *  @param error 请求失败的error
 */
typedef void(^UZWebRequestFailure)(NSError *error);

/**
 *  网络请求桥接
 */
@interface UZWebBridge : NSObject

/**
 *  拼接url地址
 */
NSString *UrlByPath(NSString *path);

/**
 *  请求短信验证码
 *
 *  @param telName 手机号码
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 *
 *  @return 请求
 */
+ (UZWebRequest *)asyncPOSTRequestSmsCode:(NSString *)telName
                              success:(UZWebRequestObj)success
                              failure:(UZWebRequestFailure)failure;
/**
 *  登陆注册
 */
+ (UZWebRequest *)asyncPOSTTenantSave:(NSString *)telName smsCode:(NSString *)smsCode
                                        success:(UZWebRequestObj)success
                                        failure:(UZWebRequestFailure)failure;

/**
 *  修改用户详情
 */
+ (UZWebRequest *)asyncPOSTTenantEdit:(NSDictionary *)tenantDict
                               success:(UZWebRequestObj)success
                               failure:(UZWebRequestFailure)failure;
/**
 *  推荐房源列表
 *
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 *
 *  @return 请求
 */
+ (UZWebRequest *)asyncPOSTgetFeaturedListWithSuccess:(UZWebRequestArray)success
                                              failure:(UZWebRequestFailure)failure;
/**
 *  关键字搜索小区
 *
 *  @param aKeyWord 关键字
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 *
 *  @return 请求
 */
+ (UZWebRequest *)asyncPOSTgetFeaturedListWithKeyWord:(NSString *)aKeyWord
                                              success:(UZWebRequestArray)success
                                              failure:(UZWebRequestFailure)failure;

/**
 *  根据小区搜索房源
 */
+ (UZWebRequest *)asyncPOSTGetRoomListWithKeyWord:(NSString *)aKeyWord curPage:(NSUInteger)curPage filter:(NSDictionary *)filterDict sort:(NSDictionary *)sortDict success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;

/**
 *  获取房源详情
 */
+ (UZWebRequest *)asyncPOSTGetRoomDetailWithRoomId:(NSUInteger)roomId
                                          success:(UZWebRequestObj)success
                                          failure:(UZWebRequestFailure)failure;

/**
 *  添加房源到我的中意清单
 */
+ (UZWebRequest *)asyncPOSTAddRoomToFavoriteListWithRoomId:(NSUInteger)roomId
                                           success:(UZWebRequestObj)success
                                           failure:(UZWebRequestFailure)failure;
/**
 *  与服务端同步数据
 *
 *  @param cid     个推id
 */
+ (UZWebRequest *)asyncPOSTGetTenantDetailWithClientID:(NSString *)cid deviceToken:(NSString *)deviceToken success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;
/**
 *  中意列表查询
 */
+ (UZWebRequest *)asyncPOSTfavoriteListQueryWithSuccess:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;

/**
 *  根据经纬度坐标和半径获得小区名和未出租的房子的数量
 */

/**
 *  根据经纬度坐标和半径获得小区名和未出租的房子的数量
 *
 *  @param distance 传0 ，使用服务器默认距离 //单位米
 *  @param coor     经纬度
 */
+ (UZWebRequest *)asyncPOSTCommunityByDistance:(CGFloat)distance coor:(CLLocationCoordinate2D)coor success:(UZWebRequestArray)success failure:(UZWebRequestFailure)failure;
/**
 *  用户反馈
 *
 *  @param content 反馈内容
 */
+ (UZWebRequest *)asyncPOSTUserFeedBackWithContent:(NSString *)content success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;


/**
 *  上传身份认证资料
 *
 *  @param name       姓名
 *  @param cardNumber 身份证
 *  @param images     图片（成员UIImage）
 */
+ (UZWebRequest *)asyncPOSTRealNameAuthenticationWithName:(NSString *)name cardNumber:(NSString *)cardNumber image:(UIImage *)image success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;

/**
 * 数据库里生产对应合同记录 ，拆分订单
 *  @param constractType  值为： '押一付三','分期付款'
 */
+ (UZWebRequest *)asyncPOSTSignConstractWithRoomId:(NSInteger)roomId constractType:(ContractType)constractType success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;

/**
 *  获取合同的预览地址
 */
+ (UZWebRequest *)asyncPOSTPreviewContractWithContractNo:(NSString *)contractNo success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;

/**
 *  获取合同列表
 */
+ (UZWebRequest *)asyncPOSTContractByTenantIdSuccess:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;

/**
 *  获取订单列表
 */
+ (UZWebRequest *)asyncPOSTOrderlistByContractId:(NSInteger)contractId Success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;
/**
 *  读取用户对应的锁和钥匙信息
 */
+ (UZWebRequest *)asyncPOSTgetLockAndKeyWithSuccess:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;

/**
 *  解绑用户和cid（用于退出登录的时候解绑用户相关推送）
 */
+ (UZWebRequest *)asyncPOSTUnbundlingSuccess:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure;

@end

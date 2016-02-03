//
//  UZWebBridge.m
//  GameCenter
//
//  Created by CaydenK on 15/6/11.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZWebBridge.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "UZOperationQueue.h"
#import "UZReachability.h"
#import "CKModel.h"
#import "UUIDCenter.h"
#import "UZLocationManager.h"
#import "NSDictionary+UZParams.h"
#import "UUIDCenter.h"
#import "UZCommunity.h"

#define PLATFORM @"2"
#define AUTH_DICT @{@"uid":@(UID).stringValue,@"platform":PLATFORM,@"version":UZAppVersion,@"token":TOKEN,@"packageName":UZAppBundleIdentifier}

@implementation UZWebBridge

#pragma mark - 请求 url
NSURL *ServerName()
{
#ifdef DEBUG
    return [NSURL URLWithString:@"http://repo.uzuer.com:8080/"];
#else
    return [NSURL URLWithString:@"http://api.uzuer.com:8080"];
#endif
}

NSString *UrlByPath(NSString *path){
    return [ServerName() URLByAppendingPathComponent:path].absoluteString;
}

#pragma mark - 后台接口
/**
 *  请求短信验证码
 *
 *  @param telName 手机号码
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 *
 *  @return 请求
 */
+ (UZWebRequest *)asyncPOSTRequestSmsCode:(NSString *)telName success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    if (!telName) {
        return nil;
    }
    NSDictionary *dict = @{@"tel_number":telName}.mutableCopy;
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/sms/requestSmsCode") parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}


+ (UZWebRequest *)asyncPOSTTenantSave:(NSString *)telName smsCode:(NSString *)smsCode success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    if (!telName && !smsCode) {
        return nil;
    }
    NSDictionary *dict = @{@"tel_number":telName,@"smsCode":smsCode}.mutableCopy;
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/tenant/save") parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}
/**
 *  修改用户详情
 *
 *  @param tenantDict @{
                                            "id": 42,//修改的时候,把用户的id值我给我
                                             "username": "tenant1",
                                             "pwd": "123",
                                             "first_name": "竺1",
                                             "last_name": "哈1",
                                             "tel_number": "11111111112",
                                             "email": "112@qq.com",
                                             "id_card": "111111111111111112",
                                             "native_place": "浙江省杭州市2",
                                             "work_unit": "华为2",
                                             "work_place": "华为科技园2",
                                             "work_place_number": "0000-00000002",
                                        }
 */
+ (UZWebRequest *)asyncPOSTTenantEdit:(NSDictionary *)tenantDict success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    if (!tenantDict) {
        return nil;
    }

    NSMutableDictionary *dict = tenantDict.mutableCopy;
    [dict setObject:[tenantDict objectForKey:@"uid"] forKey:@"id"];
    [dict removeObjectForKey:@"uid"];
    
    NSDictionary *parametersDict = @{
                                     @"tenant":[dict getJson],
                                     };
    
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/tenant/edit") parameters:parametersDict.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}
/**
 *  推荐房源接口
 *
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 *
 *  @return 请求
 */
+ (UZWebRequest *)asyncPOSTgetFeaturedListWithSuccess:(UZWebRequestArray)success failure:(UZWebRequestFailure)failure
{
    NSDictionary *params = @{@"cityid":[UZLocationManager shareManager].currentArea, @"version":UZAppVersion,@"platform":PLATFORM,@"auth":[AUTH_DICT getJson]};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/room/getFeaturedList") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0 && success) {
                NSArray *roomDictArray = responseObject[@"data"];
                NSArray *roomArray = [NSClassFromString(@"UZRecommendRoom") modelsWithDictionarys:roomDictArray];
                success(roomArray);
        }
        if (code != 0) {
            [CKAlert showAlertWithMsg:responseObject[@"msg"]];
            !failure?:failure(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

/**
 *  小区名称查询接口
 */
+ (UZWebRequest *)asyncPOSTgetFeaturedListWithKeyWord:(NSString *)aKeyWord success:(UZWebRequestArray)success failure:(UZWebRequestFailure)failure
{
    if (!aKeyWord) {
        return nil;
    }
    NSDictionary *params = @{@"comm_name":aKeyWord};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/community/getCommunityByName") parameters:params.cityInfo.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0 && success) {
            NSArray *roomDictArray = responseObject[@"data"];
            NSArray *roomArray = [NSClassFromString(@"UZCommunity") modelsWithDictionarys:roomDictArray];
            success(roomArray);
        }
        if (code != 0) {
            [CKAlert showAlertWithMsg:responseObject[@"msg"]];
            !failure?:failure(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTGetRoomListWithKeyWord:(NSString *)aKeyWord curPage:(NSUInteger)curPage filter:(NSDictionary *)filterDict sort:(NSDictionary *)sortDict success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    if (!aKeyWord) {
        return nil;
    }
    NSDictionary *params = @{@"comm_name":aKeyWord,
                             @"page":[@{
                                     @"curPage":@(curPage).stringValue,
                                     @"filter":filterDict?:@{},
                                     @"sort":sortDict?:@{},
                                     } getJson],
                             @"lonAndLat":NSStringFromLocationCoordinate([UZLocationManager shareManager].bmkUserLocation.location.coordinate),
                             };
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/room/getRoomList") parameters:params.authorized.cityInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0 && success) {
            success(responseObject);
        }
        if (code != 0) {
            [CKAlert showAlertWithMsg:responseObject[@"msg"]];
            !failure?:failure(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTGetRoomDetailWithRoomId:(NSUInteger)roomId success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    NSDictionary *params = @{@"roomid":@(roomId).stringValue};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/room/getRoomDetail") parameters:params.authorized.cityInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0 && success) {
            NSArray *arr = responseObject[@"data"];
            if (arr.count > 0) {
                success(arr[0]);
            } else {
                success(nil);
            }
        }
        if (code != 0) {
            [CKAlert showAlertWithMsg:responseObject[@"msg"]];
            !failure?:failure(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTAddRoomToFavoriteListWithRoomId:(NSUInteger)roomId success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    NSDictionary *params = @{@"room_id":@(roomId).stringValue,
                           @"tenant_id":@(UID).stringValue};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/favoriteList/save") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSInteger code = [responseObject[@"code"] integerValue];
//        if (code == 0 && success) {
//            success(responseObject);
//        }
//        if (code != 0) {
//            [CKAlert showAlertWithMsg:responseObject[@"msg"]];
//            !failure?:failure(nil);
//        }
        [CKAlert showAlertWithMsg:@"已加入中意清单"];
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CKAlert showAlertWithMsg:@"已加入中意清单"];
        if (failure) {
            failure(error);
        }
    }];
    return request;
}


+ (UZWebRequest *)asyncPOSTGetTenantDetailWithClientID:(NSString *)cid deviceToken:(NSString *)deviceToken success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    if (cid == nil || deviceToken == nil) {
        return nil;
    }
    
    
    NSDictionary *params = @{@"tenantid":@(UID).stringValue, @"uuid":[UUIDCenter UUID], @"clientid":cid,@"devicetoken":deviceToken};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/tenant/getTenantDetail") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0 && success) {
            success(responseObject);
        }
        if (code != 0) {
            [CKAlert showAlertWithMsg:responseObject[@"msg"]];
            !failure?:failure(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}


+ (UZWebRequest *)asyncPOSTfavoriteListQueryWithSuccess:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    NSDictionary *params = @{@"tenant_id":@(UID).stringValue};
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/favoriteList/query") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0 && success) {
            success(responseObject);
        }
        if (code != 0) {
            [CKAlert showAlertWithMsg:responseObject[@"msg"]];
            !failure?:failure(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTCommunityByDistance:(CGFloat)distance coor:(CLLocationCoordinate2D)coor success:(UZWebRequestArray)success failure:(UZWebRequestFailure)failure
{
    NSString *lonAndLat =  NSStringFromLocationCoordinate(coor);// [NSString stringWithFormat:@"%f,%f",coor.longitude,coor.latitude];
    NSString *distanceString;
    if (distance == 0) {
        distanceString = @"";
    } else {
        distanceString = @(distance).stringValue;
    }
    NSDictionary *params = @{@"r":distanceString,
                             @"lonAndLat":lonAndLat};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/community/getCommunityByDistance") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0 && success) {
            NSArray *list = [NSClassFromString(@"UZCommunity") modelsWithDictionarys:responseObject[@"data"]];
            success(list);
        }
        if (code != 0) {
            [CKAlert showAlertWithMsg:responseObject[@"msg"]];
            !failure?:failure(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return request;
}
/**
 *  用户反馈
 *
 *  @param content 反馈内容
 */
+ (UZWebRequest *)asyncPOSTUserFeedBackWithContent:(NSString *)content success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure {
    if (!content) {
        return nil;
    }
    NSDictionary *params =  @{@"complain":@{@"content":content,@"id":@([[UZUserBase shareInstance].uid integerValue]).stringValue,@"createtime":@""}.getJson};
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/complain/save") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0 && success) {
            success(responseObject);
        }
        if (code != 0) {
            [CKAlert showAlertWithMsg:responseObject[@"msg"]];
            !failure?:failure(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络"];
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTRealNameAuthenticationWithName:(NSString *)name cardNumber:(NSString *)cardNumber image:(UIImage *)image success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    NSDictionary *info = @{@"id":@(UID),
                           @"full_name_valid":name,
                           @"id_card_valid":cardNumber};
    NSDictionary *params = @{@"tenant":info.getJson};
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request uploadImageOperationWithUrl:UrlByPath(@"rental/services/tenant/authentication") params:params.authorized constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (image) {
            NSString *imageKey = [NSString stringWithFormat:@"imageFile1"];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:imageKey fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }
    } progress:nil
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
           if (success) {
               success(responseObject);
           }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络"];
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTSignConstractWithRoomId:(NSInteger)roomId constractType:(ContractType)constractType success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    NSDictionary *params = @{@"roomid":@(roomId),
                             @"constractType":@(constractType),
                             @"tenantid":@(UID)};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    request.timeoutInterval = 60 * 5;//3分钟的超时时间
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/contract/signConstract") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络"];
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTPreviewContractWithContractNo:(NSString *)contractNo success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    NSDictionary *params = @{@"contractno":contractNo?:@""};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/contract/view") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0) {
            if (success) {
                success(responseObject);
            }
        } else {
            NSString *msg = responseObject[@"msg"];
            [CKAlert showAlertWithMsg:msg];
            if (failure) {
                failure(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络"];
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTContractByTenantIdSuccess:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    NSDictionary *params = @{@"tenantid":@(UID)};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/contract/getContractByTenantId") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0) {
            if (success) {
                success(responseObject);
            }
        } else {
            NSString *msg = responseObject[@"msg"];
            [CKAlert showAlertWithMsg:msg];
            if (failure) {
                failure(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络"];
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTOrderlistByContractId:(NSInteger)contractId Success:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    NSDictionary *params = @{@"contractid":@(contractId)};
    
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/order/getOrderList") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0) {
            if (success) {
                success(responseObject);
            }
        } else {
            NSString *msg = responseObject[@"msg"];
            [CKAlert showAlertWithMsg:msg];
            if (failure) {
                failure(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络"];
        if (failure) {
            failure(error);
        }
    }];
    return request;
}


+ (UZWebRequest *)asyncPOSTgetLockAndKeyWithSuccess:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    if (UID <= 0) {
        return nil;
    }
    NSDictionary *params = @{@"tenantid":@(UID)};
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/unlock/getLockAndKey") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0) {
            if (success) {
                success(responseObject);
            }
        } else {
            NSString *msg = responseObject[@"msg"];
            [CKAlert showAlertWithMsg:msg];
            if (failure) {
                failure(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络"];
        if (failure) {
            failure(error);
        }
    }];
    return request;
}

+ (UZWebRequest *)asyncPOSTUnbundlingSuccess:(UZWebRequestObj)success failure:(UZWebRequestFailure)failure
{
    if (UID <= 0) {
        return nil;
    }
    NSDictionary *params = @{@"tenantid":@(UID)};
    UZWebRequest *request = [UZWebRequest requestWithNeedRenewedRequest:NO];
    [request asyncPostRequestWithAPI:UrlByPath(@"rental/services/tenant/cleanAppClientInfo") parameters:params.authorized success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    return request;
}

@end

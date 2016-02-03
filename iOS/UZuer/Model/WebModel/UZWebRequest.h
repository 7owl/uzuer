//
//  UZWebRequestInstance.h
//  GameCenter
//
//  Created by CaydenK on 15/6/11.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

/**
 *  网络请求
 */
@interface UZWebRequest : NSObject

/**
 *  请求失败是否自动重连
 */
@property (nonatomic, assign) BOOL needRenewedRequest;
@property (nonatomic, assign) NSTimeInterval timeoutInterval; //超时时间 //默认0 表示使用默认值

#pragma mark
#pragma mark - initialization
+ (UZWebRequest *)requestWithNeedRenewedRequest:(BOOL)needRenewedRequest;
- (instancetype)initWithNeedRenewedRequest:(BOOL)needRenewedRequest;

#pragma mark
#pragma mark - webservice request
/**
 *  接口POST请求
 *
 *  @param apiUrl     API地址
 *  @param parameters 参数列表
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)asyncPostRequestWithAPI:(NSString *)apiUrl
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;





/**
 *  取消请求
 */
- (void)cancelRequest;

/**
 *  异步数据下载
 *
 *  @param path     存储路径
 *  @param url      下载地址
 *  @param progress 进度回调
 *  @param success  成功回调
 *  @param failure  失败回调
 *
 *  @return 请求操作对象
 */
- (AFHTTPRequestOperation *)downloadOperationWithFilePath:(NSString *)path AndUrl:(NSString *)url
                                                 Progress:(void (^)(float progress))progress
                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  上传图片
 */
- (void)uploadImageOperationWithUrl:(NSString *)url
                             params:(NSDictionary *)params
          constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                           progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end

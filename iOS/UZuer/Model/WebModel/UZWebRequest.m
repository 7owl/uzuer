//
//  UZWebRequestInstance.m
//  GameCenter
//
//  Created by CaydenK on 15/6/11.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZWebRequest.h"
#import <AFNetworking/AFNetworking.h>

@interface UZWebRequest ()

/**
 *  请求管理
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
/**
 *  请求操作
 */
@property (nonatomic, strong) AFHTTPRequestOperation *operation;
/**
 *  请求次数
 */
@property (nonatomic, assign) NSInteger times;
/**
 *  是否已取消
 */
@property (nonatomic, assign) BOOL cancelled;

@end

@implementation UZWebRequest

#pragma mark
#pragma mark - initialization
+ (UZWebRequest *)requestWithNeedRenewedRequest:(BOOL)needRenewedRequest{
    return [[UZWebRequest alloc]initWithNeedRenewedRequest:needRenewedRequest];
}
- (instancetype)initWithNeedRenewedRequest:(BOOL)needRenewedRequest{
    self = [super init];
    if (self) {
        _manager = nil;
        _operation = nil;
        _times = 0;
        _needRenewedRequest = needRenewedRequest;
    }
    return self;
}

+ (AFHTTPRequestOperationManager *)managerWithType:(NSString *)type timeOutInterval:(NSTimeInterval)time {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:type?:@"text/html"];
    manager.requestSerializer.timeoutInterval=time?:15;
    return manager;
}

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
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    __weak __typeof(self)weakSelf = self;
    NSTimeInterval timeout = self.timeoutInterval == 0 ? 15:self.timeoutInterval;
    self.manager = [[self class] managerWithType:@"application/json" timeOutInterval:timeout];
    self.operation = [self.manager POST:apiUrl
                            parameters:parameters
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   if (success) {
                                       success(operation,responseObject);
                                   }
                               }
                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   if (weakSelf.needRenewedRequest == YES && weakSelf.cancelled == NO) {
                                       CGFloat delayTime = 0;
                                       if (weakSelf.times == 0) {
                                           delayTime = 5;
                                       }
                                       else if (weakSelf.times == 1){
                                           delayTime = 10;
                                       }
                                       else if (weakSelf.times == 2){
                                           delayTime = 15;
                                       }
                                       else{
                                           if (failure) {
                                               failure(operation, error);
                                           }
                                           return;
                                       }
                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                           weakSelf.times ++;
                                           [weakSelf asyncPostRequestWithAPI:apiUrl parameters:parameters success:success failure:failure];
                                       });
                                   }
                                   else{
                                       if (failure) {
                                           failure(operation,error);
                                       }
                                   }
                               }];

    
}
/**
 *  取消请求
 */
- (void)cancelRequest{
    if (self.operation.cancelled == NO) {
        [self.operation cancel];
        self.cancelled = YES;
    }
}

/*
 *异步数据下载
 */
- (AFHTTPRequestOperation *)downloadOperationWithFilePath:(NSString *)path AndUrl:(NSString *)url
                             Progress:(void (^)(float progress))progress
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //检查文件是否已经下载了一部分
    unsigned long long downloadedBytes = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //获取已下载的文件长度
        downloadedBytes = [self fileSizeForPath:path];
        if (downloadedBytes > 0) {
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
        }
    }
    //不使用缓存，避免断点续传出现问题
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    //下载请求
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //下载路径
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:YES];
    //下载进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        float prog = ((float)totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes);
        if (progress) {
            progress(prog);
        }
    }];
    //成功和失败回调
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
//        [ELVAlert showAlert:@"当前网络不给力，请稍后再试"];
    }];
    
    return operation;
}

//获取已下载的文件大小
- (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}


- (void)uploadImageOperationWithUrl:(NSString *)url
                             params:(NSDictionary *)params
          constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                           progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:block error:nil];
    request.timeoutInterval = 60 * 3; //3分钟的超时时间
    
    self.operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    self.operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.operation setUploadProgressBlock:progress];
    [self.operation setCompletionBlockWithSuccess:success failure:failure];
    [self.operation start];
}











//+ (UZWebRequestInstance *)shareInstance
//{
//    static UZWebRequestInstance *instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance=[[self alloc]init];
//        instance.manager=[[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
//        instance.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//        instance.manager.requestSerializer.timeoutInterval=15;
//    });
//    return instance;
//}



/**
 *  队列下载demo
 */
/*
 - (void)queueDownLoad{
 NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
 
 NSURLRequest *request = [NSURLRequest requestWithURL:url];
 
 AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request];
 
 [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 DLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 DLog(@"Error: %@", error);
 
 }];
 
 
 
 
 
 NSURL *url2 = [NSURL URLWithString:@"http://www.sohu.com"];
 
 NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
 
 AFHTTPRequestOperation *operation2 = [[AFHTTPRequestOperation alloc] initWithRequest:request2];
 
 [operation2 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 DLog(@"Response2: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 DLog(@"Error: %@", error);
 
 }];
 
 
 
 
 
 
 
 NSURL *url3 = [NSURL URLWithString:@"http://www.sina.com"];
 
 NSURLRequest *request3 = [NSURLRequest requestWithURL:url3];
 
 AFHTTPRequestOperation *operation3 = [[AFHTTPRequestOperation alloc] initWithRequest:request3];
 
 [operation3 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 DLog(@"Response3: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 DLog(@"Error: %@", error);
 
 }];
 
 
 
 
 
 //同时请求
 
 NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
 
 [operationQueue setMaxConcurrentOperationCount:3];
 
 [operationQueue addOperations:@[operation1, operation2, operation3] waitUntilFinished:NO];
 
 
 
 
 
 //operation2 在 operation1 请求完成后执行
 
 NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
 
 [operation2 addDependency:operation1];
 
 [operationQueue addOperations:@[operation1, operation2, operation3] waitUntilFinished:NO];
 
 
 }
 //*/

@end

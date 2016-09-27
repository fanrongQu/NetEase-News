//
//  FRNetworking.m
//  FRDemo
//
//  Created by 1860 on 16/1/5.
//  Copyright © 2016年 QuFanrong. All rights reserved.
//

#import "FRNetworking.h"
#import "AFNetworking.h"


static AFHTTPSessionManager *manager = nil;

@implementation FRNetworking

/**
 *  创建一个AFHTTPSessionManager网络请求管理者
 *
 *  @return AFHTTPSessionManager对象
 */
+ (AFHTTPSessionManager *)shareSessionManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];

    });
    
    return manager;
}


#pragma mark - 判断网络状态
+ (void)networkReachability:(void (^)(AFNetworkReachabilityStatus status))block {
    // 检测网络状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (block) {
            block(status);
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}



#pragma mark - GET异步请求网络数据
/**
 Creates and runs an `NSURLSessionDataTask` with a `GET` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param progress A block object to be executed when the download progress is updated. Note this block is called on the session queue, not the main queue.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 @see -dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:
 */
+ (NSURLSessionDataTask *)getWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                progress:(void (^)(NSProgress *downloadProgress)) progress
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure{
    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"\n请求URL = %@\n请求Dict = %@",URLString,parameters);
    return [[self shareSessionManager] GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    }  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            NSLog(@"\nresponseObject = %@",responseObject);        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            NSLog(@"\nerror = %@",error);
        }
    }];
}

+ (NSURLSessionDataTask *)getWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure {
    return [self getWithURLString:URLString parameters:parameters progress:^(NSProgress *downloadProgress) {
    } success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - POST异步请求网络数据
/**
 Creates and runs an `NSURLSessionDataTask` with a `POST` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param progress A block object to be executed when the upload progress is updated. Note this block is called on the session queue, not the main queue.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 @see -dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:
 */
+ (NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                progress:(void (^)(NSProgress *downloadProgress)) progress
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure{
    
    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"\n请求URL = %@\n请求Dict = %@",URLString,parameters);
    return [[self shareSessionManager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            NSLog(@"\nresponseObject = %@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            NSLog(@"\nerror = %@",error);
        }
    }];
}


+ (NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure {
    return [self postWithURLString:URLString parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - POST异步上传网络数据
/**
 Creates and runs an `NSURLSessionDataTask` with a multipart `POST` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param block A block that takes a single argument and appends data to the HTTP body. The block argument is an object adopting the `AFMultipartFormData` protocol.
 @param progress A block object to be executed when the upload progress is updated. Note this block is called on the session queue, not the main queue.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 @see -dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:
 */
+ (NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(FRFormData *)formDate
                 progress:(void (^)(NSProgress *downloadProgress)) progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure{
    
    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"\n请求URL = %@     \n请求parameters = %@      \n请求data = %@      \n请求name = %@      \n请求fileName = %@      \n请求mimeType = %@",url,parameters,formDate.data,formDate.name,formDate.fileName,formDate.mimeType);
    return [[self shareSessionManager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:formDate.data name:formDate.name fileName:formDate.fileName mimeType:formDate.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            NSLog(@"\nresponseObject = %@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            NSLog(@"\nerror = %@",error);
        }
    }];
}

+ (NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(FRFormData *)frFormDate
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure {
    return [self postWithURLString:URLString parameters:parameters constructingBodyWithBlock:frFormDate progress:^(NSProgress *downloadProgress) {
        
    } success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end


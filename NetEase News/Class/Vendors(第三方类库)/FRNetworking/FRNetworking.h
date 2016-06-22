//
//  FRNetworking.h
//  FRDemo
//
//  Created by 1860 on 16/1/5.
//  Copyright © 2016年 QuFanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRFormData.h"


@class AFHTTPSessionManager;
@interface FRNetworking : NSObject

/**
 *  判端网络状态
 *
 *  @param block 网络状态
 */
+ (void)networkReachability:(void (^)(AFNetworkReachabilityStatus status))block;

/**
 *  发送一个GET请求(请求网络数据,没有下载进度参数)
 *
 *  @param URLString        请求路径
 *  @param parameters       请求参数
 *  @param success          请求成功后的回调
 *  @param failure          请求失败后的回调
 */
+ (void)getWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;
/**
 *  发送一个GET请求(请求网络数据,带有下载进度参数)
 *
 *  @param URLString        请求路径
 *  @param parameters       请求参数
 *  @param downloadProgress 数据请求进度
 *  @param success          请求成功后的回调
 *  @param failure          请求失败后的回调
 */
+ (void)getWithURLString:(NSString *)URLString
 parameters:(NSDictionary *)parameters
   progress:(void (^)(NSProgress *downloadProgress)) downloadProgress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(请求网络数据，,没有下载进度参数)
 *
 *  @param URLString        请求路径
 *  @param parameters       请求参数
 *  @param success          请求成功后的回调
 *  @param failure          请求失败后的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(请求网络数据,带有下载进度参数)
 *
 *  @param URLString        请求路径
 *  @param parameters       请求参数
 *  @param downloadProgress 数据请求进度
 *  @param success          请求成功后的回调
 *  @param failure          请求失败后的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                 progress:(void (^)(NSProgress *downloadProgress)) progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(上传网络数据,没有上传进度参数)
 *
 *  @param URLString        请求路径
 *  @param parameters       请求参数
 *  @param success          请求成功后的回调
 *  @param failure          请求失败后的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(FRFormData *)frFormDate
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(上传网络数据，带有上传进度参数)
 *
 *  @param URLString        请求路径
 *  @param parameters       请求参数
 *  @param downloadProgress 下载进度
 *  @param success          请求成功后的回调
 *  @param failure          请求失败后的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(FRFormData *)formDate
                 progress:(void (^)(NSProgress *downloadProgress)) progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

@end







//
//  BaseViewModel.h
//  NetEase News
//
//  Created by 1860 on 16/6/21.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRNetworking.h"


typedef void(^CompletionHandle)(NSError *error);

@protocol BaseViewModelDelegate <NSObject>

@optional
//获取更多
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle;
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle;
//获取数据
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle;

@end

@interface BaseViewModel : NSObject

@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSMutableDictionary *dataDict;


- (void)cancelTask;  //取消任务
- (void)suspendTask; //暂停任务
- (void)resumeTask;  //继续任务

/**
 *  返回信息
 */
@property (nonatomic, strong) NSString *message;

/**
 *  状态
 */
@property (nonatomic, strong) NSNumber *status;

@end

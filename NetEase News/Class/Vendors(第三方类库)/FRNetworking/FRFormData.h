//
//  FRFormData.h
//  FRDemo
//
//  Created by 1860 on 16/1/5.
//  Copyright © 2016年 QuFanrong. All rights reserved.
//

/**
 *  用来封装文件数据的模型
 */
#import <Foundation/Foundation.h>

@interface FRFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;


/**
 *  对象方法实现文件数据模型的封装
 *
 *  @param data     文件数据
 *  @param name     参数名
 *  @param fileName 文件名
 *  @param mimeType 文件类型
 *
 *  @return FRFormData数据模型
 */
- (instancetype)initWithFileData:(NSData *)data
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(NSString *)mimeType;

/**
 *  类方法实现文件数据模型的封装
 *
 *  @param data     文件数据
 *  @param name     参数名
 *  @param fileName 文件名
 *  @param mimeType 文件类型
 *
 *  @return FRFormData数据模型
 */
+ (instancetype)formDataWithFileData:(NSData *)data
                                name:(NSString *)name
                            fileName:(NSString *)fileName
                            mimeType:(NSString *)mimeType;

@end

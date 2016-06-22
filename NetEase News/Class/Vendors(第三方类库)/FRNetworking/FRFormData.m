//
//  FRFormData.m
//  FRDemo
//
//  Created by 1860 on 16/1/5.
//  Copyright © 2016年 QuFanrong. All rights reserved.
//

#import "FRFormData.h"

@implementation FRFormData

- (instancetype)initWithFileData:(NSData *)data
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(NSString *)mimeType
{
    if (self = [super init]) {
        self.data = data;
        self.name = name;
        self.fileName = fileName;
        self.mimeType = mimeType;
    }
    return self;
}

+ (instancetype)formDataWithFileData:(NSData *)data
                                name:(NSString *)name
                            fileName:(NSString *)fileName
                            mimeType:(NSString *)mimeType
{
    return [[self alloc]initWithFileData:data name:name fileName:fileName mimeType:mimeType];
}

@end

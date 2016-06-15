//
//  NSData+Category.h
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Category)

/**
 *  判断当前时间是否是晚上
 *
 *  @return YES 晚上   NO 白天
 */
+ (BOOL)isNight;

@end

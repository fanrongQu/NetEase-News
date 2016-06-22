//
//  NewsViewModel.h
//  NetEase News
//
//  Created by 1860 on 16/6/21.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BaseViewModel.h"
#import "NewsMenuModel.h"

@interface NewsViewModel : BaseViewModel

/**
 *  获取顶部显示分类新闻信息
 */
- (NSArray *)getSlideMenus;

/**
 *  获取更多新闻分类
 */
- (void)getNewsMenus:(NSDictionary *)paramaters CompletionHandle:(void(^)(NSArray *completionArray, NSError *error))completionHandle;

@end

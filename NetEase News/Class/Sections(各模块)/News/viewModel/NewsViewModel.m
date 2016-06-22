//
//  NewsViewModel.m
//  NetEase News
//
//  Created by 1860 on 16/6/21.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "NewsViewModel.h"

@implementation NewsViewModel

- (NSArray *)getSlideMenus {
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:NewsSlideMenuPlist ofType:@"plist"];
    
    NSArray *newsMenus = [NSArray arrayWithContentsOfFile:plistPath];
    
    return [NewsMenuList mj_objectArrayWithKeyValuesArray:newsMenus];
}

- (void)getNewsMenus:(NSDictionary *)paramaters CompletionHandle:(void(^)(NSArray *completionArray, NSError *error))completionHandle{
    
    
    FRPlist *plist = [[FRPlist alloc]init];
    NSArray *moreMenus = [plist arrayWithPlistName:NewsMoreMenuPlist];
    if (moreMenus.count > 0) {//已请求过所有分类数据
        completionHandle([NewsMenuList mj_objectArrayWithKeyValuesArray:moreMenus], nil);
        return;
    }
    [FRNetworking getWithURLString:NewsMenuApi parameters:nil success:^(id responseObject) {
        //所有分类
        NSMutableArray *allMenus = responseObject[@"tList"];
        NSInteger allMenusInt = allMenus.count;
        
        //当前选择分类
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:NewsSlideMenuPlist ofType:@"plist"];
        NSArray *slideMenus = [NSArray arrayWithContentsOfFile:plistPath];
        NSInteger slideMenusInt = slideMenus.count;
        
        NSMutableArray *otherMenus = [NSMutableArray arrayWithArray:allMenus];
        NSInteger removeInteger = 0;
        
        for (int m = 0; m < allMenusInt; m++) {//遍历全部分类
            NSString *name = allMenus[m][@"tname"];
            
            for (int n = 0; n < slideMenusInt; n++) {//遍历当前选择分类
                
                NSString *slideName = slideMenus[n][@"tname"];
                if ([name isEqualToString:slideName]) {
                    
                    [otherMenus removeObjectAtIndex:m-removeInteger];
                    removeInteger += 1;
                    break;
                }
            }
        }
        
        FRPlist *plist = [[FRPlist alloc]init];
        if ([plist writeArray:otherMenus toPlist:NewsMoreMenuPlist]) {
            NSLog(@"写入成功");
        }else {
            NSLog(@"写入失败");
        }
        NSArray *moreMenus = [plist arrayWithPlistName:NewsMoreMenuPlist];
        completionHandle([NewsMenuList mj_objectArrayWithKeyValuesArray:moreMenus], nil);
        
    } failure:^(NSError *error) {
        
        completionHandle(nil,error);
    }];
}

@end

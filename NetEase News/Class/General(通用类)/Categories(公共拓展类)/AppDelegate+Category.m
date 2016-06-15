//
//  AppDelegate+Category.m
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "AppDelegate+Category.h"
#import "RootTabBarViewController.h"

@implementation AppDelegate (Category)


- (void)setRootViewController {
    //设置window
    self.window = [[UIWindow alloc]initWithFrame:kScreenBounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RootTabBarViewController *tabBarVC = [[RootTabBarViewController alloc]init];
    [self.window setRootViewController:tabBarVC];
    
    
    [self.window makeKeyAndVisible];
}

@end

//
//  FRTabBarController.h
//  FRTabBarController-Demo
//
//  Created by 1860 on 16/4/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRTabBarController : UITabBarController

/**
 *  为tabBarController添加子控制器UIViewController
 *
 *  @param childController 子控制器
 *  @param title           子控制器标题
 *  @param image           子控制器tabBarItem图片
 *  @param selectedImage   子控制器tabBarItem选中图片
 */
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;

/**
 *  为tabBarController添加子控制器UINavigationController
 *
 *  @param navigationController 导航控制器
 *  @param title                navigationController的rootViewController的title
 *  @param image                navigationController的rootViewController的image
 *  @param selectedImage        navigationController的rootViewController的selectedImage
 */
- (void)addChildNavigationController:(UINavigationController *)navigationController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;

@end

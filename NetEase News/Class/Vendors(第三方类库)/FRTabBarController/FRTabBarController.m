//
//  FRTabBarController.m
//  RTabBarController-Demo
//
//  Created by 1860 on 16/4/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//


#import "FRTabBarController.h"
#import "FRTabBar.h"

@interface FRTabBarController ()<FRTabBarDelegate>

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) FRTabBar *customTabBar;

@end

@implementation FRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化tabbar
    [self setupTabbar];
}


/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    FRTabBar *customTabBar = [[FRTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

#pragma mark - FRTabBar Delegate
- (void)tabBar:(FRTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}



- (void)addChildNavigationController:(UINavigationController *)navigationController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UIViewController *childViewController = navigationController.childViewControllers[0];
    //标题
    childViewController.title = title;
    
    //图片
    childViewController.tabBarItem.image = [UIImage imageNamed:image];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:navigationController];
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarItemWithItem:childViewController.tabBarItem];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    //标题
    childController.title = title;
    
    //图片
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:childController];
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarItemWithItem:childController.tabBarItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

@end

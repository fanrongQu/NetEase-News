//
//  FRNavigationController.m
//
//  Created by Mac on 15/9/21.
//  Copyright © 2015年 FR. All rights reserved.
//



#import "FRNavigationController.h"

@interface FRNavigationController ()


@end


@implementation FRNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setNavigationBar];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setNavigationBar];
    }
    return self;
}

/**
 *  设置setNavigationBar属性
 */
- (void)setNavigationBar {
    //设置整个项目item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //取消UIBarButtonItem的渲染效果
    [item setTintColor:_tintColor?_tintColor:[UIColor blackColor]];
    //设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //item字体大小
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    //item字体颜色
    textAttrs[NSForegroundColorAttributeName] = _itemNormalColor?_itemNormalColor:[UIColor blackColor];
    
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
   
    //设置不可用状态
    NSMutableDictionary *disableTextAttr = [NSMutableDictionary dictionary];
    disableTextAttr[NSForegroundColorAttributeName] = _itemDisabledColor?_itemDisabledColor:[UIColor lightGrayColor];
    disableTextAttr[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:disableTextAttr forState:UIControlStateDisabled];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //状态栏颜色
    navigationBar.barTintColor = _navigationBarColor?_navigationBarColor:[UIColor whiteColor];
    //状态栏字体(白色)
    //在info.plist中添加一个字段：view controller -base status bar 设置为NO
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //导航栏title颜色
    [navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:_navigationBarTitleColor?_navigationBarTitleColor:[UIColor blackColor]}];
}

/**
 *  重写这个方法，拦截push进来的控制器
 *
 *  @param viewController push进来的控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {//这时push进来的控制器不是第一个控制器
        //自动隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置导航栏上面显示的内容样式
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

#pragma mark - 设置颜色

- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor {

    if (navigationBarTitleColor) {
        _navigationBarTitleColor = navigationBarTitleColor;
        //导航栏title颜色
        [[UINavigationBar appearance] setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:19],
           NSForegroundColorAttributeName:navigationBarTitleColor}];
    }
}

- (void)setNavigationBarColor:(UIColor *)navigationBarColor {
    if (navigationBarColor) {
        _navigationBarColor = navigationBarColor;
        [UINavigationBar appearance].barTintColor = navigationBarColor;
    }
}

- (void)setItemNormalColor:(UIColor *)itemNormalColor {
    if (itemNormalColor) {
        _itemNormalColor = itemNormalColor;
        NSMutableDictionary *itemTextAttr = [NSMutableDictionary dictionary];
        itemTextAttr[NSForegroundColorAttributeName] = itemNormalColor;
        [[UIBarButtonItem appearance] setTitleTextAttributes:itemTextAttr forState:UIControlStateNormal];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (tintColor) {
        _tintColor = tintColor;
        //取消UIBarButtonItem的渲染效果
        [[UIBarButtonItem appearance] setTintColor:tintColor];
    }
}

- (void)setItemDisabledColor:(UIColor *)itemDisabledColor {
    if (itemDisabledColor) {
        _itemDisabledColor = itemDisabledColor;
        NSMutableDictionary *itemTextAttr = [NSMutableDictionary dictionary];
        itemTextAttr[NSForegroundColorAttributeName] = itemDisabledColor;
        [[UIBarButtonItem appearance] setTitleTextAttributes:itemTextAttr forState:UIControlStateDisabled];
    }
}

- (void)setUpNavigationBarColor:(void (^)(UIColor *__autoreleasing *, UIColor *__autoreleasing *, UIColor *__autoreleasing *, UIColor *__autoreleasing *, UIColor *__autoreleasing *))navigationBar {
    
    UIColor *navigationBarColor;
    UIColor *navigationBarTitleColor;
    UIColor *itemNormalColor;
    UIColor *itemDisabledColor;
    UIColor *tintColor;
    if (navigationBar) {
        navigationBar(&navigationBarColor,&navigationBarTitleColor,&itemNormalColor,&itemDisabledColor,&tintColor);
        self.navigationBarColor = navigationBarColor;
        self.navigationBarTitleColor = navigationBarTitleColor;
        self.itemNormalColor = itemNormalColor;
        self.itemDisabledColor = itemDisabledColor;
        self.tintColor = tintColor;
    }
}


- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}


@end

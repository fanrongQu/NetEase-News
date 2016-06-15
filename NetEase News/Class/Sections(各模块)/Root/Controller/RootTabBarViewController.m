//
//  RootTabBarViewController.m
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "RootNavigationController.h"
#import "NewsViewController.h"
#import "ReadViewController.h"
#import "ViedosViewController.h"
#import "TopicsViewController.h"
#import "MeViewController.h"

@interface RootTabBarViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *normalImages;
@property (nonatomic, strong) NSArray *selectedImages;

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
}

- (void)addChildViewControllers {
    
    NSString *tabBarIcon = @"tabbar_icon_";
    if ([NSData isNight]) {
        tabBarIcon = @"night_tabbar_icon_";
    } 
//    self.tabBar.barTintColor = [UIColor blackColor];
    
    NSString *newsNormalIcon = [tabBarIcon stringByAppendingString:@"news_normal"];
    NSString *newsSelectIcon = [tabBarIcon stringByAppendingString:@"news_highlight"];
    
    NSString *readNormalIcon = [tabBarIcon stringByAppendingString:@"reader_normal"];
    NSString *readSelectIcon = [tabBarIcon stringByAppendingString:@"reader_highlight"];
    
    NSString *viedosNormalIcon = [tabBarIcon stringByAppendingString:@"media_normal"];
    NSString *viedosSelectIcon = [tabBarIcon stringByAppendingString:@"media_highlight"];
    
    NSString *topicsNormalIcon = [tabBarIcon stringByAppendingString:@"bar_normal"];
    NSString *topicsSelectIcon = [tabBarIcon stringByAppendingString:@"bar_highlight"];
    
    NSString *meNormalIcon = [tabBarIcon stringByAppendingString:@"me_normal"];
    NSString *meSelectIcon = [tabBarIcon stringByAppendingString:@"me_highlight"];
    
    
    //设置tabBarVC的子控制器
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    RootNavigationController *newsNav = [[RootNavigationController alloc] initWithRootViewController:newsVC];
    newsNav.delegate = self;
    [self addChildNavigationController:newsNav title:@"新闻" image:newsNormalIcon selectedImage:newsSelectIcon];
    
    ReadViewController *readVC = [[ReadViewController alloc]init];
    RootNavigationController *ReadNav = [[RootNavigationController alloc] initWithRootViewController:readVC];
    ReadNav.delegate = self;
    [self addChildNavigationController:ReadNav title:@"阅读" image:readNormalIcon selectedImage:readSelectIcon];
    
    ViedosViewController *viedosVC = [[ViedosViewController alloc]init];
    RootNavigationController *ViedosNav = [[RootNavigationController alloc] initWithRootViewController:viedosVC];
    ViedosNav.delegate = self;
    [self addChildNavigationController:ViedosNav title:@"视频" image:viedosNormalIcon selectedImage:viedosSelectIcon];
    
    TopicsViewController *topicsVC = [[TopicsViewController alloc]init];
    RootNavigationController *topicsNav = [[RootNavigationController alloc] initWithRootViewController:topicsVC];
    topicsNav.delegate = self;
    [self addChildNavigationController:topicsNav title:@"话题" image:topicsNormalIcon selectedImage:topicsSelectIcon];
    
    MeViewController *meVC = [[MeViewController alloc]init];
    RootNavigationController *meNav = [[RootNavigationController alloc] initWithRootViewController:meVC];
    meNav.delegate = self;
    [self addChildNavigationController:meNav title:@"我" image:meNormalIcon selectedImage:meSelectIcon];
}

@end

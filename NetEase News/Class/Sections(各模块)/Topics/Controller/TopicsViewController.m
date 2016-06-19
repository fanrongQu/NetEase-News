//
//  TopicsViewController.m
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "TopicsViewController.h"
#import "ChildViewController.h"

@interface TopicsViewController ()

@end

@implementation TopicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigtionBar];
    
    [self setUpAllViewController];
}


- (void)setNavigtionBar {
    
    self.navigationItem.titleView = self.segmentedView;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 话题
    ChildViewController *wordVc1 = [[ChildViewController alloc] init];
    wordVc1.title = @"话题";
    wordVc1.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:wordVc1];
    
    // 问吧
    ChildViewController *wordVc2 = [[ChildViewController alloc] init];
    wordVc2.title = @"问吧";
    wordVc2.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:wordVc2];
    
    // 关注
    ChildViewController *wordVc3 = [[ChildViewController alloc] init];
    wordVc3.title = @"关注";
    wordVc3.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:wordVc3];
    
}

@end

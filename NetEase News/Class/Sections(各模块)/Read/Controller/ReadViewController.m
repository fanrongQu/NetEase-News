//
//  ReadViewController.m
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ReadViewController.h"
#import "ChildViewController.h"

@interface ReadViewController ()


@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigtionBar];
    
    [self setUpAllViewController];
    self.contentFrame = CGRectMake(0, 164, [UIScreen mainScreen].bounds.size.width, 300);
    
    [self setUpSegmentedEffect:^(UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *overColor, UIColor *__autoreleasing *normalBackColor, UIColor *__autoreleasing *selectBackColor) {
        *overColor = [UIColor yellowColor];
        
    }];
}


- (void)setNavigtionBar {
    
    self.navigationItem.titleView = self.segmentedView;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 推荐阅读
    ChildViewController *wordVc1 = [[ChildViewController alloc] init];
    wordVc1.title = @"推荐阅读";
    wordVc1.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:wordVc1];
    
    // 我的订阅
    ChildViewController *wordVc2 = [[ChildViewController alloc] init];
    wordVc2.title = @"我的订阅";
    wordVc2.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:wordVc2];
    
}



@end

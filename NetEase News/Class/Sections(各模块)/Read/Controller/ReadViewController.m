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

}


- (void)setNavigtionBar {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"readernewslist_headerbutton"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
}


- (void)rightBarButtonItemClick {
    
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

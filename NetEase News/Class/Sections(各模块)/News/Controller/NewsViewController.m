//
//  NewsViewController.m
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "NewsViewController.h"
#import "ChildViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self setNewsView];
}

- (void)setNavigationBar {
    //titleView
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 35)];
    titleView.image = [UIImage imageNamed:@"News_header_logo"];
    self.navigationItem.titleView = titleView;
    
    //leftBarButtonItem
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"直播" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    
    //rightBarButtonItem
    UIImage *rightBarButtonImg = [UIImage imageNamed:@"night_search_icon"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: rightBarButtonImg style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
}

- (void)leftBarButtonItemClick {
    
}


- (void)rightBarButtonItemClick {
    
}

- (void)setNewsView{
    // 添加所有子控制器
    [self setUpAllViewController];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleHeight = 40;
    }];
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(BOOL *isShowTitleGradient, FRTitleColorGradientStyle *titleColorGradientStyle, CGFloat *startR, CGFloat *startG, CGFloat *startB, CGFloat *endR, CGFloat *endG, CGFloat *endB) {
        
        // 不需要设置的属性，可以不管
        *isShowTitleGradient = YES;
        
        *titleColorGradientStyle = FRTitleColorGradientStyleRGB;
        
        *endR = 1;
        
    }];
    
    // 推荐方式 (设置字体缩放)
    [self setUpTitleScale:^(BOOL *isShowTitleScale, CGFloat *titleScale) {
        
        // 是否需要字体缩放
        *isShowTitleScale = YES;
        
        // 字体缩放比例
        *titleScale = 1.22;
    }];
    
    
//    // *推荐方式(设置遮盖)
//    [self setUpCoverEffect:^(BOOL *isShowTitleCover, UIColor **coverColor, CGFloat *coverCornerRadius) {
//        // 设置是否显示标题蒙版
//        *isShowTitleCover = YES;
//        
//        // 设置蒙版颜色
//        *coverColor = [UIColor colorWithWhite:0.7 alpha:0.4];
//        
//        // 设置蒙版圆角半径
//        *coverCornerRadius = 13;
//    }];
//    
//    // 推荐方式（设置下标）
//    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
//        
//        // 是否显示标签
//        *isShowUnderLine = YES;
//        
//        // 标题填充模式
//        *underLineColor = [UIColor redColor];
//        
//        // 是否需要延迟滚动,下标不会随着拖动而改变
////        *isDelayScroll = YES;
//        
//    }];
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 推荐
    ChildViewController *wordVc1 = [[ChildViewController alloc] init];
    wordVc1.title = @"推荐";
    [self addChildViewController:wordVc1];
    
    // 热点
    ChildViewController *wordVc2 = [[ChildViewController alloc] init];
    wordVc2.title = @"热点";
    [self addChildViewController:wordVc2];
    
    // 社会
    ChildViewController *wordVc3 = [[ChildViewController alloc] init];
    wordVc3.title = @"社会";
    [self addChildViewController:wordVc3];
    
    //体育
    ChildViewController *wordVc4 = [[ChildViewController alloc] init];
    wordVc4.title = @"体育";
    [self addChildViewController:wordVc4];
    
    // 财经
    ChildViewController *allVc = [[ChildViewController alloc] init];
    allVc.title = @"财经";
    [self addChildViewController:allVc];
    
    // 科技
    ChildViewController *videoVc = [[ChildViewController alloc] init];
    videoVc.title = @"科技";
    [self addChildViewController:videoVc];
    
    // 房产
    ChildViewController *voiceVc = [[ChildViewController alloc] init];
    voiceVc.title = @"房产";
    [self addChildViewController:voiceVc];
    
    // 图片
    ChildViewController *pictureVc = [[ChildViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    // 段子
    ChildViewController *wordVc = [[ChildViewController alloc] init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.fd_interactivePopDisabled = YES;
    
}


@end

//
//  NewsViewController.m
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "NewsViewController.h"
#import "ChildViewController.h"
#import "NewsViewModel.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self getNewsMenus];
    
    [self setNewsView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickMenuTitle:) name:FRSlideMenuClickMenuTitleNote object:nil];;
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

- (void)clickMenuTitle:(NSNotification *)not {
    [self cancleAddMenu:self.cancleBtn];
}

- (void)setNewsView{
    
    [self setUpTitleEffect:^(BOOL *isShowAddMenuView, UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *isShowAddMenuView = YES;
        *norColor = [UIColor lightGrayColor];
        *titleHeight = 40;
    }];
    
    // 设置标题渐变
    [self setUpTitleGradient:^(BOOL *isShowTitleGradient, FRTitleColorGradientStyle *titleColorGradientStyle, CGFloat *startR, CGFloat *startG, CGFloat *startB, CGFloat *endR, CGFloat *endG, CGFloat *endB) {
        
        // 不需要设置的属性，可以不管
        *isShowTitleGradient = YES;
        
        *titleColorGradientStyle = FRTitleColorGradientStyleRGB;
        
        *endR = 1;
        
    }];
    
    // 设置字体缩放
    [self setUpTitleScale:^(BOOL *isShowTitleScale, CGFloat *titleScale) {
        
        // 是否需要字体缩放
        *isShowTitleScale = YES;
        
        // 字体缩放比例
        *titleScale = 1.22;
    }];
}

/**
 *  获取所有新闻分类
 */
- (void)getNewsMenus {
   
    NewsViewModel *newsViewModel = [[NewsViewModel alloc]init];
    
    NSArray *slideMenus = [newsViewModel getSlideMenus];
    
    [self setUpAllViewControllerWithArray:slideMenus];
}

// 添加所有子控制器
- (void)setUpAllViewControllerWithArray:(NSArray *)array
{
    NSInteger count = array.count;
    for (int i = 0; i < count; i++) {
        // 推荐
        ChildViewController *childVC = [[ChildViewController alloc] init];
        NewsMenuList *titleDict = array[i];
        childVC.title = titleDict.tname;
        childVC.tid = titleDict.tid;
        [self addChildViewController:childVC];

    }
}

- (void)showMoreMenuView {
    NSLog_func();
    NewsViewModel *newsVM = [[NewsViewModel alloc]init];
    [newsVM getNewsMenus:nil CompletionHandle:^(BOOL writeSucceed, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        if (writeSucceed) {
            [self showMenuViewWithSlidePlistName:NewsSlideMenuPlist OtherPlist:NewsMoreMenuPlist];
            
            [self hiddenTabBar];
        }
    }];
}

/**
 *  隐藏添加分类视图
 */
- (void)cancleAddMenu:(UIButton *)button {
    
    [super cancleAddMenu:button];
    [self showTabBar];
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self getNewsMenus];
    [self refreshDisplay];
}


/**
 *  隐藏tabbar
 */
- (void)hiddenTabBar{
    NSArray *subviews = self.tabBarController.view.subviews;
    UITabBar *tabBarView = [subviews objectAtIndex:1];
    [UIView animateWithDuration:0.6 animations:^{
        tabBarView.frame=CGRectMake(0, kSCreenHeight, kSCreenWidth, 49);
    }];
}

/**
 *  显示tabbar
 */
- (void)showTabBar{
    NSArray *subviews = self.tabBarController.view.subviews;
    UITabBar *tabBarView = [subviews objectAtIndex:1];
    [UIView animateWithDuration:0.6 animations:^{
        tabBarView.frame=CGRectMake(0, kSCreenHeight-49, kSCreenWidth, 49);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end

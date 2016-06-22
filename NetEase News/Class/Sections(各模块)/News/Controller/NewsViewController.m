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

@property (nonatomic, weak) UIView *menuView;

@property (nonatomic, weak) UIView *menuTopView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self getNewsMenus];
    
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
    
    [self setNewsView];
}

- (void)showMoreMenuView {
    NSLog(@"++++++");
    NewsViewModel *newsVM = [[NewsViewModel alloc]init];
    [newsVM getNewsMenus:nil CompletionHandle:^(NSArray *completionArray, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%@",completionArray);
        [self showMenuView];
    }];
}

- (void)showMenuView {
    
    [self hiddenTabBar];
    
    //新闻分类管理头部视图
    CGRect menuTopViewF = CGRectMake(0, 64, kSCreenWidth, 40);
    UIView *menuTopView = [[UIView alloc]initWithFrame:menuTopViewF];
    menuTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuTopView];
    _menuTopView = menuTopView;
    [self setMenuTopView:menuTopView];
    
    
    CGFloat maxMenuTopViewY = CGRectGetMaxY(menuTopViewF);
    CGFloat menuViewH = kSCreenHeight - maxMenuTopViewY;
    CGRect menuViewF = CGRectMake(0, maxMenuTopViewY - menuViewH, kSCreenWidth, menuViewH);
    UIView *menuView = [[UIView alloc]initWithFrame:menuViewF];
    menuView.backgroundColor = kUIColor_RGB(255, 255, 255, 0.9);                                                                                             
    [self.view insertSubview:menuView belowSubview:menuTopView];
    _menuView = menuView;
    [UIView animateWithDuration:0.6 animations:^{
        menuView.frame=CGRectMake(0, maxMenuTopViewY, kSCreenWidth, menuViewH);
    }];
}


- (void)setMenuTopView:(UIView *)menuTopView {
    
    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, 100, 30)];
    Label.text = @"切换栏目";
    Label.font = kFontSize(14);
    [menuTopView addSubview:Label];
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(kSCreenWidth- 40, 0, 40, 40)];
    [cancleBtn setImage:[UIImage imageNamed:@"addMenuBtn"] forState:UIControlStateNormal];
    [cancleBtn setImage:[UIImage imageNamed:@"addMenuBtn"] forState:UIControlStateHighlighted];
    [menuTopView addSubview:cancleBtn];
    [cancleBtn addTarget:self action:@selector(cancleAddMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self rotationAnimationWithView:cancleBtn];
    
    CGRect deleteBtnF = CGRectMake(kSCreenWidth - 120, 9, 70, 22);
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:deleteBtnF];
    [deleteBtn.layer setMasksToBounds:YES];
    [deleteBtn.layer setCornerRadius:11];
    [deleteBtn.layer setBorderWidth:1.2];
    [deleteBtn.layer setBorderColor:kSubjectColor_day.CGColor];
    
    deleteBtn.titleLabel.font = kFontSize(13);
    [deleteBtn setTitle:@"排序删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:kSubjectColor_day forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [menuTopView addSubview:deleteBtn];
}

/**
 *  隐藏添加分类视图
 */
- (void)cancleAddMenu:(UIButton *)button {
    [self showTabBar];
    [self rotationAnimationWithView:button];
    [UIView animateWithDuration:0.6 animations:^{
        CGFloat maxMenuTopViewY = CGRectGetMaxY(_menuTopView.frame);
        CGFloat menuViewH = kSCreenHeight - maxMenuTopViewY;
        _menuView.frame = CGRectMake(0, maxMenuTopViewY - menuViewH, kSCreenWidth, menuViewH);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [_menuView removeFromSuperview];
            [_menuTopView removeFromSuperview];
        });
    }];
}


#pragma mark 旋转动画
-(void)rotationAnimationWithView:(UIView *)view {
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //2.设置动画属性初始值、结束值
    basicAnimation.fromValue=[NSNumber numberWithInt:-M_PI_4];
//    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_4];
    
    //设置其他动画属性
    basicAnimation.duration = 0.6;//动画时间
    
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [view.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.fd_interactivePopDisabled = YES;
    
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
        tabBarView.frame=CGRectMake(0, kSCreenHeight, kSCreenWidth-49, 49);
    }];
}


@end

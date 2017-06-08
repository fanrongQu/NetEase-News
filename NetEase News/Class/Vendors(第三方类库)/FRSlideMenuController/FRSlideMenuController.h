//
//  FRSlideMenuController.h
//  NetEase News
//
//  Created by 1860 on 16/6/15.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>


// 颜色渐变样式
typedef enum : NSUInteger {
    FRTitleColorGradientStyleRGB,
    FRTitleColorGradientStyleFill,
} FRTitleColorGradientStyle;

/*
 使用注意：
 1.字体放大效果和角标不能同时使用。
 2.网易效果：颜色渐变 + 字体缩放
 3.进入头条效果：颜色填充渐变
 4.展示tableView的时候，如果有UITabBarController,UINavgationController,需要自己给tableView添加额外滚动区域。
 */


// 导航条高度
static CGFloat const FRNavBarH = 64;

// 标题滚动视图的高度
static CGFloat const FRTitleScrollViewH = 44;

// 标题缩放比例
static CGFloat const FRTitleTransformScale = 1.3;

// 下划线默认高度
static CGFloat const FRUnderLineH = 2;

// 默认标题字体
static CGFloat const TitleFontSize = 15;

// 默认标题间距
static CGFloat const margin = 20;

//默认添加按钮宽度
static CGFloat const addMenuViewW = 48;

static NSString * const ID = @"FRSlideMenuCollectionCell";

static NSString * const menuID = @"FRMenuCollectionCell";

// 标题被点击或者滚动切换分类后，会发出这个通知。监听这个通知，加载数据
static NSString * const FRSlideMenuClickOrScrollDidFinshNote = @"FRSlideMenuClickOrScrollDidFinshNote";

// 重复点击通知
static NSString * const FRSlideMenuRepeatClickTitleNote = @"FRSlideMenuRepeatClickTitleNote";

// 点击切换栏目标题
static NSString * const FRSlideMenuClickMenuTitleNote = @"FRSlideMenuClickMenuTitleNote";

@interface FRSlideMenuController : UIViewController

#pragma mark - 内容
/**
 内容是否需要全屏展示
 YES :  全屏：内容占据整个屏幕，会有穿透导航栏效果
 NO  :  内容从标题下展示
 */
@property (nonatomic, assign) BOOL isfullScreen;

/**
 根据角标，选中对应的控制器
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 如果isfullScreen = Yes，这个方法就没有作用
 设置整体内容的frame,包含（标题滚动视图和内容滚动视图）
 */
- (void)setUpContentViewFrame:(void(^)(UIView *contentView))contentBlock;




#pragma mark - 标题

/**
 标题滚动视图背景颜色
 */
@property (nonatomic, strong) UIColor *titleScrollViewColor;

/**
 标题高度
 */
@property (nonatomic, assign) CGFloat titleHeight;

/**
 正常标题颜色
 */
@property (nonatomic, strong) UIColor *norColor;

/**
 选中标题颜色
 */
@property (nonatomic, strong) UIColor *selColor;

/**
 标题字体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 *  是否可以添加分类
 */
@property (nonatomic, assign) BOOL isShowAddMenuView;

/**
 *  一次性设置所有标题属性
 */
- (void)setUpTitleEffect:(void(^)(BOOL *isShowAddMenuView,UIColor **titleScrollViewColor,UIColor **norColor,UIColor **selColor,UIFont **titleFont,CGFloat *titleHeight))titleEffectBlock;


#pragma mark - 下标

/**
 是否需要下标
 */
@property (nonatomic, assign) BOOL isShowUnderLine;

/**
 是否延迟滚动下标
 */
@property (nonatomic, assign) BOOL isDelayScroll;

/**
 下标颜色
 */
@property (nonatomic, strong) UIColor *underLineColor;

/**
 下标高度
 */
@property (nonatomic, assign) CGFloat underLineH;

/**
 *  一次性设置所有下标属性
 */
- (void)setUpUnderLineEffect:(void(^)(BOOL *isShowUnderLine,BOOL *isDelayScroll,CGFloat *underLineH,UIColor **underLineColor))underLineBlock;


#pragma mark - 字体缩放

/**
 字体放大
 */
@property (nonatomic, assign) BOOL isShowTitleScale;

/**
 字体缩放比例
 */
@property (nonatomic, assign) CGFloat titleScale;


/**
 *  一次性设置所有字体缩放属性
 */
- (void)setUpTitleScale:(void(^)(BOOL *isShowTitleScale,CGFloat *titleScale))titleScaleBlock;


#pragma mark - 字体颜色渐变

/**
 字体是否渐变
 */
@property (nonatomic, assign) BOOL isShowTitleGradient;

/**
 颜色渐变样式
 */
@property (nonatomic, assign) FRTitleColorGradientStyle titleColorGradientStyle;

/**
 开始颜色,取值范围0~1
 */
@property (nonatomic, assign) CGFloat startR;

@property (nonatomic, assign) CGFloat startG;

@property (nonatomic, assign) CGFloat startB;

/**
 完成颜色,取值范围0~1
 */
@property (nonatomic, assign) CGFloat endR;

@property (nonatomic, assign) CGFloat endG;

@property (nonatomic, assign) CGFloat endB;

/**
 *  一次性设置所有颜色渐变属性
 */
- (void)setUpTitleGradient:(void(^)(BOOL *isShowTitleGradient,FRTitleColorGradientStyle *titleColorGradientStyle,CGFloat *startR,CGFloat *startG,CGFloat *startB,CGFloat *endR,CGFloat *endG,CGFloat *endB))titleGradientBlock;



#pragma mark - 字体遮盖(title背景)

/**
 是否显示遮盖
 */
@property (nonatomic, assign) BOOL isShowTitleCover;

/**
 遮盖颜色
 */
@property (nonatomic, strong) UIColor *coverColor;

/**
 遮盖圆角半径
 */
@property (nonatomic, assign) CGFloat coverCornerRadius;

/**
 *  一次性设置所有遮盖属性
 */
- (void)setUpCoverEffect:(void(^)(BOOL *isShowTitleCover,UIColor **coverColor,CGFloat *coverCornerRadius))coverEffectBlock;



/**
 刷新标题和整个界面，在调用之前，必须先确定所有的子控制器。
 */
- (void)refreshDisplay;

/**
 *  点击加号按钮
 */
- (void)showMoreMenuView;

/**
 *  隐藏menu视图按钮
 */
@property (nonatomic, weak) UIButton *cancleBtn;

/**
 *  展示分类菜单
 */
- (void)showMenuViewWithSlidePlistName:(NSString *)slideName OtherPlist:(NSString *)otherName;

/**
 *  隐藏添加分类视图
 */
- (void)cancleAddMenu:(UIButton *)button;

@end

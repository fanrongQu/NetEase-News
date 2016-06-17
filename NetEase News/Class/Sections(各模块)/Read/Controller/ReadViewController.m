//
//  ReadViewController.m
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ReadViewController.h"

// Segment高度
static CGFloat const FRSegmentH = 26;
// title字体大小
static CGFloat const titleFontSize = 13;
//title间距
static CGFloat const margin = 15;

@interface ReadViewController ()

//title的宽度
@property (nonatomic, assign) CGFloat titleWidth;
//title的字体
@property (nonatomic, strong) UIFont *titleFont;
//title整体的视图
@property (nonatomic, strong) UIView *segmentedView;
//segmented的分类数组
@property (nonatomic, strong) NSArray *items;
//选中的title
@property (nonatomic, assign) NSInteger selectIndex;
//最后一个Label
@property (nonatomic, weak) UILabel *lastTitleLabel;
/** 标题遮盖视图 */
@property (nonatomic, strong) UIView *coverView;
/** 计算上一次选中角标 */
@property (nonatomic, assign) NSInteger selIndex;
/** 记录上一次内容滚动视图偏移量 */
@property (nonatomic, assign) CGFloat lastOffsetX;

/** 记录是否点击 */
@property (nonatomic, assign) BOOL isClickTitle;

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigtionBar];
}

- (void)setNavigtionBar {
    
    
    self.items = @[@"推荐阅读",@"我的订阅"];
    [self setUpTitleWidth];
    
    self.navigationItem.titleView = self.segmentedView;
}

- (void)viewDidLayoutSubviews {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self setUpTitleWidth];
    [self setUpAllTitle];
}

- (void)setUpTitleWidth {
    
    NSInteger count = _items.count;
    
    CGFloat titleWidth = 0;
    for (NSString *title in _items) {
       
        //根据文字内容和字体大小获取文字占据的bounds
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
        
        CGFloat width = titleBounds.size.width + 2 * margin;
        
        titleWidth = titleWidth > width?titleWidth:width;
    }
    self.titleWidth = titleWidth;
    CGFloat totalWidth = titleWidth * count;
    
    CGRect frame = self.segmentedView.frame;
    frame.size.width = totalWidth;
    self.segmentedView.frame = frame;
}

- (void)setUpAllTitle {
    
    NSInteger count = _items.count;
    
    CGFloat labelW = self.titleWidth;
    
    for (int i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lastTitleLabel.frame), 0, labelW, FRSegmentH)];
        label.font = self.titleFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.items[i];
        [self.segmentedView addSubview:label];
        _lastTitleLabel = label;
    }
    
    //设置coverView的Frame
    self.coverView.frame = CGRectMake(0, 0, labelW, FRSegmentH);
    self.coverView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - 懒加载

- (UIView *)segmentedView {
    if (!_segmentedView) {
        CGRect segmentedViewF = CGRectMake(0, 0, 100, FRSegmentH);
        UIView *segmentedView = [[UIView alloc]initWithFrame:segmentedViewF];
        segmentedView.backgroundColor = [UIColor redColor];
        
        //设置圆角
        [segmentedView.layer setMasksToBounds:YES];
        [segmentedView.layer setCornerRadius:FRSegmentH * 0.5];
        //设置边框
        [segmentedView.layer setBorderWidth:1.2];
        [segmentedView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        _segmentedView = segmentedView;
    }
    return _segmentedView;
}

- (UIFont *)titleFont {
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:titleFontSize];
    }
    return _titleFont;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        [_coverView.layer setMasksToBounds:YES];
        [_coverView.layer setCornerRadius:FRSegmentH * 0.5];
        
        [self.segmentedView insertSubview:_coverView atIndex:0];
    }
    return _coverView;
}

#pragma mark - 标题点击处理
- (void)setSelectIndex:(NSInteger)selectIndex
{
    
}

// 标题按钮点击
- (void)titleClick:(UITapGestureRecognizer *)tap
{
   
}



@end

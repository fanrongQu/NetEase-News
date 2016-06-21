//
//  FRSegmentedControl.m
//  NetEase News
//
//  Created by 1860 on 16/6/16.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRSegmentedControl.h"
#import "FRSegmentedHorizonLayout.h"

// Segment高度
static CGFloat const FRSegmentH = 26;
// title字体大小
static CGFloat const titleFontSize = 13;
//title间距
static CGFloat const margin = 12;

static NSString *ID = @"FRSegmentedCollectionCell";

@interface FRSegmentedControl ()<UICollectionViewDelegate,UICollectionViewDataSource>

//title的宽度
@property (nonatomic, assign) CGFloat titleWidth;
//title的字体
@property (nonatomic, strong) UIFont *titleFont;
/** 内容滚动视图 */
@property (nonatomic, weak) UICollectionView *contentScrollView;
//segmented的分类数组
@property (nonatomic, strong) NSMutableArray *items;
//选中的title
@property (nonatomic, assign) NSInteger selectIndex;
/** 所有标题数组 */
@property (nonatomic, strong) NSMutableArray *titleLabels;
//最后一个Label
@property (nonatomic, weak) UILabel *lastTitleLabel;
/** 标题遮盖视图 */
@property (nonatomic, strong) UIView *coverView;
/* 是否初始化 */
@property (nonatomic, assign) BOOL isInitial;
/** 记录上一次内容滚动视图偏移量 */
@property (nonatomic, assign) CGFloat lastOffsetX;
/** 记录是否在动画 */
@property (nonatomic, assign) BOOL isAnimationing;

@end

@implementation FRSegmentedControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.contentFrame;
//    frame.origin.y -= 8;
    self.contentScrollView.frame = frame;
}

#pragma mark - 程序生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_isInitial == NO) {
        
        _isInitial = YES;
        
        // 注册cell
        [self.contentScrollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        
        // 没有子控制器，不需要设置标题
        if (self.childViewControllers.count == 0) return;
        
        [self setUpTitleWidth];
        
        [self setUpAllTitle];
        
    }
}


- (void)setUpTitleWidth {
    
    //获取需要显示的子控制器个数
    NSInteger count = self.childViewControllers.count;;
    
    CGFloat titleWidth = 0;
    for (int i = 0; i < count; i++) {
        
        UIViewController *vc = self.childViewControllers[i];
        
        NSString *title = vc.title;
        
        [self.items addObject:title];
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
        label.textColor = self.norColor;
        label.tag = i;
        
        // 监听标题的点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES; // 可以理解为设置label可被点击
        // 保存到数组
        [self.titleLabels addObject:label];
        
        [self.segmentedView addSubview:label];
        _lastTitleLabel = label;
        
        if (i == 0) {
            label.textColor = self.selColor;
        }
    }
    
    self.coverView.frame = CGRectMake(0, 0, labelW, FRSegmentH);
    _contentScrollView.contentSize = CGSizeMake(count * [UIScreen mainScreen].bounds.size.width, 0);
}


#pragma mark - 懒加载

- (UIColor *)norColor {
    if (!_norColor) {
        _norColor = [UIColor whiteColor];
    }
    return _norColor;
}

- (UIColor *)selColor {
    if (!_selColor) {
        _selColor = [UIColor redColor];
    }
    return _selColor;
}

- (UIColor *)overColor {
    if (!_overColor) {
        _overColor = [UIColor lightGrayColor];
    }
    return _overColor;
}

- (UIColor *)normalBackColor {
    if (!_normalBackColor) {
        _normalBackColor = [UIColor redColor];
    }
    return _normalBackColor;
}

- (UIColor *)selectBackColor {
    if (!_selectBackColor) {
        _selectBackColor = [UIColor whiteColor];
    }
    return _selectBackColor;
}

- (CGRect)contentFrame {
    if (_contentFrame.size.height == 0) {
        _contentFrame = [UIScreen mainScreen].bounds;
    }
    return _contentFrame;
}

- (UIFont *)titleFont {
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:titleFontSize];
    }
    return _titleFont;
}


- (NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        [_coverView.layer setMasksToBounds:YES];
        [_coverView.layer setCornerRadius:FRSegmentH * 0.5];
        _coverView.backgroundColor = self.selectBackColor;
        [self.segmentedView insertSubview:_coverView atIndex:0];
    }
    return _coverView;
}


- (UIView *)segmentedView {
    if (!_segmentedView) {
        CGRect segmentedViewF = CGRectMake(0, 0, 100, FRSegmentH);
        UIView *segmentedView = [[UIView alloc]initWithFrame:segmentedViewF];
        segmentedView.backgroundColor = self.normalBackColor;
        
        //设置圆角
        [segmentedView.layer setMasksToBounds:YES];
        [segmentedView.layer setCornerRadius:FRSegmentH * 0.5];
        //设置边框
        [segmentedView.layer setBorderWidth:1.2];
        [segmentedView.layer setBorderColor:[self.selectBackColor CGColor]];
        _segmentedView = segmentedView;
    }
    return _segmentedView;
}


// 懒加载内容滚动视图
- (UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil) {
        
        // 创建并设置布局属性
        FRSegmentedHorizonLayout *layout = [[FRSegmentedHorizonLayout alloc] init];
        
        UICollectionView *contentScrollView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _contentScrollView = contentScrollView;
        _contentScrollView.backgroundColor = [UIColor greenColor];
        // 设置内容滚动视图
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.dataSource = self;
        
        [self.view addSubview:contentScrollView];
        
        [_contentScrollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        
    }
    return _contentScrollView;
}



- (void)setUpSegmentedEffect:(void (^)(UIColor *__autoreleasing *, UIColor *__autoreleasing *, UIColor *__autoreleasing *, UIColor *__autoreleasing *, UIColor *__autoreleasing *))segmentedEffectBlock {
    
    UIColor *norColor;
    UIColor *selColor;
    UIColor *overColor;
    UIColor *normalBackColor;
    UIColor *selectBackColor;
    if (segmentedEffectBlock) {
        segmentedEffectBlock(&norColor,&selColor,&overColor,&normalBackColor,&selectBackColor);
        _norColor = norColor;
        _selColor = selColor;
        _overColor = overColor;
        _normalBackColor = normalBackColor;
        _selectBackColor = selectBackColor;
    }
}


#pragma mark - 标题点击处理
- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    if (self.titleLabels.count) {
        
        UILabel *label = self.titleLabels[selectIndex];
        
        [self titleLabelClick:[label.gestureRecognizers lastObject]];
    }
}

// 标题按钮点击
- (void)titleLabelClick:(UITapGestureRecognizer *)tap
{
    self.isAnimationing = YES;
    
    // 获取对应标题label
    UILabel *label = (UILabel *)tap.view;
    //设置label
    [self selectLabel:label];
    //移动遮盖
    [self moveCoverView:label];
    
    // 内容滚动视图滚动到对应位置
    CGFloat offsetX = label.tag * [UIScreen mainScreen].bounds.size.width;
    
    self.contentScrollView.contentOffset = CGPointMake(offsetX, -64);
    // 记录上一次偏移量,因为点击的时候不会调用scrollView代理记录，因此需要主动记录
    _lastOffsetX = offsetX;
}

- (void)selectLabel:(UILabel *)label {
    // 获取当前角标
    NSInteger i = label.tag;
    
    if (_selectIndex == i) {//重复点击
        // 修改选中label样式
        label.textColor = self.selColor;
        return;
    }
    //修改上一个Label样式
    UILabel *lastLabel = self.titleLabels[_selectIndex];
    lastLabel.textColor = self.norColor;
    
    _selectIndex = i;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 修改选中label样式
        label.textColor = self.selColor;
        self.isAnimationing = NO;
    });

}

/**
 *  移动遮盖
 */
- (void)moveCoverView:(UILabel *)label {
    
    __weak typeof(self) weakSelf = self;
    // 点击时候需要动画
    [UIView animateWithDuration:0.3 animations:^{
        
        CGFloat coverViewX;
        CGFloat coverViewY = 0;
        CGFloat coverViewW = label.frame.size.width;
        CGFloat coverViewH = FRSegmentH;
        coverViewX = _selectIndex * coverViewW;
        
        //设置coverView的Frame
        weakSelf.coverView.frame = CGRectMake(coverViewX, coverViewY, coverViewW, coverViewH);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 移除之前的子控件
    //    makeObjectsPerformSelector:@select（aMethod）
    //    让数组中的每个元素 都调用 aMethod方法
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 添加控制器
    UIViewController *vc = self.childViewControllers[indexPath.row];
    
    vc.view.frame = CGRectMake(0, 0, self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height);
    
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

// 减速完成后调用，每次拖拽只调用一次（松手后）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取当前角标
    NSInteger i = offsetX / screenWidth;
    
    // 选中标题
    [self selectLabel:self.titleLabels[i]];
    
    
    // 左边按钮
    NSInteger leftIndex = i - 1;
    if (leftIndex > - 1) {
        
        UILabel *leftLabel = self.titleLabels[leftIndex];
        leftLabel.textColor = self.norColor;
    }
    // 右边按钮
    NSInteger rightIndex = i + 1;
    UILabel *rightLabel = nil;
    if (rightIndex < self.titleLabels.count) {
        rightLabel = self.titleLabels[rightIndex];
        rightLabel.textColor = self.norColor;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (_titleLabels.count > 0) {
        [self scrollCoverView:offsetX];
    }
    // 记录上一次的偏移量
    _lastOffsetX = offsetX;
}


- (void)scrollCoverView:(CGFloat)offsetX {
    if (_isAnimationing) return;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    //设置coverView的Frame
    CGPoint center = self.coverView.center;
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    center.x += offsetDelta * _titleWidth / screenWidth;
    self.coverView.center = center;
    
    // 获取左边角标
    NSInteger leftIndex = offsetX / screenWidth;
    
    // 左边按钮
    UILabel *leftLabel = self.titleLabels[leftIndex];
    
    // 右边角标
    NSInteger rightIndex = leftIndex + 1;
    
    // 右边按钮
    UILabel *rightLabel = nil;
    
    if (rightIndex < self.titleLabels.count) {
        rightLabel = self.titleLabels[rightIndex];
    }
    
    
    if (offsetDelta > 0) { // 往右边
        rightLabel.textColor = self.overColor;
        
        leftLabel.textColor = self.overColor;
        
    } else if(offsetDelta < 0){ // 往左边
        
        rightLabel.textColor = self.overColor;
        
        leftLabel.textColor = self.overColor;
        
    }
}

@end

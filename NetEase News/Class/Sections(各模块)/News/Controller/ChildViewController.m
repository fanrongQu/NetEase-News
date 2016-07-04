//
//  ChildViewController.m
//  NetEase News
//
//  Created by 1860 on 16/6/15.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ChildViewController.h"
#import "ADCollectionViewCell.h"

/** 顶部轮播广告的宽高比 */
static CGFloat const collectionViewWH = 0.55;
/** 顶部轮播广告的最大sections */
static CGFloat const MaxSections = 100;

/**  CollectionViewCell标记  */
static NSString * const CollectionViewCellID = @"CollectionViewCell";

@interface ChildViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
/**  是否是第一次加载页面 */
@property (nonatomic, assign) BOOL isFirstLoad;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *newses;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ChildViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在这里设置代理，记得不用的时候需要置nil，否则影响内存的释放
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    if (!_isFirstLoad) {
    
        self.newses = @[@"轮播1",@"轮播2",@"轮播3",@"轮播4"];
        
        [self setTableHeaderView];
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:MaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        
        _isFirstLoad = YES;
    }
    //在这里添加定时器，不用的时候移除，节省程序的运行内存
    [self addTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    //不用的时候代理置nil，否则影响内存的释放
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    
    self.collectionView.dataSource = nil;
    self.collectionView.delegate = nil;
    //在这里移除定时器，节省程序的运行内存
    [self removeTimer];
}


- (void)dealloc {
    if (_tableView != nil) {
        _tableView = nil;
    }
    if (_collectionView != nil) {
        _collectionView = nil;
    }
}

/**
 *  设置顶部轮播
 */
- (void)setTableHeaderView {
    //可以根据headerView视图的内容显示headerView的高度
    NSArray *array = [self headerViewWithHeight:self.view.frame.size.height addToView:self.view];
    UIView *headerView = [array firstObject];
    [headerView layoutIfNeeded];
    UIView *endView = [array lastObject];
    CGFloat headerViewH = endView.frame.size.height + endView.frame.origin.y;
    
    [headerView removeFromSuperview];
    [self headerViewWithHeight:headerViewH addToView:nil];
    
}

- (NSArray *)headerViewWithHeight:(CGFloat)height addToView:(UIView *)toView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    
    if (toView) {
        [toView addSubview:headerView];
    } else {
        self.tableView.tableHeaderView = headerView;
    }
    
    [headerView addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreenWidth * collectionViewWH);
    }];
    
    [headerView insertSubview:self.pageControl aboveSubview:_collectionView];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(2);
        make.right.mas_equalTo(-15);
    }];
    
    return @[headerView, self.collectionView];
}

// 添加定时器
-(void) addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.6 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 删除定时器
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextpage{
    NSLog(@"%@",self.title);
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    //自动滚动时首选滚动回最中间的Item上，保证了最小分组时实现无限滚动效果
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:MaxSections / 2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.newses.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return MaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.newses.count;;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellID forIndexPath:indexPath];
    
    NSString *title = [NSString stringWithFormat:@"%@--%@",self.title,_newses[indexPath.row]];
    [cell setADImage:nil ADtitle:title];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog_func();
}


#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog_func();
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {//设置页码
        int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.newses.count;
        self.pageControl.currentPage = page;
    }
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.collectionView) {
        [self removeTimer];
    }
}

// 当用户停止的时候调用
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.collectionView) {
        [self addTimer];
    }
}


#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenWidth * collectionViewWH);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        //注册cell
        [_collectionView registerClass:[ADCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellID];
        
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.enabled = NO;
        _pageControl.numberOfPages = self.newses.count;
    }
    return _pageControl;
}


@end

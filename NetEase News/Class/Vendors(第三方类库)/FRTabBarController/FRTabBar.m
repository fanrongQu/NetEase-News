//
//  FRTabBar.m
//  爱鲜蜂
//
//  Created by 1860 on 16/4/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRTabBar.h"
#import "FRTabBarItem.h"

@interface FRTabBar ()
@property (nonatomic, strong) NSMutableArray *tabBarItems;
@property (nonatomic, weak) FRTabBarItem *selectedItem;

@end

@implementation FRTabBar

- (NSMutableArray *)tabBarItems {
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}

- (void)addTabBarItemWithItem:(UITabBarItem *)tabBarItem {
    //创建按钮
    FRTabBarItem *item = [[FRTabBarItem alloc]init];
    [self addSubview:item];
    
    //按钮的颜色
    item.normalColor = self.normalColor;
    item.selectedColor = self.selectedColor;
    
    // 添加按钮到数组中
    [self.tabBarItems addObject:item];
    
    // 2.设置数据
    item.tabBarItem = tabBarItem;
    
    // 3.监听按钮点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.tabBarItems.count == 1) {
        [self itemClick:item];
    }
}

/**
 *  监听按钮点击
 */
- (void)itemClick:(FRTabBarItem *)item
{
    //如果需要点击刷新则不加判断
    if (self.selectedItem != item) {
        // 1.通知代理
        if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
            [self.delegate tabBar:self didSelectedButtonFrom:self.selectedItem.tag to:item.tag];
        }
        // 2.设置按钮的状态
        self.selectedItem.selected = NO;
        item.selected = YES;
        self.selectedItem = item;
    }
    [self imgAnimate:item];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.tabBarItems.count; index++) {
        // 1.取出按钮
        FRTabBarItem *button = self.tabBarItems[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
     
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}

#pragma mark 闪烁动画
- (void)imgAnimate:(UIButton*)btn{
    
    UIView *view=btn.subviews[0];
    
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
     } completion:^(BOOL finished){//do other thing
         [UIView animateWithDuration:0.1 animations:
          ^(void){
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1, 1.1);
          } completion:^(BOOL finished){//do other thing
              [UIView animateWithDuration:0.1 animations:
               ^(void){
                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
               } completion:^(BOOL finished){//do other thing
                   [UIView animateWithDuration:0.2 animations:
                    ^(void){
                        view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                    } completion:^(BOOL finished){//do other thing
                    }];

               }];
          }];
     }];
}



@end

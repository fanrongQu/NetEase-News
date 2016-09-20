//
//  FRTabBar.h
//  爱鲜蜂
//
//  Created by 1860 on 16/4/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRTabBar;

@protocol FRTabBarDelegate <NSObject>

@optional
- (void)tabBar:(FRTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface FRTabBar : UIView
/**  普通状态item的颜色  */
@property (nonatomic, strong) UIColor *normalColor;
/**  选中状态item的颜色  */
@property (nonatomic, strong) UIColor *selectedColor;

- (void)addTabBarItemWithItem:(UITabBarItem *)tabBarItem;

@property (nonatomic, weak) id<FRTabBarDelegate> delegate;

@end

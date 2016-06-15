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

- (void)addTabBarItemWithItem:(UITabBarItem *)tabBarItem;

@property (nonatomic, weak) id<FRTabBarDelegate> delegate;

@end

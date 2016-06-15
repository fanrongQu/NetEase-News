//
//  RootNavigationController.m
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBarColor:^(UIColor *__autoreleasing *navigationBarColor, UIColor *__autoreleasing *navigationBarTitleColor, UIColor *__autoreleasing *itemNormalColor, UIColor *__autoreleasing *itemDisabledColor, UIColor *__autoreleasing *tintColor) {
        *navigationBarColor = kSubjectColor_day;
        *navigationBarTitleColor = [UIColor whiteColor];
        *itemNormalColor = [UIColor whiteColor];
        *tintColor = [UIColor whiteColor];
    }];
}

@end

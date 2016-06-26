//
//  FRSlideMenuCollectionViewCell.m
//  NetEase News
//
//  Created by 1860 on 16/6/26.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRSlideMenuCollectionViewCell.h"

@interface FRSlideMenuCollectionViewCell()


@end

@implementation FRSlideMenuCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        frame.origin = CGPointMake(0, 0);
        UILabel *titleL = [[UILabel alloc] initWithFrame:frame];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = [UIFont systemFontOfSize:14];
        [titleL.layer setMasksToBounds:YES];
        [titleL.layer setCornerRadius:frame.size.height * 0.5];
        [self addSubview:titleL];
        
        self.titleL = titleL;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
//    CGRect frame = self.contentView.frame;
//    frame.origin = CGPointMake(0, 0);
//    self.titleL.frame = frame;
    self.titleL.text = title;
    
}

@end

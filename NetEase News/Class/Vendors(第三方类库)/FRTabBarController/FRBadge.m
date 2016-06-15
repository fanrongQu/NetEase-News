//
//  FRBadge.m
//  爱鲜蜂
//
//  Created by 1860 on 16/4/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRBadge.h"

@implementation FRBadge

- (instancetype)initWithFrame:(CGRect)frame {
    frame.size.width = 16;
    frame.size.height = frame.size.width;
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        
        self.font = [UIFont systemFontOfSize:10];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = [badgeValue copy];
    if (badgeValue) {
        self.hidden = NO;
        //设置文字
        self.text = badgeValue;
        
        //设置frame
        CGRect frame = self.frame;
        [self.layer setMasksToBounds:YES];
        self.layer.cornerRadius = frame.size.height / 2;
        
        if (badgeValue.length > 1) {
            //文字尺寸
            NSDictionary *attributes = @{NSFontAttributeName : self.font};
            CGSize badgeSize = [badgeValue sizeWithAttributes:attributes];
            frame.size.width = badgeSize.width + 7;
        }
        self.frame = frame;
    }else {
        self.hidden = YES;
    }
}

@end

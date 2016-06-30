//
//  FRSlideMenuCollectionViewCell.m
//  NetEase News
//
//  Created by 1860 on 16/6/26.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRSlideMenuCollectionViewCell.h"

@interface FRSlideMenuCollectionViewCell()

@property (nonatomic, strong) UILongPressGestureRecognizer * longPressGr;

@end

@implementation FRSlideMenuCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin = CGPointMake(0, 0);
        UILabel *titleL = [[UILabel alloc] initWithFrame:frame];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = [UIFont systemFontOfSize:14];
        [titleL.layer setMasksToBounds:YES];
        [titleL.layer setCornerRadius:frame.size.height * 0.5];
        self.titleL = titleL;
        [self addSubview:titleL];
        
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        [deleteBtn setImage:[UIImage imageNamed:@"deleteItem"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn = deleteBtn;
        [self addSubview:deleteBtn];
        
        UILongPressGestureRecognizer *longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
        longPressGr.minimumPressDuration = 0.6;
        _longPressGr = longPressGr;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = title;
    
    if (_LongPressGesture) {
        [self addGestureRecognizer:_longPressGr];
    }else {
        [self removeGestureRecognizer:_longPressGr];
    }
}


- (void)deleteBtnClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(choseDeleteButton:)]) {
        [_delegate choseDeleteButton:sender];
    }
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)longGesture
{
    if (_deleteBtn.hidden) {
        if(longGesture.state == UIGestureRecognizerStateBegan)
        {
            if ([_delegate respondsToSelector:@selector(longPressButton)]) {
                [_delegate longPressButton];
            }
            
            NSLog(@"手势");
        }
    }else {
        NSLog(@"移动手势");
        if ([_delegate respondsToSelector:@selector(moveCollectionViewCell:)]) {
            [_delegate moveCollectionViewCell:longGesture];
        }
    }
}

@end

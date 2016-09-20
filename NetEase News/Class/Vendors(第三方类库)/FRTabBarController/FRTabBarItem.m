//
//  FRTabBarItem.m
//  爱鲜蜂
//
//  Created by 1860 on 16/4/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#define FRTabBarItemImageRatio 0.6

#import "FRTabBarItem.h"
#import "FRBadge.h"

@interface FRTabBarItem ()

@property (nonatomic, weak) FRBadge *badgeLabel;

/**  初始化  */
@property (nonatomic, assign) BOOL firstLoad;

@end

@implementation FRTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        // 添加一个提醒数字按钮
        FRBadge *badgeLabel = [[FRBadge alloc] init];
        badgeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeLabel];
        self.badgeLabel = badgeLabel;
        
        self.firstLoad = YES;
    }
    return self;
}
//重写setHighlighted:方法，去掉按钮高亮状态
- (void)setHighlighted:(BOOL)highlighted {
    
}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * FRTabBarItemImageRatio;
    return CGRectMake(0, 5, imageW, imageH - 5);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * FRTabBarItemImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY - 2;
    return CGRectMake(0, titleY, titleW, titleH);
}

// 设置tabBarItem
- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    _tabBarItem = tabBarItem;
    
    // KVO 监听属性改变
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"title" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"image" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}


- (void)dealloc
{
    [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
    [self.tabBarItem removeObserver:self forKeyPath:@"title"];
    [self.tabBarItem removeObserver:self forKeyPath:@"image"];
    [self.tabBarItem removeObserver:self forKeyPath:@"selectedImage"];
}

/**
 *  监听到某个对象的属性改变了,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.firstLoad) {
        //根据图片设置文字颜色
        UIColor *normalColor = self.normalColor ? self.normalColor : [self mostColorWithImage:self.tabBarItem.image];
        [self setTitleColor:normalColor forState:UIControlStateNormal];
        UIColor *selectedColor = self.selectedColor ? self.selectedColor : [self mostColorWithImage:self.tabBarItem.selectedImage];
        [self setTitleColor:selectedColor forState:UIControlStateSelected];
        
        // 设置文字
        [self setTitle:self.tabBarItem.title forState:UIControlStateSelected];
        [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
        
        // 设置图片
        [self setImage:[self compressImage:self.tabBarItem.image] forState:UIControlStateNormal];
        [self setImage:[self compressImage:self.tabBarItem.selectedImage] forState:UIControlStateSelected];
        
        
        self.firstLoad = NO;
    }
    // 设置提醒数字
    self.badgeLabel.badgeValue = self.tabBarItem.badgeValue;
    
    // 设置提醒数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeLabel.frame.size.width - 10;
    CGRect badgeF = self.badgeLabel.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeLabel.frame = badgeF;
}
/**
 *  压缩图片到指定尺寸
 */
- (UIImage *)compressImage:(UIImage *)image
{
    CGSize size = image.size;
    CGFloat width = 22;
    if (size.width <= width && size.height <= width) {
        return image;
    }
    
    CGFloat height = width * size.height / size.width;
    size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    CGRect rect = {{0,0}, size};
    [image drawInRect:rect];
    UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return compressedImg;
}

- (UIColor*)mostColorWithImage:(UIImage *)image{
    
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    
    CGSize thumbSize=CGSizeMake(60, 60);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,bitmapInfo);
    
    
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    
    CGContextDrawImage(context, drawRect, image.CGImage);
    
    CGColorSpaceRelease(colorSpace);
    
    
    //第二步 取每个点的像素值
    
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4*(x*y);
            
            int red = data[offset];
            
            int green = data[offset+1];
            
            int blue = data[offset+2];
            
            int alpha =  data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            //剔除透明区域
            if (alpha != 0) {
                [cls addObject:clr];
            }
        }
        
    }
    
    CGContextRelease(context);
    
    //第三步 找到出现次数最多的那个颜色
    
    NSEnumerator *enumerator = [cls objectEnumerator];
    
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    
    NSUInteger MaxCount=0;
    
    while ( (curColor = [enumerator nextObject]) != nil ) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        
        MaxColor=curColor;
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
    
}

@end

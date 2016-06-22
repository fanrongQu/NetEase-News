//
//  NewsMenuModel.h
//  NetEase News
//
//  Created by 1860 on 16/6/21.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BaseModel.h"

@class NewsMenuList;
@interface NewsMenuModel : BaseModel

@property (nonatomic, strong) NSArray<NewsMenuList *> *tList;

@end
@interface NewsMenuList : NSObject

@property (nonatomic, copy) NSString *tname;

@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *subnum;

@property (nonatomic, assign) NSInteger isHot;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger isNew;

@property (nonatomic, copy) NSString *template;

@property (nonatomic, assign) NSInteger recommendOrder;

@property (nonatomic, copy) NSString *alias;

@property (nonatomic, assign) NSInteger bannerOrder;

@property (nonatomic, assign) BOOL hasCover;

@property (nonatomic, copy) NSString *cid;

@property (nonatomic, assign) BOOL hasIcon;

@property (nonatomic, copy) NSString *ename;

@property (nonatomic, copy) NSString *recommend;

@property (nonatomic, assign) BOOL headLine;

@property (nonatomic, copy) NSString *topicid;

@property (nonatomic, assign) NSInteger special;

@property (nonatomic, copy) NSString *showType;

@end


//
//  AppMacro.h
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  项目的相关宏

#ifndef AppMacro_h
#define AppMacro_h

/**
 *  文件操作
 */
#define NewsSlideMenuPlist   @"slideMenu"//选中的分类
#define NewsMoreMenuPlist   @"moreMenu"//选中的分类


#define Domain @"http://c.m.163.com"

/**
 *  广告
 */
#define ADApi @"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1"


/**
 *  新闻
 */

//首页分类
#define NewsMenuApi @"http://c.m.163.com/nc/topicset/ios/subscribe/manage/listspecial.html"
//首页新闻列表
#define HomeListApi [DOMAIN stringByAppendingString:@"/nc/article/headline/T1348647853363/0-20.html"];
//新闻详情 BQ1OEHLC00011229文章参数
#define HomeNewsDetail @"http://comment.api.163.com/api/json/post/list/new/hot/news_shehui7_bbs/BQ1OEHLC00011229/0/10/10/2/2"
//新闻相关评论
#define HomeNewsComment @"http://c.m.163.com/nc/article/BQ35OBPH00014SEH/full.html"

//推荐阅读
#define RecommendReads @"http://c.3g.163.com/recommend/getSubDocPic?from=yuedu&passport=&devId=u2dIz5dd9lxqWFr8QaNGuWF%2BXrIiGBotuUpLgDpC4dotRzgcp9cEnq5fqvrzrrUt&size=20"



#endif /* AppMacro_h */

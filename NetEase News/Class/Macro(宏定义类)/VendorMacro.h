//
//  VendorMacro.h
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  第三方相关宏定义

#ifndef VendorMacro_h
#define VendorMacro_h

//自己封装的类库
#import "FRNavigationController.h"
#import "FRPlist.h"//plist文件操作

//第三方框架头文件引入
#import "AFNetworking.h"//网络请求框架
#import "Masonry.h"//链式结构的AutoLayout的第三方类库
#import "MBProgressHUD.h"//实现安卓toast风格提示，弹出提示框架
#import "MJExtension.h"//优秀的Json解析类库
#import "MJRefresh.h"//优秀的滚动视图头部和脚步刷新效果
#import "UIImageView+WebCache.h"//让UIKit框架拥有网络功能,为UIImageView设置网络图片
#import "UIButton+WebCache.h"//让UIKit框架拥有网络功能,为UIButton设置网络图片
#import "NSData+Category.h"
#import "UIView+Frame.h"

/**
 *  Github开源的一个应用于iOS和OS开发的响应式编程、函数式编程框架，简称RAC
 *
 *  常见用法：代替代理、代替KVO、代替通知、监听事件、监听文本框文字变化、处理当界面有多次请求时，需要都获取到数据时，才能展示界面等
 *
 *  参考技术博客： http://www.jianshu.com/p/87ef6720a096
 *               http://www.jianshu.com/p/e10e5ca413b7
 *               http://benbeng.leanote.com/post/ReactiveCocoaTutorial-part1
 */
#import "ReactiveObjC.h"




#endif /* VendorMacro_h */

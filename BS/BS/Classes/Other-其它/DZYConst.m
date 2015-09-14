
// DZYConst.m： 定义所有的全局常量

#import <UIKit/UIKit.h>

/** 请求路径 */
NSString * const DZYRequestURL = @"http://api.budejie.com/api/api_open.php";

/** 统一的间距 */
CGFloat const DZYCommonMargin = 10;

/**
 *  统一的较小的间距
 */
CGFloat const DZYCommonSmallMargin = 5;

/**
 *  导航栏最大的Y值
 */
CGFloat const DZYNavBarMaxY = 64;

/**
 *  标签的高度
 */
CGFloat const DZYTagH = 25;

/**
 *  UITabBar高度
 */
CGFloat const DZYTabBarH = 49;

/**
 *  DZYTitlesView的高度
 */
CGFloat const DZYTitlesViewH = 35;

/**
 全局常量的写法
 1.仅限于本文件访问
 在本文件（.m）中写下面的代码
 static 类型 const 常量名 = 常量值;
 
 2.全世界都要访问
 1> 在DZYConst.m文件中
 #import <UIKit/UIKit.h>
 类型 const 常量名 = 常量值;
 
 2> 在DZYConst.h文件中
 #import <UIKit/UIKit.h>
 UIKIT _EXTERN 类型 const 常量名;
 
 3> 在pch文件中包含DZYConst.h文件
 #import "DZYConst.h"
 */
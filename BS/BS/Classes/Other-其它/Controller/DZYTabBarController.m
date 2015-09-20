//
//  DZYTabBarController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTabBarController.h"
#import "DZYEssenceViewController.h"
#import "DZYFriendTrendsViewController.h"
#import "DZYMeViewController.h"
#import "DZYNewViewController.h"

#import "DZYTabBar.h"
#import "DZYNavigationController.h"

@interface DZYTabBarController ()

@end

@implementation DZYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置item属性
    [self setUpItem];

    // 添加所有子控制器
    [self setUpChildVc];
    
    // 处理TabBar
    [self setUpTabBar];
}

/**
 *  处理TabBar
 */
- (void)setUpTabBar
{
    [self setValue:[[DZYTabBar alloc] init] forKeyPath:@"tabBar"];
}


/**
 *  添加所有的子控制器
 */
- (void)setUpChildVc
{
    [self setUpChildVc:[[DZYFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpChildVc:[[DZYEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpChildVc:[[DZYNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    
    [self setUpChildVc:[[DZYMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}

/**
 *  添加一个子控制器器
 */
- (void)setUpChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 包装一个导航控制器
    DZYNavigationController *nav = [[DZYNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    // 设置子控制器的tabBarItem
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
}

/**
 *  设置item属性
 */
- (void)setUpItem
{
    // UIControlStateNormal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 文字大小
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelected状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 统一给所有的UITabBarItem设置文字属性
    // 只有后面带有UI_APPEARANCE_SELECTOR的属性或方法, 才可以通过appearance对象来统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end

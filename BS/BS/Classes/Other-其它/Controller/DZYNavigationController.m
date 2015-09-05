//
//  DZYNavigationController.m
//  BS
//
//  Created by dzy on 15/9/5.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYNavigationController.h"

@interface DZYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation DZYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 只要修改了系统默认的导航条按钮 左滑手势功能就会消失
    // interactivePopGestureRecognizer 用户交互管理
    self.interactivePopGestureRecognizer.delegate = self;
    
    // 还可以通过apperance来设置
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航条的背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count >= 1) {
        
        // 左上角的返回
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES;//隐藏底部条
    }
    
    [super pushViewController:viewController animated:animated];


}

- (void)back
{
    // 本身就是导航控制器 self.navigationController -》self
    [self popViewControllerAnimated:YES];
}

#pragma mark -<UIGestureRecognizerDelegate>
/**
 *  每次触发左滑手势的时候就会调用一次 如果是yes说明手势好使
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{

    return self.childViewControllers.count > 1;
}
@end

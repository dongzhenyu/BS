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

}
// 都是通过自己的导航控制器push过去的 只要重写了push方法 那么会影响所有的子控制器显示问题
// 重写了父类 但是什么都没有写 所有什么都不显示  要想显示 还要调用父类super方法
/**
 *  拦截所有push进来的子控制器
 *
 *  @param viewController 每一次push进来的子控制器
 *  @param animated       yes
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    DZYLog(@"%s %@", __func__, viewController);
    
//    if (不是第一个子控制器的时候才需要设置返回按钮) {
    
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
    
#warning 调用顺序 执行viewController.view这句代码的时候 会调用该控制器viewDidLoad方法 所以在那个控制器的viewDidLoad设置背景颜色不会显示 只有在那个控制器的viewWillAppear方法设置才有效果 执行顺序是当viewController.view.backgroundColor = DZYCommonBgColor;执行完毕 来到下面的pushViewController方法会再次调用控制器的viewDidLoad方法 所以在viewWillAppear里设置颜色是有效的
    
    
    // 设置子控制器的颜色
//    viewController.view.backgroundColor = DZYCommonBgColor;
//    NSLog(@"11111");
    
    // 调用这个方法的时候 就会创建viewController的view 会调用viewController的viewDidLoad方法 把返回按钮给覆盖
    // 如果将这个方法写在上面 就没办法进行一些个性化的设置
    // 如果写在上面 要把判断条件改为大于等于2才可以
    [super pushViewController:viewController animated:animated];

//    DZYLog(@"1111111");

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
    // 在这里要处理一下 要么会出现卡死的现象 所以发现是第一个 就应该禁止手势
//    if (self.childViewControllers.count == 1) return NO;
//    return YES;
    return self.childViewControllers.count > 1;
}
@end

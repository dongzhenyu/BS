//
//  DZYTabBar.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTabBar.h"
#import "DZYPublishViewController.h"

@interface DZYTabBar ()

// 发布按钮
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation DZYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景图片
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        // 自动布局尺寸
        [publishButton sizeToFit];
        
        // 给发布按钮添加监听
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publishClick
{
    DZYPublishViewController *publish = [[DZYPublishViewController alloc] init];
    
    [self.window.rootViewController presentViewController:publish animated:NO completion:nil];
    
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // tabBar的尺寸
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的位置
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 按钮索引
    int index = 0;
    
    // 按钮的尺寸
    CGFloat tabBarButtonW = width / 5;
    CGFloat tabBarButtonH = height;
    CGFloat tabBarButtonY = 0;
    
    // 设置4个tabBarButton的frame
    for (UIView *tabBarButton in self.subviews) {
        
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        
        // 计算按钮X的值
        CGFloat tabBarButtonX = index * tabBarButtonW;
        if (index >= 2) { // 后面的两个button增加一个宽度的x值
            tabBarButtonX += tabBarButtonW;
        }
        
        // 设置tabBarButton的frame
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        
        // 增加索引
        index++;
        
    }
    
}

@end

//
//  DZYPostWordToolbar.m
//  BS
//
//  Created by dzy on 15/9/11.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYPostWordToolbar.h"
#import "DZYNavigationController.h"
#import "DZYAddTagViewController.h"

@interface DZYPostWordToolbar ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation DZYPostWordToolbar

// 只需要加载一次
- (void)awakeFromNib
{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
}

- (void)addClick
{
    // A --modal--> B
    // A.presentedViewController == B
    // B.presentingViewController == A
    
    // 把这个控制器包装成导航控制器
    DZYAddTagViewController *add = [[DZYAddTagViewController alloc] init];
    DZYNavigationController *nav = [[DZYNavigationController alloc] initWithRootViewController:add];
    // 拿到窗口根控制器曾经modal出来的发表文字所在的导航控制器
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    [vc presentViewController:nav animated:YES completion:nil];
}

@end

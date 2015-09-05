//
//  DZYNerViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYNewViewController.h"

@interface DZYNewViewController ()

@end

@implementation DZYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = DZYCommonBgColor;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏左边的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

/**
 * 左上角按钮点击
 */
- (void)tagClick
{
    DZYLogFunc;
}


@end

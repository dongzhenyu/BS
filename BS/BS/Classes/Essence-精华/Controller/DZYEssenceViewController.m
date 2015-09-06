//
//  DZYEssenceViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYEssenceViewController.h"

#import "DZYTagViewController.h"

@interface DZYEssenceViewController ()

@end

@implementation DZYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 100, 100, 100);
    [imageView setHeader:@"https://www.baidu.com/img/bd_logo1.png"];
    [self.view addSubview:imageView];
    
    self.view.backgroundColor = DZYCommonBgColor;

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

/**
 *  左上角按钮点击
 */
- (void)tagClick
{
    DZYTagViewController *tag = [[DZYTagViewController alloc] init];
    [self.navigationController pushViewController:tag animated:YES];
}


@end

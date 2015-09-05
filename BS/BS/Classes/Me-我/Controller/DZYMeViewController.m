//
//  DZYMeViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYMeViewController.h"
#import "DZYSettingViewController.h"

@interface DZYMeViewController ()

@end

@implementation DZYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DZYCommonBgColor;
    self.navigationItem.title = @"我的";
    
    // 导航条右边的内容
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];

}

- (void)moonClick
{
    DZYLogFunc;
}

- (void)settingClick
{
    DZYSettingViewController *setting = [[DZYSettingViewController alloc] init];
//    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}


@end

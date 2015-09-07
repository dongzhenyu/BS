//
//  DZYMeViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYMeViewController.h"
#import "DZYSettingViewController.h"
#import "DZYMeCell.h"
#import "DZYMeFooterView.h"

@interface DZYMeViewController ()

@end

@implementation DZYMeViewController

static NSString * const DZYMeCellId = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
    
    [self setUpTable];

}

- (void)setUpTable
{
    self.tableView.backgroundColor = DZYCommonBgColor;

    // 注册重用标识
    [self.tableView registerClass:[DZYMeCell class] forCellReuseIdentifier:DZYMeCellId];
    // 组头或者组尾的高度
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = DZYCommonMargin;
    
    // 设置内边距 (-25 所有内容向上移动25)
    self.tableView.contentInset = UIEdgeInsetsMake(DZYCommonMargin - 35, 0, 0, 0);
    
    // 设置footView
    self.tableView.tableFooterView = [[DZYMeFooterView alloc] init];
    
}

- (void)setUpNav
{
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

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZYMeCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYMeCellId];

    if (indexPath.section == 0) {
        cell.textLabel.text = @"登陆/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    } else {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}


@end

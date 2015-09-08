//
//  DZYSettingViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYSettingViewController.h"
#import <SDImageCache.h>
#import "DZYClearCachesCell.h"
#import "DZYThirdCell.h"

@interface DZYSettingViewController ()

@end

@implementation DZYSettingViewController

static NSString * const DZYClearCacheCellId = @"clearCache";
static NSString * const DZYThirdCellId = @"third";
static NSString * const DZYOtherCellId = @"other";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    self.view.backgroundColor = DZYCommonBgColor;
    
    [self.tableView registerClass:[DZYClearCachesCell class] forCellReuseIdentifier:DZYClearCacheCellId];
    [self.tableView registerClass:[DZYThirdCell class] forCellReuseIdentifier:DZYThirdCellId];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DZYOtherCellId];
    
    // setting contentInset
    self.tableView.contentInset = UIEdgeInsetsMake(DZYCommonMargin - 35, 0, 0, 0);
    
//    DZYLog(@"%f", @"/Users/dongzhenyu/Desktop/未命名文件夹/02-头尾式动画.mp4".fileSize / 1000.0 / 1000.0);

}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) { // 清除缓存的cell
        DZYClearCachesCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYClearCacheCellId];
        [cell updateStatus];
        return cell;
    } else if (indexPath.section == 1 && indexPath.row == 2){
        DZYThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYThirdCellId];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYOtherCellId];
        cell.textLabel.text = [NSString stringWithFormat:@"%zd -- %zd", indexPath.section, indexPath.row];
        return cell;
    }
}

/**
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
 // 计算缓存大小
 //  NSString *cachesFile = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"default"];
 
 NSString *cachesFile = @"/Users/dongzhenyu/Desktop/未命名文件夹";
 
 NSString *text = [NSString stringWithFormat:@"清除缓存(%.1fMB)", cachesFile.fileSize / 1000.0 / 1000.0];
 dispatch_async(dispatch_get_main_queue(), ^{
 cell.textLabel.text = text;
 });
 });
 */

#pragma mark - <代理方法>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 清除缓存
    DZYClearCachesCell *cell = (DZYClearCachesCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [cell clearCache];
}
@end

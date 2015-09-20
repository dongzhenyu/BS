//
//  DZYRecommendFollowViewController.m
//  BS
//
//  Created by dzy on 15/9/21.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYRecommendFollowViewController.h"
#import "DZYCategoryCell.h"
#import "DZYUserCell.h"

@interface DZYRecommendFollowViewController () <UITableViewDelegate, UITableViewDataSource>

/** 左边👈 ←的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

/** 右边👉 →的用户表格*/
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@end

@implementation DZYRecommendFollowViewController

static NSString * const DZYCategoryCellId = @"category";
static NSString * const DZYUserCellId = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = UIEdgeInsetsMake(DZYNavBarMaxY, 0, 0, 0);
    self.leftTableView.contentInset = inset;
    self.leftTableView.scrollIndicatorInsets = inset;
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZYCategoryCell class]) bundle:nil] forCellReuseIdentifier:DZYCategoryCellId];
    
    self.rightTableView.contentInset = inset;
    self.rightTableView.scrollIndicatorInsets = inset;
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZYUserCell class]) bundle:nil] forCellReuseIdentifier:DZYUserCellId];
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return 20;
    } else {
        return 40;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        DZYCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYCategoryCellId];
        cell.textLabel.text = [NSString stringWithFormat:@"----%zd", indexPath.row];
        return cell;
    } else {
        DZYUserCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYUserCellId];
        cell.textLabel.text = [NSString stringWithFormat:@"----%zd", indexPath.row];
        return cell;
    }
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        DZYLog(@"点击了👈 ←的%zd行", indexPath.row);
    } else {
        DZYLog(@"点击了👉 →的%zd行", indexPath.row);
    }
}



@end

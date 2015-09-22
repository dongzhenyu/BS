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
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "DZYFollowCategory.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "DZYFollowUser.h"

@interface DZYRecommendFollowViewController () <UITableViewDelegate, UITableViewDataSource>

/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
/** 左边👈 ←的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
/** 右边👉 →的用户表格*/
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
/** 左边👈类别数据 */
@property (nonatomic, strong) NSArray *categories;

@end

@implementation DZYRecommendFollowViewController

#pragma mark - lazy
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
static NSString * const DZYCategoryCellId = @"category";
static NSString * const DZYUserCellId = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupRefresh];
    
    [self loadCategories];
}

- (void)setupRefresh
{
    self.rightTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.rightTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

- (void)setupTable
{
    self.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = UIEdgeInsetsMake(DZYNavBarMaxY, 0, 0, 0);
    self.leftTableView.contentInset = inset;
    self.leftTableView.scrollIndicatorInsets = inset;
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZYCategoryCell class]) bundle:nil] forCellReuseIdentifier:DZYCategoryCellId];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.rightTableView.rowHeight = 70;
    self.rightTableView.contentInset = inset;
    self.rightTableView.scrollIndicatorInsets = inset;
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZYUserCell class]) bundle:nil] forCellReuseIdentifier:DZYUserCellId];
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)dealloc
{
    [self.manager invalidateSessionCancelingTasks:YES];
}

#pragma mark - 加载数据
- (void)loadCategories
{
    // 弹框
    [SVProgressHUD show];
    
    DZYWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:DZYRequestURL parameters:params success:^(NSURLSessionDataTask * __nonnull task, id responseObject) {
        [SVProgressHUD dismiss];
        // 字典模型 - 模型数组
        weakSelf.categories = [DZYFollowCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [weakSelf.leftTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        // 关闭弹框
        [SVProgressHUD dismiss];

    }];

}

- (void)loadNewUsers
{
//    DZYLogFunc;
    // 取消之前的所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    DZYWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    DZYFollowCategory *selectedCategory = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    params[@"category_id"] = selectedCategory.ID;
    
    [self.manager GET:DZYRequestURL parameters:params success:^(NSURLSessionDataTask * __nonnull task, id responseObject) {
//        DZYWriteToPlist(responseObject, @"category");
        // 重置页数
        selectedCategory.page = 1;
        // 存储总数
        selectedCategory.total = [responseObject[@"total"] intValue];
        
        // 存储用户数据
        selectedCategory.users = [DZYFollowUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [weakSelf.rightTableView reloadData];
        // 结束刷新
        [weakSelf.rightTableView.header endRefreshing];
        
        if (selectedCategory.users.count >= selectedCategory.total) {
            // 这组用户的所有数据都已经加载完毕
            weakSelf.rightTableView.footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        // 结束刷新
        [weakSelf.rightTableView.header endRefreshing];
        
    }];
}

- (void)loadMoreUsers
{
    // 取消之前所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    DZYWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    DZYFollowCategory *selectedCategory = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    params[@"category_id"] = selectedCategory.ID;
    NSInteger page = selectedCategory.page + 1;
    params[@"page"] = @(page);
    
    [self.manager GET:DZYRequestURL parameters:params success:^(NSURLSessionDataTask * __nonnull task, id responseObject) {
        
        // 设置当前最新的页码
        selectedCategory.page = page;
        // 存数总数
        
      // 追加新的数据到以前的数组中
        NSArray *newUsers = [DZYFollowUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [selectedCategory.users addObjectsFromArray:newUsers];
        
        // 刷新右边的表格
        [weakSelf.rightTableView reloadData];
        
        // 结束刷新
        [weakSelf.rightTableView.footer endRefreshing];
        
        if (selectedCategory.users.count >= selectedCategory.total) {
            // 这组用户的所有数据都已经加载完毕
            weakSelf.rightTableView.footer.hidden = YES;
        } else { // 还可能会有下一页数据
            // 结束刷新
            [weakSelf.rightTableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        // 结束刷新
        [weakSelf.rightTableView.footer endRefreshing];
    }];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.categories.count;
    } else {
        // 左边选中的类别
        DZYFollowCategory *selectedCategory = self.categories[self.leftTableView.indexPathForSelectedRow.row];
        
        return selectedCategory.users.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        DZYCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYCategoryCellId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else {
        DZYUserCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYUserCellId];
        // 左边选中的类别
        DZYFollowCategory *selectedCategory = self.categories[self.leftTableView.indexPathForSelectedRow.row];
        cell.user = selectedCategory.users[indexPath.row];
        
        return cell;
    }
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        
        DZYFollowCategory *selectedCategory = self.categories[self.leftTableView.indexPathForSelectedRow.row];
        // 解决刷新时候显示的数据依旧是上一个选项的数据 增强用户体验 （每次都要刷新）
        [self.rightTableView reloadData];
        if (selectedCategory.users.count) { // 已经有用户数据
            [self.rightTableView reloadData];
        } else { // 从未有过用户数据

            // 加载右边用户数据
            [self.rightTableView.header beginRefreshing];
        }
    } else {
        DZYLog(@"点击了👉 →的%zd行", indexPath.row);
    }
}



@end

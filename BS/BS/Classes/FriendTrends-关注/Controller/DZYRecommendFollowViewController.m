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
#import "DZYCategory.h"
#import <MJExtension.h>

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

static NSString * const DZYCategoryCellId = @"category";
static NSString * const DZYUserCellId = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self loadCategories];
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
    
    self.rightTableView.contentInset = inset;
    self.rightTableView.scrollIndicatorInsets = inset;
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZYUserCell class]) bundle:nil] forCellReuseIdentifier:DZYUserCellId];
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

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
        weakSelf.categories = [DZYCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [weakSelf.leftTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        // 关闭弹框
        [SVProgressHUD dismiss];

    }];

}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.categories.count;
    } else {
        return 40;
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

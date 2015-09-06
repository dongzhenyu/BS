//
//  DZYTagViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTagViewController.h"
#import "DZYRecommendTagCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "DZYRecommendTag.h"
#import <SVProgressHUD.h>

@interface DZYTagViewController ()

// 所有的标签数据（里面放的是标签模型）
@property (nonatomic, strong) NSMutableArray *tags;

// 请求管理者
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@end

@implementation DZYTagViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"推荐标签";
    
    [self setUpTabView];
    
    [self loadTags];
    
}

- (void)setUpTabView
{
    
    self.view.backgroundColor = DZYCommonBgColor;
    
    self.tableView.rowHeight = 70;
    
    // 注册重用标识
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZYRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:@"tag"];
    // 去掉系统自带的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)loadTags
{
    // 弹框
    [SVProgressHUD show];
    
    // 加载标签数据
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    DZYWeakSelf;
    [[self manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 如果URl写错 请求不到数据 那么就会来到这个方法
        if (responseObject == nil) {
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
            return;
        }

        weakSelf.tags = [DZYRecommendTag objectArrayWithKeyValuesArray:responseObject];
        // 刷新表格
        [weakSelf.tableView reloadData];

        
        // 关闭弹框
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 如果是取消了请求任务 就不算是请求失败 直接返回
        if (error.code == NSURLErrorCancelled) return;
        if (error.code == NSURLErrorTimedOut) {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"请求数据超时，请稍后再试"];
        } else {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
        }
        
    }];
}

- (void)dealloc
{
    // 停止请求
    [self.manager invalidateSessionCancelingTasks:YES];
    [SVProgressHUD dismiss];
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZYRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tag"];
    // 设置数据
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}

@end

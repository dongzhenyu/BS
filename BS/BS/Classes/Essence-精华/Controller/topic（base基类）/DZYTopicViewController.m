//
//  DZYTopicViewController.m
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTopicViewController.h"
#import <AFNetworking.h>
#import "DZYTopic.h"
#import <MJExtension.h>
#import "DZYTopicCell.h"
#import <MJRefresh.h>
#import "DZYMyFooter.h"
#import "DZYCommentViewController.h"
#import "DZYNewViewController.h"

@interface DZYTopicViewController ()

/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;

/** 所有帖子的数据 */
@property (nonatomic, strong) NSMutableArray *topics;

/** 用来加载下一组数据 */
@property (nonatomic, copy) NSString *maxtime;

- (NSString *)aParam;
@end

@implementation DZYTopicViewController

/**
 *  实现这个方法 仅仅是为了消除警告（因为子类的type方法最终会覆盖父类的方法）
 */
- (DZYTopicType)type { return 0; }

static NSString * const DZYTopicCellId = @"topic";

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupRefresh];
}

- (void)setupTable
{
    self.tableView.backgroundColor = DZYCommonBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(DZYNavBarMaxY + DZYTitlesViewH, 0, DZYTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 去掉分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZYTopicCell class]) bundle:nil] forCellReuseIdentifier:DZYTopicCellId];
    
    //    self.tableView.rowHeight = 200;
}

- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 上拉刷新
    self.tableView.footer = [DZYMyFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

// 处理数据
- (void)dealData:(id)responseObject
{
    //    int count = 0;
    //    for (NSDictionary *dict in responseObject[@"list"]) {
    //        if ([dict[@"top_cmt"] count]) {
    //            [dict[@"top_cmt"] writeToFile:@"/Users/dongzhenyu/Desktop/top_cmt.plist" atomically:YES];
    //            DZYLog(@"%zd", count);
    //        }
    //        count++;
    //    }
    //    DZYWriteToPlist(responseObject, @"topic");
}

- (NSString *)aParam
{
    // [a isKindOfClass:c] 判断a是否为c类型或者c的子类类型
    if ([self.parentViewController isKindOfClass:[DZYNewViewController class]]) {
        return @"newlist";
    }
    return @"list";
}

/**
 *  加载最新帖子数据
 */
- (void)loadNewTopics
{
    // 取消之前的所有请求任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    DZYWeakSelf;
    [self.manager GET:DZYRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //        [responseObject writeToFile:@"/Users/dongzhenyu/Desktop/topic.plist" atomically:YES];
        [weakSelf dealData:responseObject];
        // 字典数组 -》字典模型
        weakSelf.topics = [DZYTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 存储maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        //        DZYLog(@"%@", self.topics);
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [self.tableView.header endRefreshing];
    }];
}

/**
 *  加载更多的帖子数据
 */
- (void)loadMoreTopics
{
    // 取消之前所有的请求任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    DZYWeakSelf;
    [self.manager GET:DZYRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf dealData:responseObject];
        // 字典数组-》模型数组
        NSArray *moreTopics = [DZYTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.topics addObjectsFromArray:moreTopics];
        
        // 存储maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
        
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DZYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

// 以前学的方法 把所有控件加进去 然后在自动布局子控件的位置  这种方法不可行
// 因为在这里  中间的图片是动态加进去的 不能自动布局 只能手动通过代码来计算
#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DZYTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZYCommentViewController *comment = [[DZYCommentViewController alloc] init];
    comment.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:comment animated:YES];
    
}
@end

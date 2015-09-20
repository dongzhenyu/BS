//
//  DZYCommentViewController.m
//  BS
//
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYCommentViewController.h"
#import "DZYTopic.h"
#import "DZYCommentCell.h"
#import "DZYTopicCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "DZYComment.h"
#import "DZYCommentHeadView.h"

@interface DZYCommentViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonSpace;

/** 暂时存储 最热评论 */
@property (nonatomic, strong) DZYComment *topComment;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;

/** 最新评论 （所有评论数据） */
@property (nonatomic, strong) NSMutableArray *latestComments;

@end

@implementation DZYCommentViewController

#pragma mark - lazy
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
static NSString * const DZYCommtentCellId = @"comment";
static NSString * const DZYHeadId = @"header";
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setupTable];
    
    [self setupRefesh];
}

- (void)setupTable
{
    self.tableView.backgroundColor = DZYCommonBgColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZYCommentCell class]) bundle:nil] forCellReuseIdentifier:DZYCommtentCellId];
    [self.tableView registerClass:[DZYCommentHeadView class] forHeaderFooterViewReuseIdentifier:DZYHeadId];
    
    // 如果返回都是一些固定的数据 那么就可以使用系统的自动计算高度
    // 估算高度
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 处理模型数据 (有数据的时候才需要处理 没有就按原来的)
    if (self.topic.topComment) {
        self.topComment = self.topic.topComment;
        self.topic.topComment = nil;
        self.topic.cellHeight = 0;
    }
    
    // 设置header
    DZYTopicCell *cell = [DZYTopicCell viewFromXib];
    cell.topic = self.topic;
    // 分开写要调用两次 上面会多一个10的间距
    cell.frame = CGRectMake(0, 0, DZYScreenW, self.topic.cellHeight);
    
    UIView *header = [[UIView alloc] init];
    header.height = cell.height + 2 * DZYCommonMargin;
    header.backgroundColor = DZYCommonBgColor;
    [header addSubview:cell];
    
    self.tableView.tableHeaderView = header;
    
}

- (void)setupRefesh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 修复帖子的最热评论数据
    if (self.topComment) {
        self.topic.topComment = self.topComment;
        self.topic.cellHeight = 0;
    }
}

#pragma mark - 加载评论数据
- (void)loadNewComments
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    
    // 发送请求
    DZYWeakSelf;
    [self.manager GET:DZYRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 最热评论
        weakSelf.hotComments = [DZYComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        weakSelf.latestComments = [DZYComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
}

- (void)loadMoreComments
{
    DZYLogFunc;
}

#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 工具条平移的距离 = 屏幕高度 - 键盘最终的Y值
    self.buttonSpace.constant = DZYScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) return 2;
    if (self.latestComments.count) return 1;
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.hotComments.count) {
        return self.hotComments.count;
    }
    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYCommtentCellId];
    // 获得对应的评论数据
    NSArray *comments = self.latestComments;
    if (indexPath.section == 0 && self.hotComments.count) {
        comments = self.hotComments;
    }
    
    // 传递模型给cell
    cell.comment = comments[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0 && self.hotComments.count) {
//        return @"最新评论";
//    }
//    return @"最新评论";
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    // label
//    UILabel *label = [[UILabel alloc] init];
//    if (section == 0 && self.hotComments.count) {
//        label.text = @"最热评论";
//    } else {
//        label.text = @"最新评论";
//    }
//    label.x = DZYCommonSmallMargin;
//    [label sizeToFit];
//    label.textColor = DZYGrayColor(120);
//    label.font = [UIFont systemFontOfSize:14];
//
//    // header
//    UIView *header = [[UIView alloc] init];
//    header.backgroundColor = self.tableView.backgroundColor;
//    [header addSubview:label];
//
//    return header;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    // label
//    UILabel *label = nil;
//
//    // header
//    static NSString *ID = @"header";
//    static NSInteger tag = 99;
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    if (header == nil) { // 缓存池中没有header
//        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
//        header.contentView.backgroundColor = self.tableView.backgroundColor;
//
//        // label
//        label = [[UILabel alloc] init];
//        label.x = DZYCommonSmallMargin;
//        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        label.textColor = DZYGrayColor(120);
//        label.tag = tag;
//        label.font = [UIFont systemFontOfSize:14];
//        [header.contentView addSubview:label];
//    } else { // 这个header是从缓存池中取出来（这个header里面本身就已经有label）
//        label = (UILabel *)[header viewWithTag:tag];
//    }
//
//    // 覆盖文字
//    if (section == 0 && self.hotComments.count) {
//        label.text = @"最热评论";
//    } else {
//        label.text = @"最新评论";
//    }
//
//    return header;
//}


// 如果不想使用系统默认的头部标题文字样式 那么要自定义控件 （在label外面可以再包装一层UIView）
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DZYCommentHeadView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:DZYHeadId];
    // 覆盖文字
    if (section == 0 && self.hotComments.count) {
        header.text = @"最热评论";
    } else {
        header.text = @"最新评论";
    }
    
    return header;
}
@end


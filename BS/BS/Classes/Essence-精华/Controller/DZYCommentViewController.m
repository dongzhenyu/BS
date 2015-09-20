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
#import "DZYUser.h"

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
/** 写方法声明的目的为了使用点语法提示 */
- (DZYComment *)selectedComment;
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
    // cell的分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [self.tableView.footer beginRefreshing];
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
        
//        DZYWriteToPlist(responseObject, @"comment");
        if ([responseObject isKindOfClass:[NSArray class]]) {
            // 意味着没有评论数据
            // 结束刷新
            [weakSelf.tableView.header endRefreshing];
            return ;
        }
        
        // 最热评论
        weakSelf.hotComments = [DZYComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        weakSelf.latestComments = [DZYComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
        
        // 判断数据是否已经加载完全
        if (self.latestComments.count >= [responseObject[@"total"] intValue]) {
            // 已经加载完毕
            weakSelf.tableView.footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
}

- (void)loadMoreComments
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    DZYWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = [self.latestComments.lastObject ID];
    
    [self.manager GET:DZYRequestURL parameters:params success:^(NSURLSessionDataTask * __nonnull task, id responseObject) {
        DZYWriteToPlist(responseObject, @"comment_more");
        // 最新评论
        NSArray *newComments = [DZYComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 判断评论数据是否加载完全
        if (self.latestComments.count >= [responseObject[@"total"] intValue]) {
            // 已经加载完毕
            weakSelf.tableView.footer.hidden = YES;
//            [weakSelf.tableView.footer noticeNoMoreData];
        } else { // 应该还有下一页
            // 结束刷新 （恢复到普通状态 仍旧还可以继续刷新 ）
            [weakSelf.tableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
    }];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 设置菜单内容
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)]
                       ];
    // 显示位置
    CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, 1);
    
    [menu setTargetRect:rect inView:cell];
    
    // 显示出来
    [menu setMenuVisible:YES animated:YES];
    
}

#pragma mark - 获取当前的评论
- (DZYComment *)selectedComment
{
    // 获得被选中的cell的行号
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    NSInteger row = indexPath.row;
    
    // 获得评论数据
    NSArray *comments = self.latestComments;
    if (indexPath.section == 0 && self.hotComments.count) {
        comments = self.hotComments;
    }
    return comments[row];
}

#pragma mark - UIMenuController的处理

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (!self.isFirstResponder) { // 文本框弹出键盘 文本框才是第一响应者
        if (action == @selector(ding:)
            || action == @selector(reply:)
            || action == @selector(warn:)) return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)ding:(UIMenuController *)menu
{
    DZYLog(@"ding---%@ %@", self.selectedComment.user.username, self.selectedComment.content);
    
}
- (void)reply:(UIMenuController *)menu
{
    DZYLog(@"reply---%@ %@", self.selectedComment.user.username, self.selectedComment.content);
    
}
- (void)warn:(UIMenuController *)menu
{
    DZYLog(@"warn---%@ %@", self.selectedComment.user.username, self.selectedComment.content);
    
}@end


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

@interface DZYCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonSpace;

@end

@implementation DZYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setupTable];
}

- (void)setupTable
{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZYCommentCell class]) bundle:nil] forCellReuseIdentifier:@"comment"];
    
    // 设置header
    DZYTopicCell *cell = [DZYTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, DZYScreenW, self.topic.cellHeight);
    
    UIView *header = [[UIView alloc] init];
    header.height = cell.height + 2 * DZYCommonMargin;
    header.backgroundColor = [UIColor redColor];
    [header addSubview:cell];
    
    self.tableView.tableHeaderView = header;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 10;
    
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [tableView dequeueReusableCellWithIdentifier:@"comment"];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return @"最热评论";
    return @"最新评论";
}
@end


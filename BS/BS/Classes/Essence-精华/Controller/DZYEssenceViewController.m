//
//  DZYEssenceViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYEssenceViewController.h"
#import "DZYTagViewController.h"
#import "DZYTitleButton.h"

@interface DZYEssenceViewController ()

/** 存放所有子控制器view */
@property (nonatomic, weak) UIScrollView *scrollView;

/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;

/** 当前被选中的按钮 */
@property (nonatomic, weak) DZYTitleButton *selectedTitleButton;

/** 标题栏底部的指示器 */
@property (nonatomic, weak) UIView *titleBottomView;

/** 存放所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *titleButtons;

@end

@implementation DZYEssenceViewController

- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = CGRectMake(100, 100, 100, 100);
//    [imageView setHeader:@"https://www.baidu.com/img/bd_logo1.png"];
//    [self.view addSubview:imageView];
    
    [self setupNav];
    
    [self setupScrollView];
    
    [self setupTitlesView];

}

- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.frame = CGRectMake(0, DZYNavBarMaxY, self.view.width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标签栏内部的标签按钮
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonH = titlesView.height;
    CGFloat titleButtonW = titlesView.width / count;
    for (int i = 0; i < count; i++) {
        DZYTitleButton *titleButton = [DZYTitleButton buttonWithType:UIButtonTypeCustom];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        // frame
        titleButton.y = 0;
        titleButton.height = titleButtonH;
        titleButton.width = titleButtonW;
        titleButton.x = i * titleButton.width;
        
    }
    // 标签底部的指示器控件
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.backgroundColor = [self.titleButtons.lastObject titleColorForState:UIControlStateSelected];
    titleBottomView.height = 1;
    titleBottomView.y = titlesView.height - titleBottomView.height;
    [titlesView addSubview:titleBottomView];
    self.titleBottomView = titleBottomView;
    
    // 默认点击最前面的按钮
    DZYTitleButton *firstTitleButton = self.titleButtons.firstObject;
    [firstTitleButton.titleLabel sizeToFit];
    titleBottomView.width = firstTitleButton.titleLabel.width;
    titleBottomView.centerX = firstTitleButton.centerX;
    [self titleClick:firstTitleButton];
    
}

#pragma mark - 监听
- (void)titleClick:(DZYTitleButton *)titleButton
{
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = titleButton.titleLabel.width;
        self.titleBottomView.centerX = titleButton.centerX;
    }];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = DZYCommonBgColor;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

}
/**
 *  左上角按钮点击
 */
- (void)tagClick
{
    DZYTagViewController *tag = [[DZYTagViewController alloc] init];
    [self.navigationController pushViewController:tag animated:YES];
}

@end

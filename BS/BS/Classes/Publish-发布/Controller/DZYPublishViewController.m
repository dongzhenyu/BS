//
//  DZYPublishViewController.m
//  BS
//
//  Created by dzy on 15/9/9.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYPublishViewController.h"
#import "DZYPublishButton.h"

@interface DZYPublishViewController ()

/** 标语 */
@property (nonatomic, weak) UIImageView *sloganView;

@end

@implementation DZYPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = DZYScreenH * 0.15;
    sloganView.centerX = DZYScreenW * 0.5;
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    
    // 按钮  数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    // 参数
    NSUInteger count = images.count;
    // 一行的列数
    NSUInteger maxColsCount = 3;
    // 行数
    NSUInteger rowsCount = (count + maxColsCount - 1) / maxColsCount;
    
    // 按钮的尺寸
    CGFloat buttonW = DZYScreenW / maxColsCount;
    CGFloat buttonH = buttonW * 0.85;
    CGFloat buttonStartY = (DZYScreenH - rowsCount * buttonH) * 0.5;
    for (int i = 0; i < count; i++) {
        DZYPublishButton *button = [DZYPublishButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        // frame
        CGFloat buttonX = (i % maxColsCount) * buttonW;
        CGFloat buttonY = buttonStartY + (i / maxColsCount) * buttonH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 设置内容
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
    }
}

- (void)buttonClick:(UIButton *)button
{
    DZYLogFunc;
}

//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    
//    self.sloganView.y = 50;
//    self.sloganView.centerX = self.view.width * 0.5;
//    
//}

// 有一种添加\布局子控件的方法
// 1.在viewDidLoad方法中创建、添加子控件
// 2.在viewDidLayoutSubviews方法中布局子控件
@end

//
//  DZYPostWordViewController.m
//  BS
//
//  Created by dzy on 15/9/10.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYPostWordViewController.h"
#import "DZYPlaceholderTextView.h"

@interface DZYPostWordViewController ()<UITextViewDelegate>
@property (nonatomic, weak) DZYPlaceholderTextView *textView;
@end

@implementation DZYPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    [self setupTextView];
    
}

- (void)setupTextView
{
    // NO 不要自动调整ScrollView的contentInset属性
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.textView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    DZYPlaceholderTextView *textView = [[DZYPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    // 不管内容有多少 竖直方向永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理";
    [self.view addSubview:textView];
    self.textView = textView;
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end

//
//  DZYPostWordViewController.m
//  BS
//
//  Created by dzy on 15/9/10.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYPostWordViewController.h"
#import "DZYPlaceholderTextView.h"

@interface DZYPostWordViewController ()

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
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理";
    [self.view addSubview:textView];
    self.textView = textView;
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end

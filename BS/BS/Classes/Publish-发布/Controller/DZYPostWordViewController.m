//
//  DZYPostWordViewController.m
//  BS
//
//  Created by dzy on 15/9/10.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYPostWordViewController.h"
#import "DZYPlaceholderTextView.h"
#import "DZYPostWordToolbar.h"

@interface DZYPostWordViewController ()<UITextViewDelegate>
@property (nonatomic, weak) DZYPlaceholderTextView *textView;

@property (nonatomic, weak) DZYPostWordToolbar *toolbar;
@end

@implementation DZYPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    // 要放在textView的后面 因为要盖住它
    [self setupToolBar];
}

- (void)setupToolBar
{
    DZYPostWordToolbar *toolbar = [DZYPostWordToolbar viewFromXib];
    toolbar.x = 0;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.width = self.view.width;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    // 用一个通知监听两种行为
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil]; //（匿名发出,是没有对象的 写了对象也不起作用）
    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 有两种方法实现控制器内部通知的注册和移除
 第一种方法 不管当前控制器是否显示在用户眼前 只要控制器对象还在内存中 就会处理各个地方发出的通知
 1 在viewDidLoad方法中注册通知的监听
 2 在dealloc方法中移除通知的监听
 
 第二种方法 只有当控制器显示在用户眼前时 才会处理通知
 1 在viewWillAppear 方法中注册通知的监听
 2 在viewWillDisappear 方法中移除通知的监听
 */

//- (void)viewWillAppear:(BOOL)animated
//{
//    DZYLog(@"11");
//    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    DZYLog(@"22");
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    // 右边按钮一开是不能点击
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // 强制更新 （能立马刷新当前的状态）
    [self.navigationController.navigationBar layoutIfNeeded];
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
    // 一进入界面就弹出键盘
//    [textView becomeFirstResponder];
    
    [self.view addSubview:textView];

    self.textView = textView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
}

// 当界面完全显示的时候调用
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    [self.textView becomeFirstResponder];
//}

#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
//    DZYLog(@"%@", note.userInfo);
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
       // 工具条平移的距离 = 键盘最终的Y值 -  屏幕的高度
        // 想要让键盘往上走 得是负值 反过来减 当是0时 回到底部
        CGFloat ty = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y - DZYScreenH;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, ty);
        
    }];
}

- (void)cancel
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    DZYLogFunc;
}

#pragma mark - 代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

@end

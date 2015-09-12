//
//  DZYAddTagViewController.m
//  BS
//
//  Created by dzy on 15/9/12.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYAddTagViewController.h"

@interface DZYAddTagViewController ()

@end

@implementation DZYAddTagViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupNav];
    
    [self setupTextField];
}

- (void)setupNav
{
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.x = DZYCommonSmallMargin;
    textField.width = self.view.width - 2 * textField.x;
    textField.height = DZYTagH;
    textField.y = DZYNavBarMaxY + DZYCommonSmallMargin;
    
    // 设置占位文字
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.placeholderColor = [UIColor grayColor];
    // 如果想设置文字颜色 必须在设置完占位文字内容以后才能设置
//    [textField setValue:[UIColor redColor] forKeyPath:@"placeholderLabel.textColor"];
    
    [self.view addSubview:textField];
    
    [textField becomeFirstResponder];
    // 强制更新
    [textField layoutIfNeeded];
    
}

#pragma mark - 监听
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done
{
    DZYLogFunc;
}
@end

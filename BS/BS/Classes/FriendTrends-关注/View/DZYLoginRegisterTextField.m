//
//  DZYLoginRegisterTextField.m
//  BS
//
//  Created by dzy on 15/9/5.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYLoginRegisterTextField.h"


@implementation DZYLoginRegisterTextField

// 初始化设置
- (void)awakeFromNib
{
    // 文本框光标颜色
    self.tintColor = [UIColor whiteColor];
    // 文字颜色
    self.textColor = [UIColor whiteColor];
    
    // 利用KVC访问苹果内部属性
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    
//    // 监听文本框的开始和结束编辑
//    [self addTarget:self action:@selector(beginEditing) forControlEvents:UIControlEventEditingDidBegin];
//    [self addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventEditingDidEnd];
    
    // 通过通知-》监听文本框的开始和结束编辑
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing) name:UITextFieldTextDidEndEditingNotification object:self];
}

// 养成习惯
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)beginEditing
{
    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
}

- (void)endEditing
{
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
}
@end

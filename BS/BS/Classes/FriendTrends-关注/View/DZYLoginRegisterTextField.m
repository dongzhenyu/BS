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
    // 设置带有属性的占位文字(富文本)
//    self.placeholder;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
//    DZYLog(@"%@", self.placeholder);
    
//    [self uses];
}

- (void)uses
{
    // 富文本用法1-不可变的属性文字
//    NSMutableDictionary *attrs = [NSMutableDictionary  dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    attrs[NSUnderlineStyleAttributeName] = @1;
//    attrs[NSUnderlineColorAttributeName] = [UIColor redColor];
//    
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
    // 富文本用法2-可变的属性文字 红 绿
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(1, 1)];
//    [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(1, 1)];
//    self.attributedPlaceholder = string;
    
   // 富文本用法3-图文混排 得分别包装3个AttributedString 再调用NSMutableAttributedString 的append方法
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
//    // 第一段 placeholder
//    NSAttributedString *subString1 = [[NSAttributedString alloc] initWithString:self.placeholder];
//    [string appendAttributedString:subString1];
//    
//    // 第二段 图片 attachment附件
//    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
//    attachment.image = [UIImage imageNamed:@"login_close_icon"];
//    attachment.bounds = CGRectMake(0, 0, 16, 16);// x y能调整往上下左右走
//    
//    NSAttributedString *subString2 = [NSAttributedString attributedStringWithAttachment:attachment];
//    [string appendAttributedString:subString2];
//    
//    // 第三段 哈哈
//    NSAttributedString *subString3 = [[NSAttributedString alloc] initWithString:@"哈哈"];
//    [string appendAttributedString:subString3];
//    
//    self.attributedPlaceholder = string;
    
    
    
    
    
}

@end

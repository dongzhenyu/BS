//
//  DZYLoginRegisterTextField.m
//  BS
//
//  Created by dzy on 15/9/5.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYLoginRegisterTextField.h"
// 占位文字颜色

// 默认的占位文字颜色
#define DZYPlaceholderDefaultColor [UIColor grayColor]
// 聚焦的占位文字颜色
#define DZYPlaceholderFocusColor [UIColor whiteColor]


@implementation DZYLoginRegisterTextField

// 初始化设置
- (void)awakeFromNib
{
    // 文本框光标颜色
    self.tintColor = DZYPlaceholderFocusColor;
    // 文字颜色
    self.textColor = DZYPlaceholderFocusColor;
    // 设置占位文字颜色
    self.placeholderColor = DZYPlaceholderDefaultColor;
}

/**
 * 文本框聚焦时候调用
 */
- (BOOL)becomeFirstResponder
{
    self.placeholderColor = DZYPlaceholderFocusColor;
    return [super becomeFirstResponder];
}

/**
 *  文本框是去焦点的时候调用
 */
- (BOOL)resignFirstResponder
{
    self.placeholderColor = DZYPlaceholderDefaultColor;
    return [super resignFirstResponder];
}
@end

//
//  DZYLoginRegisterTextField.m
//  BS
//
//  Created by dzy on 15/9/5.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYLoginRegisterTextField.h"
// 占位文字颜色
//#define DZYPlaceholderColorKey @"placeholderLabel.textColor"
static NSString * const DZYPlaceholderColorKey = @"placeholderLabel.textColor";
//static CGRect const XMGCommonRect = CGRectMake(0, 0, 375, 64);
static CGRect const DZYCommonRect = {{0, 0}, {375, 64}};
// 默认的占位文字颜色
#define DZYPlaceholderDefaultColor [UIColor grayColor]
// 聚焦的占位文字颜色
#define DZYPlaceholderFocusColor [UIColor whiteColor]


@implementation DZYLoginRegisterTextField

// 初始化设置
- (void)awakeFromNib
{
    DZYLog(@"awakeFromNib-%@", NSStringFromCGRect(DZYCommonRect));
    // 文本框光标颜色
    self.tintColor = [UIColor whiteColor];
    // 文字颜色
    self.textColor = [UIColor whiteColor];
    // 设置占位文字颜色
    [self resignFirstResponder];
    
}

/**
 * 文本框聚焦时候调用
 */
- (BOOL)becomeFirstResponder
{
    DZYLog(@"becomeFirstResponder-%@", NSStringFromCGRect(DZYCommonRect));
    [self setValue:DZYPlaceholderFocusColor forKeyPath:DZYPlaceholderColorKey];
    return [super becomeFirstResponder];
}

/**
 *  文本框是去焦点的时候调用
 */
- (BOOL)resignFirstResponder
{
    DZYLog(@"resignFirstResponder-%@", NSStringFromCGRect(DZYCommonRect));
    [self setValue:DZYPlaceholderDefaultColor forKeyPath:DZYPlaceholderColorKey];
    return [super resignFirstResponder];
}
@end

//
//  UITextField+DZYExtension.m
//  BS
//
//  Created by dzy on 15/9/11.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "UITextField+DZYExtension.h"
/** 占位字体颜色 */
static NSString * const DZYPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (DZYExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    BOOL change = NO;
    
    // 保证有占位文字
    if (self.placeholder == nil) {
        self.placeholder = @" ";
        change = YES;
    }
    
    // 设置占位字体颜色
    [self setValue:placeholderColor forKeyPath:DZYPlaceholderColorKey];
    
    // 恢复原状
    if (change) {
        self.placeholderColor = nil;
    }
    
    
}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:DZYPlaceholderColorKey];
}

@end

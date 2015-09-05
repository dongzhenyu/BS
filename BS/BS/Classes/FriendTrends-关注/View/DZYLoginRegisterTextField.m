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
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];

}

// 重写这个方法
- (void)drawPlaceholderInRect:(CGRect)rect
{
//    DZYLog(@"%@", NSStringFromCGRect(self.bounds));
    // 占位文字画在那个矩形框里
    CGRect placeholderRect = self.bounds;
    placeholderRect.origin.y = (self.height - self.font.lineHeight) * 0.5;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
    attrs[NSFontAttributeName] = self.font;
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    
    // 占位文字画在什么位置
//    CGPoint point;
//    point.x = 0;
//    point.y = (self.height - self.font.lineHeight) * 0.5;
//    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    
//    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
//    attrs[NSFontAttributeName] = self.font;
//
//    [self.placeholder drawAtPoint:point withAttributes:attrs];
    
}
@end

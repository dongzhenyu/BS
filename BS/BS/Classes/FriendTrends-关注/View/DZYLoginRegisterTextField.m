//
//  DZYLoginRegisterTextField.m
//  BS
//
//  Created by dzy on 15/9/5.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYLoginRegisterTextField.h"
#import <objc/runtime.h>

@implementation DZYLoginRegisterTextField

// 初始化设置
- (void)awakeFromNib
{
    // 文本框光标颜色
    self.tintColor = [UIColor whiteColor];
    // 文字颜色
    self.textColor = [UIColor whiteColor];
    
    // 利用KVC访问苹果内部属性
//    UILabel *label = [self valueForKeyPath:@"placeholderLabel"];
////    DZYLog(@"%@", label);
//    label.textColor = [UIColor grayColor];
//    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel"];
    // 通过运行时挖掘内部属性
    /*
     1. 什么是运行时？(Runtime)
     运行时是苹果提供的纯C语言的开发库（运行时是一种牛逼的技术，开始时候经常用到的底层技术）。
     
     2. 运行时的作用
     能获得某个类的所有成员变量
     * 能获得某个类的所有属性
     * 能获得某个类的所有方法
     * 交换方法实现
     * 能动态添加一个成员变量
     * 能动态添加一个属性
     * 能动态添加一个方法
     
     */
     
     // 成员的数量
    unsigned int outCount = 0;
    
    // 或得所有的成员变量
    Ivar *ivars = class_copyIvarList([UITextField class], &outCount);
    
    // 遍历所有的成员属性
    for (int i = 0; i<outCount; i++) {
        // 取出i对应的成员变量
        Ivar ivar = ivars[i];
        // 获得成员变量的名字
        DZYLog(@"%s", ivar_getName(ivar));
    }
    // 如果函数名中包含了copy\new\retain\create等字眼，那么这个函数返回的数据就需要手动释放
    free(ivars);
    
}


@end

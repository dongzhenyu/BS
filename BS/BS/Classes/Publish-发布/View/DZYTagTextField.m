//
//  DZYTagTextField.m
//  BS
//
//  Created by dzy on 15/9/12.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTagTextField.h"

@implementation DZYTagTextField

/**
 *  监听键盘内部的删除键点击
 */
- (void)deleteBackward
{
    // 执行需要做的操作
    !self.deleteBackwardOperation ? : self.deleteBackwardOperation();
    [super deleteBackward];
}

@end

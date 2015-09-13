//
//  DZYTagTextField.h
//  BS
//
//  Created by dzy on 15/9/12.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZYTagTextField : UITextField

/** 点击删除键时需要执行的操作 */
@property (nonatomic, copy) void (^deleteBackwardOperation)();

@end

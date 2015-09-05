//
//  DZYQuickLoginButton.m
//  BS
//
//  Created by dzy on 15/9/5.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYQuickLoginButton.h"

@implementation DZYQuickLoginButton

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


/**
 *  自定义按钮布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 调用完super 控件就有了尺寸 在尺寸的基础上进行修改
    
    
//    self.imageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor blueColor];
    
    // 调整图片的位置和尺寸
//    CGRect imageF = self.imageView.frame;
//    imageF.origin.y = 0;
//    imageF.origin.x = self.imageView.frame.size.width * 0.5;
//    self.imageView.frame = imageF;
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字的位置和尺寸
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end

//
//  DZYSquareButton.m
//  BS
//
//  Created by dzy on 15/9/7.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYSquareButton.h"
#import "DZYSquare.h"
#import <UIButton+WebCache.h>

@implementation DZYSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
//        self.backgroundColor = [UIColor redColor];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮边框
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        
    }
    return self;
}

// 设置按钮的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.y = self.height * 0.1;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.width = self.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

- (void)setSquare:(DZYSquare *)square
{
    _square = square;
    
    // 数据
    [self setTitle:square.name forState:UIControlStateNormal];
    // 设置按钮的image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}

@end

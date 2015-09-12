//
//  DZYTagButton.m
//  BS
//
//  Created by dzy on 15/9/12.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTagButton.h"

@implementation DZYTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DZYTagBgColor;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 自动计算
    [self sizeToFit];
    
    // 微调
    self.height = DZYTagH;
    self.width += 3 * DZYCommonSmallMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = DZYCommonSmallMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + DZYCommonSmallMargin;
}

@end

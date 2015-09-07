//
//  DZYMeCell.m
//  BS
//
//  Created by dzy on 15/9/7.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYMeCell.h"

@implementation DZYMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.textColor = [UIColor grayColor];
        
        // 设置背景图片
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整imageView
    self.imageView.y = DZYCommonMargin * 0.5;
    self.imageView.height = self.contentView.height - 2 * self.imageView.y;
    self.imageView.width = self.imageView.height;
    
    // 调整textLabel
//    self.textLabel.x = self.imageView.x + self.imageView.width + DZYCommonMargin;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + DZYCommonMargin;
    
    
}

@end

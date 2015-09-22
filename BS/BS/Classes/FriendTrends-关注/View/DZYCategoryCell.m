//
//  DZYCategoryCell.m
//  BS
//
//  Created by dzy on 15/9/21.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYCategoryCell.h"
#import "DZYFollowCategory.h"

@interface DZYCategoryCell ()

/** 左边选中指示器 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation DZYCategoryCell



- (void)awakeFromNib {
    // 清除文字背景颜色 这样就不会挡住分割线
    self.textLabel.backgroundColor = [UIColor clearColor];
}

// 这个方法可以用来监听cell的选中和取消选中
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor darkGrayColor];
    
    self.selectedIndicator.hidden = !selected;
    
    
}

- (void)setCategory:(DZYFollowCategory *)category
{
    _category = category;
    
    // 设置文字
    self.textLabel.text = category.name;
}
@end

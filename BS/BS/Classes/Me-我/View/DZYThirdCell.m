//
//  DZYThirdCell.m
//  BS
//
//  Created by dzy on 15/9/8.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYThirdCell.h"

@implementation DZYThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"第三种cell";
        self.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:[[UISwitch alloc] init]];
    }
    return self;
}

@end

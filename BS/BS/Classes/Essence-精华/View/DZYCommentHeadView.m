//
//  DZYCommentHeadView.m
//  BS
//
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYCommentHeadView.h"

@interface DZYCommentHeadView ()

/** 内部的label */
@property (nonatomic, weak) UILabel *label;

@end

@implementation DZYCommentHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = DZYCommonBgColor;
        
        // label
        UILabel *label = [[UILabel alloc] init];
        label.x = DZYCommonSmallMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.textColor = DZYGrayColor(120);
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    self.label.text = text;
}
@end

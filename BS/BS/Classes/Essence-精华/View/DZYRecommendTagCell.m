//
//  DZYRecommendTagCell.m
//  BS
//
//  Created by dzy on 15/9/6.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYRecommendTagCell.h"
#import "DZYRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface DZYRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation DZYRecommendTagCell

- (void)awakeFromNib {

}

/**
 *  重写这个方法的目的是 拦截cell的frame设置（系统设置cell的frame才会来到这个方法）
 */
- (void)setFrame:(CGRect)frame
{
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)setRecommendTag:(DZYRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;

    // 设置头像
    [self.imageListView setHeader:recommendTag.image_list];
    
    // 设置名字
    self.themeNameLabel.text = recommendTag.theme_name;
    
    // 订阅数
    if (recommendTag.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
    
}

@end

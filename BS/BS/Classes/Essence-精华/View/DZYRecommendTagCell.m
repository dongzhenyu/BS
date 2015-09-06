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
    // Initialization code
}

/**
 *  重写这个方法的目的是 拦截cell的frame设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    
    [super setFrame:frame];
}
- (void)setRecommendTag:(DZYRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    
    // 订阅数
    if (recommendTag.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
    
    
}

@end

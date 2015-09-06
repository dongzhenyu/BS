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
    // 如果使用过于频繁 会导致拖拽起来感觉比较卡 可以用图形上下文
//    self.imageListView.layer.cornerRadius = self.imageListView.width * 0.5;
//    self.imageListView.layer.masksToBounds = YES;
}

/**
 *  重写这个方法的目的是 拦截cell的frame设置（系统设置cell的frame才会来到这个方法）
 */
- (void)setFrame:(CGRect)frame
{
    
    frame.size.height -= 1;
//    frame.origin.x = 5;
//    frame.size.width -= 2 * frame.origin.x;
    
    [super setFrame:frame];
}
- (void)setRecommendTag:(DZYRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
//    DZYWeakSelf;
//    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
//    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        // 如果下载失败 就不做任何处理 按照默认的做法 或显示占位图片
//        if (image == nil) return;
//        weakSelf.imageListView.image = [image circleImage];
//        
//    }];
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

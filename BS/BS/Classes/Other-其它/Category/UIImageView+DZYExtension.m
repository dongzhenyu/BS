//
//  UIImageView+DZYExtension.m
//  BS
//
//  Created by dzy on 15/9/6.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "UIImageView+DZYExtension.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (DZYExtension)

- (void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}


- (void)setRectHeader:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setCircleHeader:(NSString *)url
{
    DZYWeakSelf;
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 如果图片下载失败，就不做任何处理，按照默认的做法：会显示占位图片
        if (image == nil) return;
        weakSelf.image = [image circleImage];
    }];
}
@end

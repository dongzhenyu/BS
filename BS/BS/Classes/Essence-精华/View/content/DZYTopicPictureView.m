//
//  DZYTopicPictureView.m
//  BS
//
//  Created by dzy on 15/9/17.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTopicPictureView.h"
#import "DZYTopic.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "DZYSeeBigPictureViewController.h"

@interface DZYTopicPictureView ()


@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation DZYTopicPictureView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setTopic:(DZYTopic *)topic
{
    [super setTopic:topic];
    
    // 下载图片
    DZYWeakSelf;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        // 每下载一点图片就会调用
        weakSelf.progressView.hidden = NO;
        
        weakSelf.progressView.progress = 1.0 * receivedSize / expectedSize;
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", weakSelf.progressView.progress * 100];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 下载完毕的时候调用
        weakSelf.progressView.hidden = YES;
    }];
    
    // gif
    self.gifView.hidden = !topic.is_gif;
//    NSString *ext = topic.image1.pathExtension.lowercaseString;
//    self.gifView.hidden = ![ext isEqualToString:@"gif"];
    // seeBig
    self.seeBigPictureButton.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) {
        _imageView.contentMode = UIViewContentModeTop;
        _imageView.clipsToBounds = YES;
    } else {
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.clipsToBounds = NO;
    }
}

@end

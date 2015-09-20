//
//  DZYTopicVideoView.m
//  BS
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTopicVideoView.h"
#import "DZYTopic.h"
#import <UIImageView+WebCache.h>
#import "DZYSeeBigPictureViewController.h"

@interface DZYTopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;



@end

@implementation DZYTopicVideoView

- (void)setTopic:(DZYTopic *)topic
{
    [super setTopic:topic];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    // %02zd ：显示这个数字需要占据2位空间，不足的空间用0替补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end

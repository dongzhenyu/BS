//
//  DZYTopicVioceView.m
//  BS
//
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTopicVioceView.h"
#import "DZYTopic.h"
#import <UIImageView+WebCache.h>
#import "DZYSeeBigPictureViewController.h"

@interface DZYTopicVioceView ()
@property (weak, nonatomic) IBOutlet UIImageView *iamgeView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *vioceTimeLabel;

@end

@implementation DZYTopicVioceView

- (void)awakeFromNib
{
    // 清除自动伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.iamgeView.userInteractionEnabled = YES;
    [self.iamgeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}

- (void)imageClick
{
    if (self.iamgeView.image == nil) return;
    
    DZYSeeBigPictureViewController *seeBig = [[DZYSeeBigPictureViewController alloc] init];
    seeBig.topic = self.topic;
    
    [self.window.rootViewController presentViewController:seeBig animated:YES completion:nil];
        
}

- (void)setTopic:(DZYTopic *)topic
{
    _topic = topic;
    
    [self.iamgeView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSInteger minute = topic.viocetime / 60;
    NSInteger second = topic.viocetime % 60;
    self.vioceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}
@end

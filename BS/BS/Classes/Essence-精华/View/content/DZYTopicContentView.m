//
//  DZYTopicContentView.m
//  BS
//
//  Created by dzy on 15/9/20.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTopicContentView.h"
#import "DZYSeeBigPictureViewController.h"


@interface DZYTopicContentView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation DZYTopicContentView

- (void)awakeFromNib
{
    // 清除自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;

    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}

- (void)imageClick
{
    // 下载完毕 才能点击查看图片
    if (self.imageView.image == nil) return;
    
    DZYSeeBigPictureViewController *seeBig = [[DZYSeeBigPictureViewController alloc] init];
    
    seeBig.topic = self.topic;
    
    [self.window.rootViewController presentViewController:seeBig animated:YES completion:nil];
}


@end

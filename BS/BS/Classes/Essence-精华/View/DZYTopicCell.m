//
//  DZYTopicCell.m
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTopicCell.h"
#import "DZYTopic.h"
#import "DZYTopicPictureView.h"
#import "DZYTopicVideoView.h"
#import "DZYTopicVioceView.h"
#import "DZYComment.h"
#import "DZYUser.h"

@interface DZYTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 图片控件 */
@property (nonatomic, weak) DZYTopicPictureView *pictureView;
/** 视频 */
@property (nonatomic, weak) DZYTopicVideoView *videoView;
/** vioce */
@property (nonatomic, weak) DZYTopicVioceView *vioceView;

/** 最热评论- 整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/** 最热评论- 内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

@end

@implementation DZYTopicCell

#pragma mark - lazy
- (DZYTopicPictureView *)pictureView
{
    if (!_pictureView) {
        DZYTopicPictureView *pictureView = [DZYTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (DZYTopicVideoView *)videoView
{
    if (!_videoView) {
        DZYTopicVideoView *videoView = [DZYTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (DZYTopicVioceView *)vioceView
{
    if (!_vioceView) {
        DZYTopicVioceView *vioceView = [DZYTopicVioceView viewFromXib];
        [self.contentView addSubview:vioceView];
        _vioceView = vioceView;
    }
    return _vioceView;
}

/**
 *  设置cell的背景图片
 */
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(DZYTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    // 设置底部工具条的数字
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    // 根据帖子的类型决定中间的内容
    if (topic.type == DZYTopicTypePicture) { // picture
        
        self.vioceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentFrame;
        self.pictureView.topic = topic;
        
    } else if (topic.type == DZYTopicTypeVioce) { // vioce
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.vioceView.hidden = NO;
        self.vioceView.frame = topic.contentFrame;
        self.vioceView.topic = topic;
        
    } else if (topic.type == DZYTopicTypeVideo) { // video
        
        self.vioceView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentFrame;
        self.videoView.topic = topic;
        
    } else if (topic.type == DZYTopicTypeWord) { // word
        
        self.vioceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    // 最热评论
    DZYComment *cmt = topic.top_cmt.firstObject;
    if (cmt) {
        self.topCmtView.hidden = NO;
        NSString *username = cmt.user.username;
        NSString *content = cmt.content;
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@:%@", username,content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
}

/**
 *  设置工具条按钮的名字
 */
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += DZYCommonMargin;
    frame.size.height -= DZYCommonMargin;
    
//    frame.origin.x += DZYCommonMargin;
//    frame.size.width -= 2 * DZYCommonMargin;
    
    [super setFrame:frame];
}
- (IBAction)moreClick {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DZYLog(@"收藏");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DZYLog(@"举报");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        DZYLog(@"取消");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}

@end

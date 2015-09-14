//
//  DZYTopicCell.m
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTopicCell.h"
#import "DZYTopic.h"

@interface DZYTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation DZYTopicCell

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
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"哈哈" message:@"heihei" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"Other", nil];
//    [alert show];
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"haha" delegate:nil cancelButtonTitle:@"qixiao" destructiveButtonTitle:@"queding" otherButtonTitles:@"other", nil];
//    [sheet showInView:self];
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

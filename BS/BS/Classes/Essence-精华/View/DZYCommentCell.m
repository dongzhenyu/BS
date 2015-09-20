//
//  DZYCommentCell.m
//  BS
//
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYCommentCell.h"
#import "DZYComment.h"
#import "DZYUser.h"

@interface DZYCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;


@end

@implementation DZYCommentCell

- (void)setComment:(DZYComment *)comment
{
    
    _comment = comment;
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
    [self.profileImageView setHeader:comment.user.profile_image];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    if ([comment.user.sex isEqualToString:DZYUserSexMale]) {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    } else {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
//    DZYLog(@"%@", comment.user.sex);
}



@end

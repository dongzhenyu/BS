//
//  DZYUserCell.m
//  BS
//
//  Created by dzy on 15/9/21.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYUserCell.h"
#import "DZYFollowUser.h"

@interface DZYUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end
@implementation DZYUserCell


- (void)setUser:(DZYFollowUser *)user
{
    _user = user;
    
    [self.headImageView setHeader:user.header];
    self.screenNameLabel.text = user.screen_name;
    if (user.fans_count >= 10000) {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    } else {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    }
}

@end

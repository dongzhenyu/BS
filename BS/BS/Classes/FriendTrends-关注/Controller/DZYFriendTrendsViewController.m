//
//  DZYFriendTrendsViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYFriendTrendsViewController.h"

@interface DZYFriendTrendsViewController ()

@end

@implementation DZYFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的关注";
    
    // 左边导航栏内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(riendsRecommendClick)];
}

- (void)riendsRecommendClick
{
    DZYLogFunc;
}



@end

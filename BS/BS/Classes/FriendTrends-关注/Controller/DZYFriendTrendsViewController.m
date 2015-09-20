//
//  DZYFriendTrendsViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYFriendTrendsViewController.h"
#import "DZYLoginRegisterViewController.h"
#import "DZYRecommendFollowViewController.h"


@interface DZYFriendTrendsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation DZYFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = DZYCommonBgColor;
    self.navigationItem.title = @"我的关注";
    
    
    // 左边导航栏内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(riendsRecommendClick)];
    
    
//    self.textLabel.text = @"helloasdfasdfaf\nworlddafa";
}

- (void)riendsRecommendClick
{
    DZYRecommendFollowViewController *recommend = [[DZYRecommendFollowViewController alloc] init];
    
    [self.navigationController pushViewController:recommend animated:YES];

}

- (IBAction)loginRegister:(id)sender {
    
    // 跳转到注册界面 通过modal模式
    DZYLoginRegisterViewController *loginRegister = [[DZYLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegister animated:YES completion:nil];
}


@end

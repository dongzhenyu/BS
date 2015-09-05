//
//  DZYLoginRegisterViewController.m
//  BS
//
//  Created by dzy on 15/9/5.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYLoginRegisterViewController.h"

@interface DZYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation DZYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.loginBtn.layer.cornerRadius = 5;
    // 遵循边框规则
//    self.loginBtn.layer.masksToBounds = YES;
//    self.loginBtn.clipsToBounds = YES;
    // 通过KVC来修改
//    [self.loginBtn setValue:@5 forKeyPath:@"layer.cornerRadius"];
//    [self.loginBtn setValue:@YES forKeyPath:@"layer.masksToBounds"];

}
// ios7以前修改状态栏样式
//[UIApplication sharedApplication].statusBarStyle;
// ios7开始右控制器控制样式
/**
 *  让状态栏为白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

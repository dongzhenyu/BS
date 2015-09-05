//
//  DZYLoginRegisterViewController.m
//  BS
//
//  Created by dzy on 15/9/5.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYLoginRegisterViewController.h"

@interface DZYLoginRegisterViewController ()

@end

@implementation DZYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];


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


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end

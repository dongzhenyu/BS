//
//  DZYSettingViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYSettingViewController.h"
#import "DZYTestViewController.h"

@interface DZYSettingViewController ()

@end

@implementation DZYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DZYLog(@"%@", self.navigationController);
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor redColor];
    

    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DZYTestViewController *test = [[DZYTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

@end

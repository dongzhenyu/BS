//
//  DZYEssenceViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYEssenceViewController.h"

#import "DZYTagViewController.h"

@interface DZYEssenceViewController ()

@end

@implementation DZYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"222");
    /*
    // 颜色
    // 每一种颜色都是有N条颜色通道组成
    // 常见的颜色通道
    // ARGB
    
    // 32bit颜色
    // 由ARGB 四个颜色通道组成 每个颜色通道都是有8bit
    // 颜色表示格式
//    * 绿色 #ff00ff00
//    * 黄色 #ffffff00
//    * 白色 #ffffffff
//    * 黑色 #ff000000
    
//    2) ARGB格式
//    * 绿色 255,0,255,0
//    * 黄色 255,255,255,0
//    * 白色 255,255,255,255
//    * 黑色 255,0,0,0

    
    // 24bit颜色
    // 有RGB 三个颜色通道组成
//    2> 颜色的表示格式
//    1) 16进制格式(HEX格式)
//    * 绿色 #00ff00
//    * 黄色 #ffff00
//    * 白色 #ffffff
//    * 黑色 #000000
//    
//    2) RGB格式
//    * 绿色 0,255,0
//    * 黄色 255,255,0
//    * 白色 255,255,255
//    * 黑色 0,0,0
    */
    

//    self.view.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];
    
//    self.view.backgroundColor = DZYColor(215, 215, 215);
    self.view.backgroundColor = DZYCommonBgColor;
//    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

//- (void)viewWillAppear:(BOOL)animated
//{
////    NSLog(@"333");
//    [super viewWillAppear:animated];
//    
//    self.view.backgroundColor = [UIColor redColor];
//   
//}

/**
 *  左上角按钮点击
 */
- (void)tagClick
{
    DZYTagViewController *tag = [[DZYTagViewController alloc] init];
    // 隐藏底部条
//    tag.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tag animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

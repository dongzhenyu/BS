//
//  DZYMeFooterView.m
//  BS
//
//  Created by dzy on 15/9/7.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYMeFooterView.h"
#import <AFNetworking.h>
#import "DZYSquare.h"
#import <MJExtension.h>
#import <UIButton+WebCache.h>
#import "DZYWebViewController.h"


@interface DZYMeFooterView ()

@property (nonatomic, strong) NSArray *squares;

@end

#import "DZYSquareButton.h"

@implementation DZYMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        DZYWeakSelf;
        [[AFHTTPSessionManager manager] GET:DZYRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@", responseObject);
//        [DZYSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
        [weakSelf createSquares:[DZYSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]]];
            
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            
        }];
        
    }
    return self;
}

/**
 *  创建方块
 */
- (void)createSquares:(NSArray *)squares
{
    self.squares = squares;
    // 每行的列数
    int colsCount = 4;
    
    // 按钮尺寸
    CGFloat buttonW = self.width / colsCount;
    CGFloat buttonH = buttonW;
    
    // 遍历所有的模型
    NSUInteger count = squares.count;
    for (int i = 0; i < count; i++) {
        
        DZYSquareButton *button = [DZYSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // frame
        CGFloat buttonX = (i % colsCount) * buttonW;
        CGFloat buttonY = (i / colsCount) * buttonH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 设置模型数据
        button.square = squares[i];
        
        // 设置footer的高度 取决于创建footerView的那一刻 后来设置 会出现bug 往上拖动 数据显示不出来
//        self.height = CGRectGetMaxY(button.frame);
        
    }
    
    // 设置footer的高度
    NSUInteger rowsCount = (count + colsCount - 1) / colsCount;
    self.height = rowsCount * buttonH;
    
    // 重新设置footerView
    UITableView *tableView = (UITableView *)self.superview;
    tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.frame));
    
    // 公式 总页数 = （总个数 + 每页的个数 - 1）/ 每页的个数
}


- (void)buttonClick:(DZYSquareButton *)button
{
    // 计算被点击按钮在子控件数组中的位置
//    NSUInteger index = [self.subviews indexOfObject:button];
//    DZYSquare *square = self.squares[index];
////    DZYSquare *square = self.squares[button.tag];
//    DZYLog(@"%@", button.square.url);
    if ([button.square.url hasPrefix:@"http"]) {
        
        DZYWebViewController *webVc = [[DZYWebViewController alloc] init];
        
//        // 取出当前选中的导航控制器
        UITabBarController *rootVc = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = (UINavigationController *)rootVc.selectedViewController;

        [nav pushViewController:webVc animated:YES];

//        [UIApplication sharedApplication].keyWindow;
//        [[rootVc.childViewControllers lastObject] pushViewController:webVc animated:YES];
//        DZYLog(@"%@", rootVc.selectedViewController);
        
        
    }
    
    
}

/**
 *  控件不能响应时间  原因有
 1 self.userInteractionEnabled = NO;
 2 enabled = NO;
 3 父控件的userInteractionEnabled = NO;
 4 父控件的enabled = NO；
 5 控件已经超出父控件的边框范围
 */
@end

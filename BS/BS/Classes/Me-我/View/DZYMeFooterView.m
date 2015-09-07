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
//#import <UIImageView+WebCache.h>
#import "DZYSquareButton.h"

@implementation DZYMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
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
    // 每行的列数
    int colsCount = 4;
    
    // 按钮尺寸
    CGFloat buttonW = self.width / colsCount;
    CGFloat buttonH = buttonW;
    
    // 遍历所有的模型
    NSUInteger count = squares.count;
    for (int i = 0; i < count; i++) {
        DZYSquare *square = squares[i];
        
        DZYSquareButton *button = [DZYSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // frame
        CGFloat buttonX = (i % colsCount) * buttonW;
        CGFloat buttonY = (i / colsCount) * buttonH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 数据 button
        [button setTitle:square.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
        
        // 利用UIImageView下载数据
//        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:square.icon] options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//            [button setImage:image forState:UIControlStateNormal];
//        }];
        
    }
}

- (void)buttonClick
{
    DZYLogFunc;
}
@end

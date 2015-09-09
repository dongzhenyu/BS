//
//  DZYPublishViewController.m
//  BS
//
//  Created by dzy on 15/9/9.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYPublishViewController.h"
#import "DZYPublishButton.h"
#import <POP.h>


@interface DZYPublishViewController ()

/** 标语 */
@property (nonatomic, weak) UIImageView *sloganView;

/** 动画时间 */
@property (nonatomic, strong) NSArray *times;

@end

@implementation DZYPublishViewController

- (NSArray *)times
{
    if (!_times) {
        CGFloat interval = 0.1; // 时间间隔
        _times = @[@(5 * interval),
                   @(4 * interval),
                   @(3 * interval),
                   @(2 * interval),
                   @(0 * interval),
                   @(1 * interval),
                   @(6 * interval)];
        
    }
    return _times;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupSloganView];
    
    [self setupButtons];
    
}

- (void)setupButtons
{
    // 按钮  数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    // 参数
    NSUInteger count = images.count;
    // 一行的列数
    NSUInteger maxColsCount = 3;
    // 行数
    NSUInteger rowsCount = (count + maxColsCount - 1) / maxColsCount;
    
    // 按钮的尺寸
    CGFloat buttonW = DZYScreenW / maxColsCount;
    CGFloat buttonH = buttonW * 0.85;
    CGFloat buttonStartY = (DZYScreenH - rowsCount * buttonH) * 0.5;
    for (int i = 0; i < count; i++) {
        DZYPublishButton *button = [DZYPublishButton buttonWithType:UIButtonTypeCustom];
        button.width = - 1; // 按钮的尺寸为0 还是能看见文字所称一个点 设置按钮的尺寸为负数 那么就看不见文字了
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        // 设置内容
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        // frame
        CGFloat buttonX = (i % maxColsCount) * buttonW;
        CGFloat buttonY = buttonStartY + (i / maxColsCount) * buttonH;
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - DZYScreenH, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        // CACurrentMediaTime() 获得的是当前的时间
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button pop_addAnimation:anim forKey:nil];
        
    }

}

- (void)setupSloganView
{
    CGFloat sloganY = DZYScreenH * 0.2;
    
    // 设置标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = sloganY - DZYScreenH;
    sloganView.centerX = DZYScreenW * 0.5;
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    
    // 动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(sloganY);
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [sloganView.layer pop_addAnimation:anim forKey:nil];
    

}
- (void)buttonClick:(UIButton *)button
{
    DZYLogFunc;
}

//        UISwitch *s = [[UISwitch alloc] init];
//        s.on = YES;
//        [self.view addSubview:s];
//
//        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
//        anim.fromValue = [NSValue valueWithCGPoint:CGPointZero];
//        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//        anim.duration = 1.0;
//        [s pop_addAnimation:anim forKey:nil];
//
//        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
//        anim.fromValue = [NSValue valueWithCGPoint:CGPointZero];
//        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//        anim.springSpeed = 10;
//        anim.springBounciness = 10;
//        [s.layer pop_addAnimation:anim forKey:nil];
@end

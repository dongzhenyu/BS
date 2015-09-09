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

static CGFloat const DZYSpringFactor = 10;
@interface DZYPublishViewController ()

/** 标语 */
@property (nonatomic, weak) UIImageView *sloganView;

/** 按钮 */
@property (nonatomic, strong) NSMutableArray *buttons;

/** 动画时间 */
@property (nonatomic, strong) NSArray *times;

@end

@implementation DZYPublishViewController

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

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
                   @(6 * interval)];// 标语的动画时间
        
    }
    return _times;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 禁止交互
    self.view.userInteractionEnabled = NO;
    
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
        [self.buttons addObject:button];
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
        anim.springSpeed = DZYSpringFactor;
        anim.springBounciness = DZYSpringFactor;
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
    DZYWeakSelf;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(sloganY);
    anim.springSpeed = DZYSpringFactor;
    anim.springBounciness = DZYSpringFactor;
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 开始交互
        weakSelf.view.userInteractionEnabled = YES;
    }];
    [sloganView.layer pop_addAnimation:anim forKey:nil];
    

}
- (void)buttonClick:(DZYPublishButton *)button
{
    DZYLogFunc;
}
- (IBAction)cancel {
    
    // 禁止交互
    self.view.userInteractionEnabled = NO;
    
    // 让按钮执行动画
    for (int i = 0; i < self.buttons.count; i++) {
        DZYPublishButton *button = self.buttons[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.toValue = @(button.layer.position.y + DZYScreenH);
        // CACurrentMediaTime()获得的是当前时间
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button.layer pop_addAnimation:anim forKey:nil];
    }
    
    DZYWeakSelf;
    // 让标题执行动画
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.sloganView.layer.position.y + DZYScreenH);
    // CACurrentMediaTime()获得的是当前时间
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }];
    [self.sloganView.layer pop_addAnimation:anim forKey:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancel];
}


@end

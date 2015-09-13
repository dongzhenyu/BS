//
//  DZYPostWordToolbar.m
//  BS
//
//  Created by dzy on 15/9/11.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYPostWordToolbar.h"
#import "DZYNavigationController.h"
#import "DZYAddTagViewController.h"

@interface DZYPostWordToolbar ()

@property (weak, nonatomic) IBOutlet UIView *topView;

/** 所有标签的lable */
@property (nonatomic, strong) NSMutableArray *tagLabels;

/** 加号按钮 */
@property (nonatomic, weak) UIButton *addButton;

@end

@implementation DZYPostWordToolbar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

// 只需要加载一次
- (void)awakeFromNib
{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
    self.addButton = addButton;
}

- (void)addClick
{
    DZYWeakSelf;
    // 把这个控制器包装成导航控制器
    DZYAddTagViewController *add = [[DZYAddTagViewController alloc] init];
    add.getTagsBlock = ^(NSArray *tags) {
//        DZYLog(@"%@", tags);
        [weakSelf creatTagLabels:tags];
    };
    add.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    DZYNavigationController *nav = [[DZYNavigationController alloc] initWithRootViewController:add];
    // 拿到窗口根控制器曾经modal出来的发表文字所在的导航控制器
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    [vc presentViewController:nav animated:YES completion:nil];
}

/**
 *  创建标签label
 */
- (void)creatTagLabels:(NSArray *)tags
{
//    DZYLog(@"%@", tags);
    // 让self.tagLabels数组中的所有对象执行
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < tags.count; i++) {
        // 创建label
        UILabel *newTagLabel = [[UILabel alloc] init];
        newTagLabel.text = tags[i];
        newTagLabel.font = [UIFont systemFontOfSize:14];
        newTagLabel.backgroundColor = DZYTagBgColor;
        newTagLabel.textColor = [UIColor whiteColor];
        newTagLabel.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:newTagLabel];
        [self.tagLabels addObject:newTagLabel];
//        DZYLog(@"%@", self.tagLabels);
        
        // 尺寸
        [newTagLabel sizeToFit];
        newTagLabel.height = DZYTagH;
        newTagLabel.width += 2 * DZYCommonSmallMargin;

        
        // 位置
        if (i == 0) {
            newTagLabel.x = 0;
            newTagLabel.y = 0;
        } else {
            // 上一个标签
            UILabel *previousTagLabel = self.tagLabels[i - 1];
            CGFloat leftWidth = CGRectGetMaxX(previousTagLabel.frame) + DZYCommonSmallMargin;
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= newTagLabel.width) {
                newTagLabel.x = leftWidth;
                newTagLabel.y = previousTagLabel.y;
            } else {
                newTagLabel.x = 0;
                newTagLabel.y = CGRectGetMaxY(previousTagLabel.frame) + DZYCommonSmallMargin;
            }
        }
    }
    
    // 加号按钮
    UILabel *lastTagLabel = self.tagLabels.lastObject;
//    DZYLog(@"%@",lastTagLabel);
    if (lastTagLabel) {
        CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + DZYCommonSmallMargin;
        CGFloat rightWidth = self.topView.width - leftWidth;
        if (rightWidth >= self.addButton.width) {
            self.addButton.x = leftWidth;
            self.addButton.y = lastTagLabel.y;
        } else {
            self.addButton.x = 0;
            self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + DZYCommonSmallMargin;
        }
    } else {
        self.addButton.x = 0;
        self.addButton.y = 0;
    }
}
@end

//
//  DZYAddTagViewController.m
//  BS
//
//  Created by dzy on 15/9/12.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYAddTagViewController.h"
#import "DZYTagButton.h"

@interface DZYAddTagViewController () <UITextFieldDelegate>
/**
 *  用来容纳所有的按钮和文本框
 */
@property (nonatomic, weak) UIView *contentView;
/**
 *  文本框
 */
@property (nonatomic, weak) UITextField *textField;
/** 提醒按钮 */
@property (nonatomic, weak) UIButton *tigButton;

/** 存放所有标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation DZYAddTagViewController

#pragma mark - 懒加载
- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIButton *)tigButton
{
    if (!_tigButton) {
        // 创建一个提醒按钮
        UIButton *tigButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tigButton addTarget:self action:@selector(tigClick) forControlEvents:UIControlEventTouchUpInside];
        tigButton.width = self.contentView.width;
        tigButton.height = DZYTagH;
        tigButton.x = 0;
        tigButton.backgroundColor = DZYCommonBgColor;
        tigButton.titleLabel.font = [UIFont systemFontOfSize:14];
        // 文字靠左显示
        tigButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 让文字左边有个间距
        tigButton.contentEdgeInsets = UIEdgeInsetsMake(0, DZYCommonSmallMargin, 0, 0);
        [self.contentView addSubview:tigButton];
        _tigButton = tigButton;
    }
    return _tigButton;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextField];
}

- (void)setupNav
{
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = DZYCommonSmallMargin;
    contentView.y = DZYNavBarMaxY + DZYCommonSmallMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.height = self.view.height;
//    contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc] init];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
//    textField.x = DZYCommonSmallMargin;
    textField.width = self.contentView.width;
    textField.height = DZYTagH;
//    textField.y = DZYNavBarMaxY + DZYCommonSmallMargin;
//    textField.backgroundColor = [UIColor yellowColor];
    
    // 设置占位文字
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.placeholderColor = [UIColor grayColor];
    // 如果想设置文字颜色 必须在设置完占位文字内容以后才能设置
//    [textField setValue:[UIColor redColor] forKeyPath:@"placeholderLabel.textColor"];
    
    textField.delegate = self;
    
    [self.contentView addSubview:textField];
    
    [textField becomeFirstResponder];
    // 强制更新
    [textField layoutIfNeeded];
    
    self.textField = textField;
    
}

#pragma mark - 监听
/**
 *  监听textField文字的改变
 */
- (void)textDidChange
{
    // 提醒按钮
    if (self.textField.hasText) {
        NSString *text = self.textField.text;
        NSString *lastChar = [text substringFromIndex:text.length - 1];
        if ([lastChar isEqualToString:@","] || [lastChar isEqualToString:@"，"]) { // 最后一个输入的字符是逗号
            // 去掉文本框最后一个逗号
            self.textField.text = [text substringToIndex:text.length - 1];
            // 点击提醒按钮
            [self tigClick];
        } else { // 最后输入的字符不是逗号
            CGFloat textW = [text sizeWithAttributes:@{NSFontAttributeName: self.textField.font}].width;
            // 排布文本框
            DZYTagButton *lastTagButton = self.tagButtons.lastObject;
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + DZYCommonSmallMargin;
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= textW) { // 跟新添加的标签按钮在同一行
                self.textField.x = leftWidth;
                self.textField.y = lastTagButton.y;
            } else { // 换行
                self.textField.x = 0;
                self.textField.y = CGRectGetMaxY(lastTagButton.frame) + DZYCommonSmallMargin;
            }
            self.tigButton.hidden = NO;
            self.tigButton.y = CGRectGetMaxY(self.textField.frame) + DZYCommonSmallMargin;
            [self.tigButton setTitle:[NSString stringWithFormat:@"添加标签:%@", self.textField.text] forState:UIControlStateNormal];
        }
        
    } else {
        self.tigButton.hidden = YES;
    }
}

- (void)tigClick
{
    if (self.textField.hasText == NO) return;

    // 创建一个标签按钮
    DZYTagButton *newTagButton = [DZYTagButton buttonWithType:UIButtonTypeCustom];
    [newTagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [self.contentView addSubview:newTagButton];
    
    // 设置位置
    // 最后一个标签按钮
    UIButton *lastTagButton = self.tagButtons.lastObject;
    if (lastTagButton) { // 不是第一个标签
        // 左边的宽度
        CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + DZYCommonSmallMargin;
        // 右边剩下的宽度
        CGFloat rightWidth = self.contentView.width - leftWidth;
        if (rightWidth >= newTagButton.width) { // 跟最后一个按钮在同一行
            newTagButton.x = leftWidth;
            newTagButton.y = lastTagButton.y;
        } else { // 下一行
            newTagButton.x = 0;
            newTagButton.y = CGRectGetMaxY(lastTagButton.frame) + DZYCommonSmallMargin;
        }
    } else { // 第一个标签
        newTagButton.x = 0;
        newTagButton.y = 0;
    }
    
    // 添加到数组中
    [self.tagButtons addObject:newTagButton];
    
    // 排布文本框
    CGFloat leftWidth = CGRectGetMaxX(newTagButton.frame) + DZYCommonSmallMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    if (rightWidth >= 100) { // 跟新添加的按钮处在同一行
        self.textField.x = leftWidth;
        self.textField.y = newTagButton.y;
    } else { // 换行
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(newTagButton.frame) + DZYCommonSmallMargin;
    }

    self.textField.text = nil;
    
    // 隐藏提醒按钮
    self.tigButton.hidden = YES;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done
{
    DZYLogFunc;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self tigClick];
    return YES;
}
@end

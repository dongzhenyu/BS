//
//  DZYAddTagViewController.m
//  BS
//
//  Created by dzy on 15/9/12.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYAddTagViewController.h"
#import "DZYTagButton.h"
#import "DZYTagTextField.h"
#import <SVProgressHUD.h>

@interface DZYAddTagViewController () <UITextFieldDelegate>
/** 用来容纳所有的按钮和文本框 */
@property (nonatomic, weak) UIView *contentView;
/** 文本框 */
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
    
    [self setupTags];
}

- (void)setupTags
{
//    self.textField.text = @"哈哈";
//    [self tigClick];
//    
//    self.textField.text = @"嘿嘿";
//    [self tigClick];
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self tigClick];
    }
    
    
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
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupTextField
{
    DZYWeakSelf;
    DZYTagTextField *textField = [[DZYTagTextField alloc] init];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    textField.width = self.contentView.width;
    textField.height = DZYTagH;
    
    // 设置占位文字
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.placeholderColor = [UIColor grayColor];
    textField.delegate = self;
    
    [self.contentView addSubview:textField];
    
    [textField becomeFirstResponder];
    // 强制更新
    [textField layoutIfNeeded];
    
    self.textField = textField;
    
    // 设置点击删除键需要执行的操作
    textField.deleteBackwardOperation = ^{
        // 判断文本框是否有文字
        if (weakSelf.textField.hasText || weakSelf.tagButtons.count == 0) return;
        
        // 点击了最后一个按钮（删掉最后一个标签按钮）
        [weakSelf tagClick:weakSelf.tagButtons.lastObject];
    };
    
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
            [self.textField deleteBackward];
            // 点击提醒按钮
            [self tigClick];
        } else { // 最后输入的字符不是逗号
           
            // 排布文本框
            [self setupTextFieldFrame];
            
            self.tigButton.hidden = NO;

            [self.tigButton setTitle:[NSString stringWithFormat:@"添加标签:%@", self.textField.text] forState:UIControlStateNormal];
        }
        
    } else {
        self.tigButton.hidden = YES;
    }
}

- (void)tigClick
{
    if (self.textField.hasText == NO) return;
    
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"亲，最多只能添加5个按钮噢~~" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }

    // 创建一个标签按钮
    DZYTagButton *newTagButton = [DZYTagButton buttonWithType:UIButtonTypeCustom];
    [newTagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [newTagButton addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:newTagButton];
    
    // 设置位置 参照最后一个标签按钮
    [self setupTagButtonFrame:newTagButton referenceTagButton:self.tagButtons.lastObject];
    
    // 添加到数组中
    [self.tagButtons addObject:newTagButton];
    
    // 排布文本框
    self.textField.text = nil;
    [self setupTextFieldFrame];
    
    // 隐藏提醒按钮
    self.tigButton.hidden = YES;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done
{
    // 传递标签数据回到上一个界面
    // 将self.tagButtons中存放的所有对象的currentTitle取出来 放到一个新数组中 并返回
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.getTagsBlock ? :self.getTagsBlock(tags);
    
    // 关闭当前控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**r
 *  点击了标签按钮
 */
- (void)tagClick:(DZYTagButton *)clickedTagButton
{
    // 即将被删除的标签按钮的索引
    NSUInteger index = [self.tagButtons indexOfObject:clickedTagButton];
    
    // 删除按钮
    [clickedTagButton removeFromSuperview];
    [self.tagButtons removeObject:clickedTagButton];
    
    // 处理后面的按钮
    for (NSUInteger i = index; i < self.tagButtons.count; i++) {
        DZYTagButton *tagButton = self.tagButtons[i];
        // 如果i不为0 就参照上一个标签按钮
        DZYTagButton *previousTagButton = (i ==0) ? nil : self.tagButtons[i - 1];
        [self setupTagButtonFrame:tagButton referenceTagButton:previousTagButton];
    }
    
    // 排布文本框
    [self setupTextFieldFrame];
}

#pragma mark - 设置控件的frame
/**
 *  设置标签按钮的frame
 *
 *  @param tagButton          需要设置frame的标签按钮
 *  @param referenceTagButton 计算tagButton的frame时参照的标签按钮
 */
- (void)setupTagButtonFrame:(DZYTagButton *)tagButton referenceTagButton:(DZYTagButton *)referenceTagButton
{
    // 没有参照的按钮
    if (referenceTagButton == nil) {
        tagButton.x = 0;
        tagButton.y = 0;
        return;
    }
    
    // tagButton不是第一个标签按钮
    CGFloat leftWidth = CGRectGetMaxX(referenceTagButton.frame) + DZYCommonSmallMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    
    if (rightWidth >= tagButton.width) { // 跟上一个标签按钮处在同一行
        tagButton.x = leftWidth;
        tagButton.y = referenceTagButton.y;
    } else { // 下一行
        tagButton.x = 0;
        tagButton.y = CGRectGetMaxY(referenceTagButton.frame) + DZYCommonSmallMargin;
    }
}

- (void)setupTextFieldFrame
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName: self.textField.font}].width;
    textW = MAX(100, textW);
    
    DZYTagButton *lastTagButton = self.tagButtons.lastObject;
    if (lastTagButton == nil) {
        self.textField.x = 0;
        self.textField.y = 0;
    } else {
        CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + DZYCommonSmallMargin;
        CGFloat rightWidth = self.contentView.width - leftWidth;
        if (rightWidth >= textW) { // 跟新添加的标签按钮在同一行
            self.textField.x = leftWidth;
            self.textField.y = lastTagButton.y;
        } else { // 换行
            self.textField.x = 0;
            self.textField.y = CGRectGetMaxY(lastTagButton.frame) + DZYCommonSmallMargin;
        }
    }
    
    // 排布提醒按钮
    self.tigButton.y = CGRectGetMaxY(self.textField.frame) + DZYCommonSmallMargin;
}



#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self tigClick];
    return YES;
}
@end

//
//  DZYSeeBigPictureViewController.m
//  BS
//
//  Created by dzy on 15/9/18.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYSeeBigPictureViewController.h"
#import "DZYTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface DZYSeeBigPictureViewController () <UIScrollViewDelegate>

/** picture */
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation DZYSeeBigPictureViewController

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 滚动控件
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1]];
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片的尺寸
    imageView.x = 0;
    imageView.width = DZYScreenW;
    imageView.height = self.topic.height * imageView.width / self.topic.width;
    if (imageView.height > DZYScreenH) { // 图片过长
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    } else { // 图片居中显示
        imageView.centerY = DZYScreenH * 0.5;
    }
    
    // 伸缩 <设置伸缩 要遵循scrollView的代理>
    CGFloat maxScale = self.topic.height / imageView.height;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
    }
    
}

- (IBAction)save {
    
    // 通过拍照获得一张图片 (真机) 还要设置代理
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [self presentViewController:picker animated:YES completion:nil];
    
    // 从相册中取出一张图片
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    [self presentViewController:picker animated:YES completion:nil];
//    
    
    // SavedPhotosAlbum 系统自带的 交卷相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

//-[NSInvocation setArgument:atIndex:]: index (2) out of bounds [-1, 1]
//错误描述：调用方法时，参数越界
//错误原因：调用方法时，实参 和 形参 个数不一致

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // 图片是可以伸缩的
    return self.imageView;
}



@end

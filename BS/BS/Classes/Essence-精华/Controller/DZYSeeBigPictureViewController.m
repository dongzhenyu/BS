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
#import <AssetsLibrary/AssetsLibrary.h>

@interface DZYSeeBigPictureViewController () <UIScrollViewDelegate>

/** picture */
@property (nonatomic, weak) UIImageView *imageView;

/** 相册库 */
@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation DZYSeeBigPictureViewController

- (ALAssetsLibrary *)library
{
    if (!_library) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}


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

static NSString * const DZYGroupNameKey = @"DZYGroupNameKey";
static NSString * const DZYDefaultGroupName = @"03期-百思不得姐";

- (NSString *)groupName
{
    // 先从沙盒中取得名字
    NSString *groupName = [[NSUserDefaults standardUserDefaults] stringForKey:DZYGroupNameKey];
    if (groupName == nil) { // 沙盒中没有存储任何文件夹的名字
        groupName = DZYDefaultGroupName;
        
        // 存储名字到沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:DZYDefaultGroupName];
        // 同步存储
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return groupName;
}

- (IBAction)save {
    
    // 获得文件夹的名字
    __block NSString *groupName = [self groupName];
    
    // self的弱引用
    DZYWeakSelf;
    
    // 图片库
    __weak ALAssetsLibrary *weakLibrary = self.library;
    
    // 创建文件夹
    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
        if (group) { // 新建的文件夹
            // 添加图片到文件夹中
            [weakSelf addImageToGroup:group];
        } else { // 文件夹已经存在
            [weakLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
                if ([name isEqualToString:groupName]) {
                    // 添加图片到文件夹中
                    [weakSelf addImageToGroup:group];
                    *stop = YES; // 停止遍历
                } else if ([name isEqualToString:@"Camera Roll"]){
                    // 问价夹被用户强制删除了
                    groupName = [groupName stringByAppendingString:@" "];
                    // 存储新的名字
                    [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:DZYGroupNameKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    // 创建新的文件夹
                    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
                        // 添加图片到文件夹中
                        [weakSelf addImageToGroup:group];
                    } failureBlock:nil];
                }
                
            } failureBlock:nil];
        }
    } failureBlock:nil];

}

/**
 *  添加一张图片到某个文件夹中
 */
- (void)addImageToGroup:(ALAssetsGroup *)group
{
    __weak ALAssetsLibrary *weakLibrary = self.library;
    // 需要保存的图片
    CGImageRef image = self.imageView.image.CGImage;
    
    // 添加图片到【相机胶卷】
    [weakLibrary writeImageToSavedPhotosAlbum:image metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        [weakLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            // 添加一张图片到自定义的文件夹中
            [group addAsset:asset];
            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
        } failureBlock:nil];
    }];

}


- (void)getAllPhotos
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    // 遍历所有文件夹 一个assetGroup对象就代表一个文件夹
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        //        DZYLog(@"%@, %zd", [group valueForProperty:ALAssetsGroupPropertyName], group.numberOfAssets);
        
        // 遍历文件夹内的所有多媒体文件（图片 视频）
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            // 缩略图
            DZYLog(@"%@", [UIImage imageWithCGImage:result.thumbnail]);
            // 获得原始图片
            //            DZYLog(@"%@", [UIImage imageWithCGImage:result.defaultRepresentation.fullResolutionImage]);
            
        }];
    } failureBlock:nil];
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

//
//  DZYSettingViewController.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYSettingViewController.h"
#import <SDImageCache.h>



@interface DZYSettingViewController ()

@end

@implementation DZYSettingViewController

static NSString * const DZYSettingCellId = @"setting";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    self.view.backgroundColor = DZYCommonBgColor;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DZYSettingCellId];
    
    // setting contentInset
    self.tableView.contentInset = UIEdgeInsetsMake(DZYCommonMargin - 35, 0, 0, 0);
    
    // 手机上的磁盘缓存 = 从网络上下载的数据 + 写入的数据
    // 手机上磁盘缓存类型 = 图片 + 多媒体文件
    // 利用框架 获取缓存文件的大小 只能获取一个文件夹下面的大小
//    DZYLog(@"%f", [SDImageCache sharedImageCache].getSize / 1000.0 / 1000.0);
    
    // 打开沙盒
//    DZYLog(@"%@", NSTemporaryDirectory());
//    [self getSize1];
    
    DZYLog(@"%f", @"/Users/dongzhenyu/Desktop/未命名文件夹/02-头尾式动画.mp4".fileSize / 1000.0 / 1000.0);

}

- (void)getSize1
{
    // totalSize
    NSInteger size = 0;
    
    // 文件路径
//    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *file = [caches stringByAppendingPathComponent:@"default"];
    
    // 要放在子线程去计算文件的大小 文件太大会阻塞主线程
    NSString *file = @"/Users/dongzhenyu/Desktop/";
    
    // 创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取文件的大小
//    NSDictionary *attrs = [mgr attributesOfItemAtPath:file error:nil];
//    
//    DZYLog(@"%@", attrs);
    
    // 获取文件夹中所有的内容
    NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:file];
    // 文件夹的大小 需要遍历它下面所有文件计算大小
    for (NSString *subPath in enumerator) {
        
        // 获得全路径
        NSString *fullPath = [file stringByAppendingPathComponent:subPath];
        
        // 获得文件属性
        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullPath error:nil];
        
        size += attrs.fileSize;
    }
    
    NSLog(@"%@ %f", file, size / 1000.0 / 1000.0);
    
}

- (void)getSize2
{
    // 总文件大小
    NSUInteger size = 0;
    
    // 文件路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *file = [caches stringByAppendingPathComponent:@"default"];
    
    // 创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取所有文件夹内容 只能获取当前文件夹下所有的内容
//    NSArray *contents = [mgr contentsOfDirectoryAtPath:file error:nil];
    
    // 获取所有文件夹内容
    NSArray *subPaths = [mgr subpathsAtPath:file];
//    DZYLog(@"%@", subPaths);
    for (NSString *subpath in subPaths) {
        // 获取全路径
        NSString *fullpath = [file stringByAppendingPathComponent:subpath];
        
        // 获得文件属性
        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullpath error:nil];
        size += attrs.fileSize;
    }
    
    DZYLog(@"%@ %f ", file, size / 1000.0);
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DZYSettingCellId];
    
    cell.textLabel.text = @"清除缓存";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


@end

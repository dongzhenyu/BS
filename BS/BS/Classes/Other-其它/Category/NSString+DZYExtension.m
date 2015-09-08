//
//  NSString+DZYExtension.m
//  BS
//
//  Created by dzy on 15/9/8.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "NSString+DZYExtension.h"

@implementation NSString (DZYExtension)

- (NSInteger)fileSize
{
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 是否为文件夹
    BOOL isDirectory = NO;
    // 这个路径是否存在
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    // 路径不存在
    if (exists == NO) return 0;
    
    if (isDirectory) { // 文件夹
        // 总大小
        NSInteger size = 0;
        // 获得文件夹中的所有内容
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 获得文件属性
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        return size;
    } else { // 文件
        return [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
}
@end

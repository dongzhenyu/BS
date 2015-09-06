//
//  UIImage+DZYExtension.m
//  BS
//
//  Created by dzy on 15/9/6.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "UIImage+DZYExtension.h"

@implementation UIImage (DZYExtension)

- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪(剪裁成刚才添加的图形的形状)
    CGContextClip(ctx);
    // 往圆上画一张图片
    [self drawInRect:rect];
    // 获得上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

@end

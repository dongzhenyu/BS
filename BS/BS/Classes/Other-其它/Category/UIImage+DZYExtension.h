//
//  UIImage+DZYExtension.h
//  BS
//
//  Created by dzy on 15/9/6.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DZYExtension)
/**
 *  返回一张圆形的图片
 */
- (instancetype)circleImage;

/**
 *  返回一张圆形的图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;
@end

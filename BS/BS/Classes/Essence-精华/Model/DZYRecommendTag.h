//
//  DZYRecommendTag.h
//  BS
//
//  Created by dzy on 15/9/6.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZYRecommendTag : NSObject
// 图片
@property (nonatomic, copy) NSString *image_list;
// 名字
@property (nonatomic, copy) NSString *theme_name;
// 订阅数
@property (nonatomic, assign) NSInteger sub_number;

@end

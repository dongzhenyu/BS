//
//  MJExtensionConfig.m
//  BS
//
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "MJExtensionConfig.h"
#import <MJExtension.h>
#import "DZYTopic.h"

#import "DZYComment.h"
#import "DZYUser.h"

#import "DZYFollowCategory.h"

@implementation MJExtensionConfig

+ (void)load
{
    [DZYTopic setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1",
                 @"topComment" : @"top_cmt[0]"
                 };
    }];
    
    [DZYComment setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    
    [DZYFollowCategory setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
}

@end

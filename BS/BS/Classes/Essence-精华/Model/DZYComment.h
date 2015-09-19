//
//  DZYComment.h
//  BS
//
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DZYUser;
@interface DZYComment : NSObject

/** 文字内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (nonatomic, strong) DZYUser *user;

@end

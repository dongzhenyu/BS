//
//  DZYTopic.h
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZYTopic : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;

/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;

/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;



@end

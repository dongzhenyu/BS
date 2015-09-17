//
//  DZYTopic.h
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZYTopic : NSObject

typedef enum {
    /** 图片 */
    DZYTopicTypePicture = 10,
    /** 段子(文字) */
    DZYTopicTypeWord = 29,
    /** 声音 */
    DZYTopicTypeVioce = 31,
    /** 视频 */
    DZYTopicTypeVideo = 41
    
} DZYTopicType;

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;

/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;

/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;

/** 顶数量 */
@property (nonatomic, assign) NSUInteger ding;

/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;

/** 转发/分享数量 */
@property (nonatomic, assign) NSInteger repost;

/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** type */
@property (nonatomic, assign) DZYTopicType type;

/** picture width */
@property (nonatomic, assign) CGFloat width;

/** picture height */
@property (nonatomic, assign) CGFloat height;

@end

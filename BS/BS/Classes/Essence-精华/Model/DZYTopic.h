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

/** ID */
@property (nonatomic, copy) NSString *ID; // id

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

/** 小图 */
@property (nonatomic, copy) NSString *small_image; // image0
/** 大图 */
@property (nonatomic, copy) NSString *large_image; // image1
/** 中图 */
@property (nonatomic, copy) NSString *middle_image; // image2

/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;

/** 视频的时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 声音的时长 */
@property (nonatomic, assign) NSInteger viocetime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** 最热评论 (这个数组里面存放的应该是DZYComment模型)*/
@property (nonatomic, strong) NSArray *top_cmt;


/**** 额外添加的属性 *****/
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentFrame;
/** 是否是大图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;




@end

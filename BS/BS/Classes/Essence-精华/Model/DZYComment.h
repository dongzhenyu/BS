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

/** 点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 语音文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;

/** 语音文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

@end

//
//  DZYFollowUser.h
//  BS
//
//  Created by dzy on 15/9/22.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZYFollowUser : NSObject

/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;

/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

/** 头像 */
@property (nonatomic, copy) NSString *header;
@end

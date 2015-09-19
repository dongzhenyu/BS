//
//  DZYUser.h
//  BS
//
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZYUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;

/** 性别 */
@property (nonatomic, copy) NSString *sex;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end

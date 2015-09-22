//
//  DZYFollowCategory.h
//  BS
//
//  Created by dzy on 15/9/21.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZYFollowCategory : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 当前的页码 */
@property (nonatomic, assign) NSInteger page;
/** 这组用户的总数 */
@property (nonatomic, assign) NSInteger total;
@end

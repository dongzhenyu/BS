//
//  NSDate+DZYExtension.h
//  BS
//
//  Created by dzy on 15/9/15.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DZYExtension)

- (NSDateComponents *)intervalToDate:(NSDate *)date;
- (NSDateComponents *)intervalToNow;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否是昨天
 */
- (BOOL)isYesterday;

/**
 *  是否是明天
 */
- (BOOL)isTomorrow;

@end

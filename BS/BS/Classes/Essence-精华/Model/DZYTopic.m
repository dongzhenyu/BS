//
//  DZYTopic.m
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTopic.h"

@implementation DZYTopic

- (NSString *)created_at
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // NSString - > NSDate
    NSDate *createdAtDate = [fmt dateFromString:_created_at];
    
    // 比较发帖时间 和手机当前 时间的差值
    NSDateComponents *cmps = [createdAtDate intervalToNow];
    
    if (createdAtDate.isThisYear) {
        if (createdAtDate.isToday) { // 今天
            if (cmps.hour >= 1) { // 时间差距大于1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1分钟 =< 时
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        } else { // 今年的其他时间
           fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return _created_at;
    }
}

@end

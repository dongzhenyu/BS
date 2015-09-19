//
//  DZYTopic.m
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYTopic.h"
#import <MJExtension.h>
#import "DZYComment.h"
#import "DZYUser.h"

@implementation DZYTopic

#pragma mark - MJExtension
/**
 * 映射 - 属性名-字典Key的映射（key-mapping）
 */

//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"ID":@"id",
//             @"small_image":@"image0",
//             @"middle_image":@"image2",
//             @"large_image":@"image1",
//             @"topComment":@"top_cmt[0]"
//             };
//}

//+ (NSDictionary *)objectClassInArray
//{
//    // 数组名：模型名
//    return @{@"top_cmt" : [DZYComment class]};
////    return @{@"top_cmt":@"DZYComment"};
//}


#pragma mark - getter
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

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        
        // cell的高度
        _cellHeight = DZYTopicTextY;
        
        // 计算文字的高度
        CGFloat textW = DZYScreenW - 2 * DZYCommonMargin;
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight += textH + DZYCommonMargin;
        
        // 中间内容的高度
        if (self.type != DZYTopicTypeWord) {
            CGFloat contentW = textW;
            // 图片高度 * 内容宽度 / 图片的宽度
            CGFloat contentH = self.height * contentW / self.width;
            if (contentH >= DZYScreenH) {// 一旦内容的高度大于屏幕的高度 就让内容的高度等于200
                contentH = 200;
                self.bigPicture = YES;
            }
            CGFloat contentX = DZYCommonMargin;
            CGFloat contentY = _cellHeight;
            self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
            _cellHeight += contentH + DZYCommonMargin;
        }
        
        // 最热评论
//        DZYComment *cmt = self.topComment;
        if (self.topComment) {
            NSString *username = self.topComment.user.username;
            NSString *content = self.topComment.content;
            NSString *cmtText = [NSString stringWithFormat:@"%@:%@", username, content];
            // 评论内容的高度
            CGFloat cmtTextH = [cmtText boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
            _cellHeight += DZYTopicTopCmtTopH + cmtTextH + DZYCommonMargin;
        }
        
        // 底部工具条的高度
        _cellHeight += DZYTopicToolbarH + DZYCommonMargin;
        
    }
    return _cellHeight;
    
}

@end

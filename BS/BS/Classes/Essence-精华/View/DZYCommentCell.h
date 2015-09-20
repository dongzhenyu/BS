//
//  DZYCommentCell.h
//  BS
//
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZYComment;
@interface DZYCommentCell : UITableViewCell

/** 评论模型数据 */
@property (nonatomic, strong) DZYComment *comment;

@end

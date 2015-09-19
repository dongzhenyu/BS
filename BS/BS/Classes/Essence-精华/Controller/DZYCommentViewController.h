//
//  DZYCommentViewController.h
//  BS
//
//  Created by dzy on 15/9/19.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZYTopic;
@interface DZYCommentViewController : UIViewController

/** 帖子模型 */
@property (nonatomic, strong) DZYTopic *topic;
@end

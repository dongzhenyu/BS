//
//  DZYTopicViewController.h
//  BS
//
//  Created by dzy on 15/9/20.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZYTopic.h"

@interface DZYTopicViewController : UITableViewController

/** 帖子的类型 */
- (DZYTopicType)type;

//@property (nonatomic, assign) DZYTopicType type;// 外界可以修改类型 不安全

@end

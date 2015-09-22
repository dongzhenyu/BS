//
//  DZYUserCell.h
//  BS
//
//  Created by dzy on 15/9/21.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZYFollowUser;
@interface DZYUserCell : UITableViewCell

/** 用户模型 */
@property (nonatomic, strong) DZYFollowUser *user;
@end

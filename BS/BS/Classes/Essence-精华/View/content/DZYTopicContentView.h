//
//  DZYTopicContentView.h
//  BS
//
//  Created by dzy on 15/9/20.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZYTopic;
@interface DZYTopicContentView : UIView
{
    __weak UIImageView *_imageView;
}
/** 帖子模型 */
@property (nonatomic, strong) DZYTopic *topic;
@end

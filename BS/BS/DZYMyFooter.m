//
//  DZYMyFooter.m
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYMyFooter.h"

@implementation DZYMyFooter

- (void)prepare
{
    [super prepare];
    
    UISwitch *s = [[UISwitch alloc] init];
    s.on = YES;
    [self addSubview:s];
}

@end

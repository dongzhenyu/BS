//
//  DZYAllViewController.m
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYAllViewController.h"

@interface DZYAllViewController ()

@end

@implementation DZYAllViewController

/**
 *  要想让一个scrollView能够穿透整个屏幕 那么设置它的frame占据整个屏幕
    要想让一个scrollView能够完全显示 那么设置它的contentInset属性
 */

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = DZYCommonBgColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(DZYNavBarMaxY + DZYTitlesViewH, 0, DZYTabBarH, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"all";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", self.title, indexPath.row];
    
    return cell;
}


@end

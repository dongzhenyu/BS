//
//  DZYWordViewController.m
//  BS
//
//  Created by dzy on 15/9/14.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "DZYWordViewController.h"

@interface DZYWordViewController ()

@end

@implementation DZYWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = DZYCommonBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(DZYNavBarMaxY + DZYTitlesViewH, 0, DZYTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;}

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

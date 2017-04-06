//
//  XMGWordViewController.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/30.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGWordViewController.h"

@interface XMGWordViewController ()

@end

@implementation XMGWordViewController
- (XMGTopicType)type
{
    return XMGTopicTypeWord;
}
/*- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMGLogFunc
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.确定重用标示:
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = XMGRandomColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", [self class], indexPath.row];
    
    return cell;
}*/

@end

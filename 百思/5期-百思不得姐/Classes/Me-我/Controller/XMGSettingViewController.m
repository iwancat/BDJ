//
//  XMGSettingViewController.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/6.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGSettingViewController.h"
#import "XMGTestViewController.h"
#import "XMGClearCacheCell.h"
#import "XMGOtherCell.h"

@interface XMGSettingViewController ()

@end

@implementation XMGSettingViewController

static NSString * const XMGClearCacheCellId = @"XMGClearCacheCell";
static NSString * const XMGSettingCellId = @"XMGSettingCell";
static NSString * const XMGOtherCellId = @"XMGOtherCell";

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XMGCommonBgColor;
    self.navigationItem.title = @"设置";
    [self.tableView registerClass:[XMGClearCacheCell class] forCellReuseIdentifier:XMGClearCacheCellId];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:XMGSettingCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGOtherCell class]) bundle:nil] forCellReuseIdentifier:XMGOtherCellId];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    XMGTestViewController *test = [[XMGTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 10;
    if (section == 1) return 5;
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0 &&indexPath.section == 0){
        //        XMGClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGClearCacheCellId];
        //
        //        // cell重新显示的时候, 继续转圈圈
        //        UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)cell.accessoryView;
        //        [loadingView startAnimating];
        //
        //        return cell;
        // 返回cell
        return [tableView dequeueReusableCellWithIdentifier:XMGClearCacheCellId];
    }else if(indexPath.row ==2){
       return [tableView dequeueReusableCellWithIdentifier:XMGOtherCellId];
    }
    // 其他cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGSettingCellId];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd", indexPath.section, indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGLogFunc
    //判断是何种cell
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if ([cell isKindOfClass:[XMGOtherCell class]]) {
//        
//    }

}

@end
#pragma mark 用于计算文件夹大小的方法
/*
 - (void)getCacheSize
 {
 // 总大小
 unsigned long long size = 0;
 
 // 获得缓存文件夹路径
 NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
 NSString *dirpath = [cachesPath stringByAppendingPathComponent:@"default"];
 //    XMGLog(@"%@", dirpath);
 
 // 文件管理者
 NSFileManager *mgr = [NSFileManager defaultManager];
 
 // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
 // Enumerator : 遍历器\迭代器
 NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:dirpath];
 for (NSString *subpath in enumerator) {
 // 全路径
 NSString *fullSubpath = [dirpath stringByAppendingPathComponent:subpath];
 // 累加文件大小
 size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
 }
 
 XMGLog(@"%zd", size);
 }
 - (void)getCacheSize2
 {
 // 总大小
 unsigned long long size = 0;
 
 // 获得缓存文件夹路径
 NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
 XMGLog(@"----%@-----",cachesPath);
 
 NSString *dirpath = [cachesPath stringByAppendingPathComponent:@"MP3"];
 
 // 文件管理者
 NSFileManager *mgr = [NSFileManager defaultManager];
 
 // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
 //        XMGLog(@"contents - %@", [mgr contentsOfDirectoryAtPath:dirpath error:nil]);
 NSArray *subpaths = [mgr subpathsAtPath:dirpath];
 XMGLog(@"----subpaths%@-----",subpaths);
 for (NSString *subpath in subpaths) {
 // 全路径
 NSString *fullSubpath = [dirpath stringByAppendingPathComponent:subpath];
 // 累加文件大小
 size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
 
 //        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
 //        size += [attrs[NSFileSize] unsignedIntegerValue];
 }
 
 XMGLog(@"%zd", size);
 }*/

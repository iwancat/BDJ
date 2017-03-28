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
@interface XMGSettingViewController ()

@end

@implementation XMGSettingViewController

static NSString * const XMGClearCacheCellId = @"XMGClearCacheCell";
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XMGCommonBgColor;
    self.navigationItem.title = @"设置";
    [self.tableView registerClass:[XMGClearCacheCell class] forCellReuseIdentifier:XMGClearCacheCellId];
}

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
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    XMGTestViewController *test = [[XMGTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出cell
    XMGClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGClearCacheCellId];
    
    // 返回cell
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGLogFunc
}

@end

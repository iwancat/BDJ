//
//  XMGTopicViewController.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/16.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGTopicViewController.h"
#import "XMGHTTPSessionManager.h"
#import "XMGTopic.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "XMGRefreshHeader.h"
#import "XMGRefreshFooter.h"
#import "XMGTopicCell.h"
#import "XMGNewViewController.h"
#import "XMGCommentViewController.h"

@interface XMGTopicViewController ()
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<XMGTopic *> *topics;
/** 下拉刷新的提示文字 */
@property (nonatomic, weak) UILabel *label;
/** maxtime : 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
/** 任务管理者 */
@property (nonatomic, strong) XMGHTTPSessionManager *manager;

/** 声明这个方法的目的 : 为了能够使用点语法的智能提示 */
- (NSString *)aParam;
@end

@implementation XMGTopicViewController

#pragma mark - 仅仅是为了消除编译器发出的警告 : type方法没有实现
- (XMGTopicType)type {
    return 0;
}

static NSString * const XMGTopicCellId = @"topic";
#pragma mark - 懒加载
- (XMGHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [XMGHTTPSessionManager manager];
    }
    return _manager;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupRefresh];
}

- (void)setupTable
{
    self.tableView.backgroundColor = XMGCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:XMGTopicCellId];
    // self.tableView.rowHeight = 250;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [XMGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (NSString *)aParam
{
//    if ([NSStringFromClass(self.parentViewController.class) isEqualToString:@"XMGNewViController"]) {
//        return @"newlist";
//    }
//    return @"list";
    
    if (self.parentViewController.class == [XMGNewViewController class]) {
        return @"newlist";
    }
    return @"list";
    
//    if ([self.parentViewController isKindOfClass:[XMGNewViewController class]]) {
//        return @"newlist";
//    }
//    return @"list";
    
    // 错误做法
//    if ([self.parentViewController isKindOfClass:[XMGEssenceViewController class]]) {
//        return @"list";
//    }
//    return @"newlist";
}

#pragma mark - 数据加载
- (void)loadNewTopics
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
//    if ([NSStringFromClass(self.class) isEqualToString:@"XMGAllViewController"]) {
//        params[@"type"] = @"1";
//    } else if ([NSStringFromClass(self.class) isEqualToString:@"XMGVideoViewController"]) {
//        params[@"type"] = @"41";
//    } else if ([NSStringFromClass(self.class) isEqualToString:@"XMGVoiceViewController"]) {
//        params[@"type"] = @"31";
//    } else if ([NSStringFromClass(self.class) isEqualToString:@"XMGPictureViewController"]) {
//        params[@"type"] = @"10";
//    } else if ([NSStringFromClass(self.class) isEqualToString:@"XMGWordViewController"]) {
//        params[@"type"] = @"29";
//    }
    
    // 发送请求
    [self.manager GET:XMGCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 存储maxtime(方便用来加载下一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics
{
    // 取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @(self.type);
//    if ([NSStringFromClass(self.class) isEqualToString:@"XMGAllViewController"]) {
//        params[@"type"] = @"1";
//    } else if ([NSStringFromClass(self.class) isEqualToString:@"XMGVideoViewController"]) {
//        params[@"type"] = @"41";
//    } else if ([NSStringFromClass(self.class) isEqualToString:@"XMGVoiceViewController"]) {
//        params[@"type"] = @"31";
//    } else if ([NSStringFromClass(self.class) isEqualToString:@"XMGPictureViewController"]) {
//        params[@"type"] = @"10";
//    } else if ([NSStringFromClass(self.class) isEqualToString:@"XMGWordViewController"]) {
//        params[@"type"] = @"29";
//    }
    
    // 发送请求
    [self.manager GET:XMGCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 存储这页对应的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        NSArray<XMGTopic *> *moreTopics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCommentViewController *comment = [[XMGCommentViewController alloc] init];
    [self.navigationController pushViewController:comment animated:YES];
}
@end
